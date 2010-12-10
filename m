Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBACJBEx009474
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 07:19:11 -0500
Received: from house.lunarmania.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBACJA4B023095
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 12:19:10 GMT
Message-ID: <4D021AB0.9040900@rubix.com>
Date: Fri, 10 Dec 2010 13:18:56 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] [PATCH] New database object classes
References: <4D01F7A4.90708@ak.jp.nec.com>
In-Reply-To: <4D01F7A4.90708@ak.jp.nec.com>
Content-Type: multipart/alternative;
 boundary="------------050104050307070207050108"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050104050307070207050108
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



On 12/10/2010 10:49 AM, KaiGai Kohei wrote:
> The attached patch adds a few database object classes, as follows:
>
> * db_schema
> ------------
> A schema object performs as a namespace in database; similar to
> directories in filesystem.
> It seems some of (but not all) database objects are stored within
> a certain schema logically. We can qualify these objects using
> schema name. For example, a table: "my_tbl" within a schema: "my_scm"
> is identified by "my_scm.my_tbl". This table is completely different
> from "your_scm.my_tbl" that it a table within a schema: "your_scm".
> Its characteristics is similar to a directory in filesystem, so
> it has similar permissions.
> The 'search' controls to resolve object name within a schema.
> The 'add_name' and 'remove_name' controls to add/remove an object
> to/from a schema.
> See also,
>   http://developer.postgresql.org/pgdocs/postgres/sql-createschema.html
>
> In the past discussion, a rubix folks concerned about no object
> class definition for schema and catalog which is an upper level
> namespace. Since I'm not certain whether we have a disadvantage
> when 'db_schema' class is applied on catalog class, I don't add
> this definition yet.

>From my point of view, as a rubix folk, I see no disadvantage in using
the db_schema class for catalogs. As we are now overloading the dir
object class, using the db_schema for both schemata and catalogs is an
improvement. For us in the foreseeable future, there is no functional
distinction.

I do think that the SQL spec does allow things to be associated with a
named schema that may not be associated with a catalog. For instance, a
character set. But, don't quote me on that:-)

Forgive me for my ignorance, but when a patch like this is submitted to
the refpolicy, will it eventually make it into Fedora and/or RHEL 6?

> Default security context of 'db_table' and 'db_procedure' classes
> get being computed using type_transition with 'db_schema' class,
> instead of 'db_database' class. It reflects logical hierarchy of
> database object more correctly.
>
>
> * db_view
> ----------
> A view object performs as a virtual table. We can run SELECT
> statement on views, although it has no physical entities.
> The definition of views are expanded in run-time, so it allows
> us to describe complex queries with keeping readability.
> This object class uniquely provides 'expand' permission that
> controls whether user can expand this view, or not.
> The default security context shall be computed by type transition
> rule with a schema object that owning the view.
>
> See also,
>   http://developer.postgresql.org/pgdocs/postgres/sql-createview.html
>
>
> * db_sequence
> --------------
> A sequence object is a sequential number generator.
> This object class uniquely provides 'get_value', 'next_value' and
> 'set_value' permissions. The 'get_value' controls to reference the
> sequence object. The 'next_value' controls to fetch and increment
> the value of sequence object. The 'set_value' controls to set
> an arbitrary value.
> The default security context shall be computed by type transition
> rule with a schema object that owning the sequence.
>
> See also,
>   http://developer.postgresql.org/pgdocs/postgres/sql-createsequence.html
>
>
> * db_language
> --------------
> A language object is an installed engine to execute procedures.
> PostgreSQL supports to define SQL procedures using regular script
> languages; such as Perl, Tcl, not only SQL or binary modules.
> In addition, v9.0 or later supports DO statement. It allows us to
> execute a script statement on server side without defining a SQL
> procedure. It requires to control whether user can execute DO
> statement on this language, or not.
> This object class uniquely provides 'implement' and 'execute'
> permissions. The 'implement' controls whether a procedure can
> be implemented with this language, or not. So, it takes security
> context of the procedure as subject. The 'execute' controls to
> execute code block using DO statement.
> The default security context shall be computed by type transition
> rule with a database object, because it is not owned by a certain
> schema.
>
> In the default policy, we provide two types: 'sepgsql_lang_t' and
> 'sepgsql_safe_lang_t' that allows unpriv users to execute DO
> statement. The default is 'sepgsql_leng_t'.
> We assume newly installed language may be harm, so DBA has to relabel
> it explicitly, if he want user defined procedures using the language.
>
> See also,
>   http://developer.postgresql.org/pgdocs/postgres/sql-createlanguage.html
>   http://developer.postgresql.org/pgdocs/postgres/sql-do.html
>
> P.S)
> I found a bug in MCS. It didn't constraint 'relabelfrom' permission
> of 'db_procedure' class. IIRC, I fixed it before, but it might be
> only MLS side. Sorry.
>
> Thanks,
>
>
> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy

--------------050104050307070207050108
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-2022-JP"
      http-equiv="Content-Type">
    <title></title>
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <br>
    <br>
    On 12/10/2010 10:49 AM, KaiGai Kohei wrote:
    <blockquote cite="mid:4D01F7A4.90708@ak.jp.nec.com" type="cite">
      <pre wrap="">The attached patch adds a few database object classes, as follows:

* db_schema
------------
A schema object performs as a namespace in database; similar to
directories in filesystem.
It seems some of (but not all) database objects are stored within
a certain schema logically. We can qualify these objects using
schema name. For example, a table: "my_tbl" within a schema: "my_scm"
is identified by "my_scm.my_tbl". This table is completely different
from "your_scm.my_tbl" that it a table within a schema: "your_scm".
Its characteristics is similar to a directory in filesystem, so
it has similar permissions.
The 'search' controls to resolve object name within a schema.
The 'add_name' and 'remove_name' controls to add/remove an object
to/from a schema.
See also,
  <a class="moz-txt-link-freetext" href="http://developer.postgresql.org/pgdocs/postgres/sql-createschema.html">http://developer.postgresql.org/pgdocs/postgres/sql-createschema.html</a>

In the past discussion, a rubix folks concerned about no object
class definition for schema and catalog which is an upper level
namespace. Since I'm not certain whether we have a disadvantage
when 'db_schema' class is applied on catalog class, I don't add
this definition yet.
</pre>
    </blockquote>
    <br>
    From my point of view, as a rubix folk, I see no disadvantage in
    using the db_schema class for catalogs. As we are now overloading
    the dir object class, using the db_schema for both schemata and
    catalogs is an improvement. For us in the foreseeable future, there
    is no functional distinction. <br>
    <br>
    I do think that the SQL spec does allow things to be associated with
    a named schema that may not be associated with a catalog. For
    instance, a character set. But, don't quote me on that:-)<br>
    <br>
    Forgive me for my ignorance, but when a patch like this is submitted
    to the refpolicy, will it eventually make it into Fedora and/or RHEL
    6?<br>
    <br>
    <blockquote cite="mid:4D01F7A4.90708@ak.jp.nec.com" type="cite">
      <pre wrap="">
Default security context of 'db_table' and 'db_procedure' classes
get being computed using type_transition with 'db_schema' class,
instead of 'db_database' class. It reflects logical hierarchy of
database object more correctly.


* db_view
----------
A view object performs as a virtual table. We can run SELECT
statement on views, although it has no physical entities.
The definition of views are expanded in run-time, so it allows
us to describe complex queries with keeping readability.
This object class uniquely provides 'expand' permission that
controls whether user can expand this view, or not.
The default security context shall be computed by type transition
rule with a schema object that owning the view.

See also,
  <a class="moz-txt-link-freetext" href="http://developer.postgresql.org/pgdocs/postgres/sql-createview.html">http://developer.postgresql.org/pgdocs/postgres/sql-createview.html</a>


* db_sequence
--------------
A sequence object is a sequential number generator.
This object class uniquely provides 'get_value', 'next_value' and
'set_value' permissions. The 'get_value' controls to reference the
sequence object. The 'next_value' controls to fetch and increment
the value of sequence object. The 'set_value' controls to set
an arbitrary value.
The default security context shall be computed by type transition
rule with a schema object that owning the sequence.

See also,
  <a class="moz-txt-link-freetext" href="http://developer.postgresql.org/pgdocs/postgres/sql-createsequence.html">http://developer.postgresql.org/pgdocs/postgres/sql-createsequence.html</a>


* db_language
--------------
A language object is an installed engine to execute procedures.
PostgreSQL supports to define SQL procedures using regular script
languages; such as Perl, Tcl, not only SQL or binary modules.
In addition, v9.0 or later supports DO statement. It allows us to
execute a script statement on server side without defining a SQL
procedure. It requires to control whether user can execute DO
statement on this language, or not.
This object class uniquely provides 'implement' and 'execute'
permissions. The 'implement' controls whether a procedure can
be implemented with this language, or not. So, it takes security
context of the procedure as subject. The 'execute' controls to
execute code block using DO statement.
The default security context shall be computed by type transition
rule with a database object, because it is not owned by a certain
schema.

In the default policy, we provide two types: 'sepgsql_lang_t' and
'sepgsql_safe_lang_t' that allows unpriv users to execute DO
statement. The default is 'sepgsql_leng_t'.
We assume newly installed language may be harm, so DBA has to relabel
it explicitly, if he want user defined procedures using the language.

See also,
  <a class="moz-txt-link-freetext" href="http://developer.postgresql.org/pgdocs/postgres/sql-createlanguage.html">http://developer.postgresql.org/pgdocs/postgres/sql-createlanguage.html</a>
  <a class="moz-txt-link-freetext" href="http://developer.postgresql.org/pgdocs/postgres/sql-do.html">http://developer.postgresql.org/pgdocs/postgres/sql-do.html</a>

P.S)
I found a bug in MCS. It didn't constraint 'relabelfrom' permission
of 'db_procedure' class. IIRC, I fixed it before, but it might be
only MLS side. Sorry.

Thanks,
</pre>
      <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
refpolicy mailing list
<a class="moz-txt-link-abbreviated" href="mailto:refpolicy@oss.tresys.com">refpolicy@oss.tresys.com</a>
<a class="moz-txt-link-freetext" href="http://oss.tresys.com/mailman/listinfo/refpolicy">http://oss.tresys.com/mailman/listinfo/refpolicy</a>
</pre>
    </blockquote>
  </body>
</html>

--------------050104050307070207050108--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
