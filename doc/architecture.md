Bildhaus image server: architecture
===================================

The aim
-------

bildhaus (_working name_) is a HTTP image server focused on the
long-time preservation of image files. The purpose of bildhaus
is to provide _stable_ URLs for image files that have been uploaded
and for additional generated versions of the same image (e.g.
thumbnails, low-resolution JPEGs, etc.).

_Stable_ URLs are URLs that will be [dereferenceable][1] via HTTP for
the foreseeable future.

[1]: http://www.w3.org/2001/tag/doc/httpRange-14/2007-08-31/HttpRange-14.html "Dereferencing HTTP URIs"

Building pieces
---------------

There are four conceptual parts to Bildhaus:

1. the resolver of the URLs,
2. the uploader and converter of the image files,
3. the storage of the files,
4. a database that contains the location of each image version.

The URL resolver is a publicly available HTTP service that responds to
requests for URLs. What the resolver does is to decode these URLs,
understand which image and in which image is being requested and search
the database for an appropriate location, be it local (on the file
system) or remote (available as at another HTTP URL).

The uploader takes care of ingesting the image files, storing them
somewhere where they can be accessed by the URL resolver and recording
this location in the database. The uploader can also, if instructed to
do so, generate additional versions of the ingested images: for example
thumbnails or low-quality versions for online display.

The storage part is used by the uploader to store safely the original
images and the derived generated images. It takes care of calculating the
checksums of the files and, in general, checks that the files are
properly stored. It provides paths that can be stored in the database
and that the URL resolver can use.

Separation of concerns
----------------------

The URL resolver expects the location database to be already populated.
The URL resolver leaves this task to the uploader part and does not
concern itself with how the databases has been populated.

Similarly, URL resolver do not care for how the files are stored in
the local filesystem or remotely. It only needs a valid file path
or HTTP URL.

Constraints
-----------

To avoid unnecessary complexities, bildhaus imposes some constraints
in the names of the uploaded images:

* no two consecutive hyphens (`--`) are allowed,
* forward slashes are not allowed (`/`) (no hierarchical
  structures in names, in other words).

Initial manual workflow
-----------------------

Thanks to the separation of concerns, it is not necessary to write an
automated uploader right from the beginning. It is possible (and
suggested) to start populating the database with a semi-manual script
that stores all the generated files in the local filesystem and records
the association between the image versions and the file paths directly
in the database.
