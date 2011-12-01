Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1KP58I001581
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 15:25:08 -0500
Received: from mail-vx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB1KOu0g022045
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 20:25:07 GMT
Received: by mail-vx0-f181.google.com with SMTP id fl17so2088953vcb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Dec 2011 12:25:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322756390.65264.YahooMailClassic@web87001.mail.ird.yahoo.com>
References: <1322756390.65264.YahooMailClassic@web87001.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 15:25:06 -0500
Message-ID: <CACLa4pvYWY5h9KJ9Z0G+L4aEa-HKKmK2e8S47WHHCuOqUgQQ0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux: Updated selabel_db(5) man page
From: Eric Paris <eparis@parisplace.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Applied to devel branch.

On Thu, Dec 1, 2011 at 11:19 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Updated selabel_db(5) with RDBMS context configuration file format and added sepgsql_contexts(5) man page that links to it.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/man/man5/selabel_db.5       |  175 +++++++++++++++++++++++++-------
>  libselinux/man/man5/sepgsql_contexts.5 |    1 +
>  2 files changed, 141 insertions(+), 35 deletions(-)
>  create mode 100644 libselinux/man/man5/sepgsql_contexts.5
>
> diff --git a/libselinux/man/man5/selabel_db.5 b/libselinux/man/man5/selabel_db.5
> index b699f39..c809d18 100644
> --- a/libselinux/man/man5/selabel_db.5
> +++ b/libselinux/man/man5/selabel_db.5
> @@ -1,38 +1,39 @@
>  .\" Hey Emacs! This file is -*- nroff -*- source.
>  .\"
>  .\" Author: KaiGai Kohei <kaigai@ak.jp.nec.com> 2009
> -.TH "selabel_db" "5" "22 Nov 2009" "" "SELinux API documentation"
> +.TH "selabel_db" "5" "01 DEC 2011" "Security Enhanced Linux" "SELinux API documentation"
>  .SH "NAME"
> -selabel_db \- userspace SELinux labeling interface: DB objects contexts backend.
> +selabel_db \- userspace SELinux labeling interface and configuration file format for the RDBMS objects context backend.
>  .SH "SYNOPSIS"
> -.B #include <selinux/selinux.h>
> -
> -.B #include <selinux/label.h>
> +..B #include <selinux/label.h>
>  .sp
>  .BI "int selabel_lookup(struct selabel_handle *" hnd ,
>  .in +\w'int selabel_lookup('u
>  .BI "security_context_t *" context ,
> -
> +.br
> +.BI "const char *" object_name ", int " object_type ");"
> +.in
> +.sp
> +.BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
> +.in +\w'int selabel_lookup('u
> +.BI "security_context_t *" context ,
> +.br
>  .BI "const char *" object_name ", int " object_type ");"
>
>  .SH "DESCRIPTION"
> -The DB contexts backend maps from a pair of object name and class into security contexts. It is used to find the appropriate context for database objects when relabeling a certain database.
> -
> -The
> -.I object_name
> -should be fully qualified name using the hierarchy of database objects.
> -For example, the
> -.B pg_class
> -table in the
> -.B postgres
> -database and
> -.B pg_catalog
> -schema should be qualified as
> -.B postgres.pg_catalog.pg_class .
> -
> -The
> -.I object_type
> -argument should be set to one of the following values:
> +The DB contexts backend maps from a pair of object name and class into security contexts. It is used to find the appropriate context for database objects when relabeling a certain database. The returned \fIcontext\fR must be freed using \fBfreecon\fR(3).
> +.br
> +\fBselabel_lookup\fR(3) describes the function with its return and error codes.
> +.sp
> +The \fIobject_name\fR should be a fully qualified name using the hierarchy of database objects. For example, the \fBpg_class\fR table in the \fBpostgres\fR database and \fBpg_catalog\fR schema should be qualified as:
> +.RS
> +.B Bpostgres.pg_catalog.pg_class
> +.RE
> +.sp
> +The \fBNOTES\fR section has further information on database support for namespace hierarchies.
> +.sp
> +The \fIobject_type\fR argument should be set to one of the following values:
> +.RS
>  .TP
>  .B SELABEL_DB_DATABASE
>  The
> @@ -62,7 +63,7 @@ argument specifies the name of a table object which contains the tuples to be re
>  .B SELABEL_DB_PROCEDURE
>  The
>  .I object_name
> -argument specifies the name of a procedure object, such as "postgres.public.my_func". Note that we don't support to lookup individual security contexts for each procedures which have same name but different arguments.
> +argument specifies the name of a procedure object, such as "postgres.public.my_func". Note that we don't support lookup of individual security contexts for procedures which have the same name but different arguments.
>  .TP
>  .B SELABEL_DB_SEQUENCE
>  The
> @@ -73,21 +74,125 @@ argument specifies the name of a sequence object, such as "postgres.public.my_se
>  The
>  .I object_name
>  argument specifies the name of a large object, such as "postgres.16308".
> -Note that a large object does not have its name, so it is identified by its identifier value.
> +Note that a large object does not have a name, so it is identified by its identifier value.
> +.TP
> +.B SELABEL_DB_VIEW
> +The
> +.I object_name
> +argument specifies the name of a view object, such as "postgres.public.my_view".
> +.TP
> +.B SELABEL_DB_LANGUAGE
> +The
> +.I object_name
> +argument specifies the name of a language object, such as "postgres.public.tcl".
> +.RE
> +.sp
> +Any messages generated by \fBselabel_lookup\fR are sent to \fIstderr\fR by default, although this can be changed by \fBselinux_set_callback\fR(3).
> +.sp
> +.B selabel_lookup_raw
> +behaves identically to \fBselabel_lookup\fR but does not perform context translation.
> +.sp
> +The \fBFILES\fR section details the configuration files used to determine the database object context.
>
>  .SH "OPTIONS"
> -In addition to the global options described in
> -.BR selabel_open (3),
> -this backend recognizes the following options:
> -
> +In addition to the global options described in \fBselabel_open\fR(3), this backend recognizes the following options:
> +.RS
>  .TP
>  .B SELABEL_OPT_PATH
>  A non-null value for this option specifies a path to a file that will be opened in lieu of the standard DB contexts file.
> -It tries to open the specfile designed for SE-PostgreSQL in the default, so if another RDBMS uses this interface, it needs to give an explicit specfile designed for the RDBMS.
> +It tries to open the specfile designed for SE-PostgreSQL as default, so if another RDBMS uses this interface, it needs to give an explicit specfile designed for that RDBMS (see the \fBFILES\fR section for details).
> +.RE
>
> -.SH "SEE ALSO"
> -.BR selabel_open (3),
> -.BR selabel_lookup (3),
> -.BR selabel_stats (3),
> -.BR selinux (8)
> +.SH "FILES"
> +The database context file used to retrieve a context depends on the \fBSELABEL_OPT_PATH\fR parameter passed to \fBselabel_open\fR(3). If \fINULL\fR, then the \fBSELABEL_OPT_PATH\fR value will default to the active policy database contexts location (as returned by \fBselinux_sepgsql_context_path\fR(3)), otherwise the actual \fBSELABEL_OPT_PATH\fR value specified is used (this option must be used to support databases other than SE-PostgreSQL).
> +.sp
> +The default database object contexts file is:
> +.RS
> +.I /etc/selinux/{SELINUXTYPE}/contexts/sepgsql_context
> +.RE
> +.sp
> +Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
> +.sp
> +The entries within the database contexts file are shown in the \fBObject Name String Values\fR and \fBFILE FORMAT\fR sections.
> +
> +.SH "Object Name String Values"
> +The string name assigned to each \fIobject_type\fR argument that can be present in the database contexts file are:
> +.TS
> +center, allbox, tab(@);
> +lI lB
> +lB l .
> +object_type@Text Name
> +SELABEL_DB_DATABASE@db_database
> +SELABEL_DB_SCHEMA@db_schema
> +SELABEL_DB_VIEW@db_view
> +SELABEL_DB_LANGUAGE@db_language
> +SELABEL_DB_TABLE@db_table
> +SELABEL_DB_COLUMN@db_column
> +SELABEL_DB_TUPLE@db_tuple
> +SELABEL_DB_PROCEDURE@db_procedure
> +SELABEL_DB_SEQUENCE@db_sequence
> +SELABEL_DB_BLOB@db_blob
> +.TE
>
> +.SH "FILE FORMAT"
> +Each line within the database contexts file is as follows:
> +.RS
> +.I object_type object_name context
> +.RE
> +.sp
> +Where:
> +.RS
> +.I object_type
> +.RS
> +This is the string representation of the object type shown in the \fBObject Name String Values\fR section.
> +.RE
> +.I object_name
> +.RS
> +The key used to obtain the context based on the \fIobject_type\fR.
> +.sp
> +The entry can contain '*' for wildcard matching or '?' for substitution.
> +.sp
> +Note that if the '*' is used, then be aware that the order of entries in the file is important. The '*' on its own is used to ensure a default fallback context is assigned and should be the last entry in the \fIobject_type\fR block.
> +.RE
> +.I context
> +.RS
> +The security context that will be applied to the object.
> +.RE
> +.RE
> +.sp
> +The following example is for SE-PostgreSQL:
> +.sp
> +# ./contexts/sepgsql_contexts file
> +.br
> +# object_type  object_name   context
> +.br
> +db_database    my_database   system_u:object_r:sepgsql_db_t:s0
> +.br
> +db_database    *             system_u:object_r:sepgsql_db_t:s0
> +.br
> +db_schema      *.*           system_u:object_r:sepgsql_schema_t:s0
> +.br
> +db_tuple       row_low       system_u:object_r:sepgsql_table_t:s0
> +.br
> +db_tuple       row_high      system_u:object_r:sepgsql_table_t:s0:c1023
> +.br
> +db_tuple       *.*.*         system_u:object_r:sepgsql_table_t:s0
> +
> +.SH "NOTES"
> +.IP "1." 4
> +A suitable database contexts file needs to be written for the target RDBMS and the \fBSELABEL_OPT_PATH\fR option must be used in \fBselabel_open\fR(3) to load it.
> +.IP "2." 4
> +The hierarchy of the namespace for database objects depends on the RDBMS, however the \fIselabel*\fR interfaces do not have any specific support for a namespace hierarchy.
> +.sp
> +SE-PostgreSQL has a namespace hierarchy where a database is the top level object with the schema being the next level. Under the schema object there can be other types of objects such as tables and procedures. This hierarchy is supported as follows:
> +.RS
> +.RS
> +.sp
> +If a security context is required for "my_table" table in the "public" schema within the "postgres" database, then the \fBselabel_lookup\fR parameters for \fIobject_type\fR would be \fBSELABEL_DB_TABLE\fR and the \fIobject_name\fR would be "postgres.public.my_table", the security context (if available), would be returned in \fIcontext\fR.
> +.RE
> +.RE
> +.IP "3." 4
> +If contexts are to be validated, then the global option \fBSELABEL_OPT_VALIDATE\fR must be set before calling \fBselabel_open\fR(3). If this is not set, then it is possible for an invalid context to be returned.
> +
> +.SH "SEE ALSO"
> +.BR selinux "(8), " selabel_open "(3), " selabel_lookup "(3), " selabel_stats "(3), " selabel_close "(3), " selinux_set_callback "(3), " selinux_sepgsql_context_path "(3), " freecon "(3), " selinux_config "(5) "
> diff --git a/libselinux/man/man5/sepgsql_contexts.5 b/libselinux/man/man5/sepgsql_contexts.5
> new file mode 100644
> index 0000000..ec2bb47
> --- /dev/null
> +++ b/libselinux/man/man5/sepgsql_contexts.5
> @@ -0,0 +1 @@
> +.so man5/selabel_db.5
> --
> 1.7.7.1
>
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
