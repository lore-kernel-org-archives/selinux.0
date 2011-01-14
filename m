Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0EE3WEJ030300
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2011 09:03:32 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0EE3V43003052
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2011 14:03:31 GMT
Message-ID: <4D3057AC.3040903@redhat.com>
Date: Fri, 14 Jan 2011 09:03:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] [PATCH] New database object classes
References: <4D01F7A4.90708@ak.jp.nec.com> <4D2FEAE9.8080201@ak.jp.nec.com>
In-Reply-To: <4D2FEAE9.8080201@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/14/2011 01:19 AM, KaiGai Kohei wrote:
> How about getting inclusion of this patch?
> 
> These new object classes and corresponding rules are necessary
> to run SE-PostgreSQL based on the upcoming v9.1.
> 
> Because I gave the highest priority to upstream the feature,
> it will have a limited functionality set in this version.
> But several facilities to support label based mandatory access
> control have been upstreamed (such as SECURITY LABEL statement).
> It is quite worthful to run this version on the default security
> policy.
> 
> Thanks,
> 
> (2010/12/10 18:49), KaiGai Kohei wrote:
>> The attached patch adds a few database object classes, as follows:
>>
>> * db_schema
>> ------------
>> A schema object performs as a namespace in database; similar to
>> directories in filesystem.
>> It seems some of (but not all) database objects are stored within
>> a certain schema logically. We can qualify these objects using
>> schema name. For example, a table: "my_tbl" within a schema: "my_scm"
>> is identified by "my_scm.my_tbl". This table is completely different
>> from "your_scm.my_tbl" that it a table within a schema: "your_scm".
>> Its characteristics is similar to a directory in filesystem, so
>> it has similar permissions.
>> The 'search' controls to resolve object name within a schema.
>> The 'add_name' and 'remove_name' controls to add/remove an object
>> to/from a schema.
>> See also,
>>    http://developer.postgresql.org/pgdocs/postgres/sql-createschema.html
>>
>> In the past discussion, a rubix folks concerned about no object
>> class definition for schema and catalog which is an upper level
>> namespace. Since I'm not certain whether we have a disadvantage
>> when 'db_schema' class is applied on catalog class, I don't add
>> this definition yet.
>>
>> Default security context of 'db_table' and 'db_procedure' classes
>> get being computed using type_transition with 'db_schema' class,
>> instead of 'db_database' class. It reflects logical hierarchy of
>> database object more correctly.
>>
>>
>> * db_view
>> ----------
>> A view object performs as a virtual table. We can run SELECT
>> statement on views, although it has no physical entities.
>> The definition of views are expanded in run-time, so it allows
>> us to describe complex queries with keeping readability.
>> This object class uniquely provides 'expand' permission that
>> controls whether user can expand this view, or not.
>> The default security context shall be computed by type transition
>> rule with a schema object that owning the view.
>>
>> See also,
>>    http://developer.postgresql.org/pgdocs/postgres/sql-createview.html
>>
>>
>> * db_sequence
>> --------------
>> A sequence object is a sequential number generator.
>> This object class uniquely provides 'get_value', 'next_value' and
>> 'set_value' permissions. The 'get_value' controls to reference the
>> sequence object. The 'next_value' controls to fetch and increment
>> the value of sequence object. The 'set_value' controls to set
>> an arbitrary value.
>> The default security context shall be computed by type transition
>> rule with a schema object that owning the sequence.
>>
>> See also,
>>    http://developer.postgresql.org/pgdocs/postgres/sql-createsequence.html
>>
>>
>> * db_language
>> --------------
>> A language object is an installed engine to execute procedures.
>> PostgreSQL supports to define SQL procedures using regular script
>> languages; such as Perl, Tcl, not only SQL or binary modules.
>> In addition, v9.0 or later supports DO statement. It allows us to
>> execute a script statement on server side without defining a SQL
>> procedure. It requires to control whether user can execute DO
>> statement on this language, or not.
>> This object class uniquely provides 'implement' and 'execute'
>> permissions. The 'implement' controls whether a procedure can
>> be implemented with this language, or not. So, it takes security
>> context of the procedure as subject. The 'execute' controls to
>> execute code block using DO statement.
>> The default security context shall be computed by type transition
>> rule with a database object, because it is not owned by a certain
>> schema.
>>
>> In the default policy, we provide two types: 'sepgsql_lang_t' and
>> 'sepgsql_safe_lang_t' that allows unpriv users to execute DO
>> statement. The default is 'sepgsql_leng_t'.
>> We assume newly installed language may be harm, so DBA has to relabel
>> it explicitly, if he want user defined procedures using the language.
>>
>> See also,
>>    http://developer.postgresql.org/pgdocs/postgres/sql-createlanguage.html
>>    http://developer.postgresql.org/pgdocs/postgres/sql-do.html
>>
>> P.S)
>> I found a bug in MCS. It didn't constraint 'relabelfrom' permission
>> of 'db_procedure' class. IIRC, I fixed it before, but it might be
>> only MLS side. Sorry.
>>
>> Thanks,
>>
KaiGai, I believe we have your patches in Fedora and RHEL6, If not
please ping me to add them.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0wV6wACgkQrlYvE4MpobPLHQCfciB+vT9o1Vab6CQYy3N2THgY
6p8AoJHU8wl1B1XnkG48Su6kfLXI4UFM
=+aaW
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
