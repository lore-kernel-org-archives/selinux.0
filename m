Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q44HSWBG012145
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 13:28:32 -0400
Received: by lahc1 with SMTP id c1so2390747lah.12
        for <selinux@tycho.nsa.gov>; Fri, 04 May 2012 10:28:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADyhKSXv0fb+4cVoe-XfzCmccvTuBJKLyGAwbwpjsbAAh1-yZw@mail.gmail.com>
References: <CADyhKSUb0q06VGR5hEa5pKB-_n7Gn3OFzB_r5yASuVFGE4AJGQ@mail.gmail.com>
	<CADyhKSXv0fb+4cVoe-XfzCmccvTuBJKLyGAwbwpjsbAAh1-yZw@mail.gmail.com>
Date: Fri, 4 May 2012 19:28:32 +0200
Message-ID: <CADyhKSXpHMwn50xZdHxiKpZYqpG7_foDKaxfDtJcBZUm+kBoZQ@mail.gmail.com>
Subject: Re: [1/4] sepgsql - add connection pooling server support
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=f46d040710abdcd78d04bf393f8f
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

--f46d040710abdcd78d04bf393f8f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hmm... I found another miss at sepgsql_ranged_proc_t without
domain_dyntrans_type(). It didn't work well.

Please see the revised one. Thanks,

2012/5/4 Kohei KaiGai <kaigai@kaigai.gr.jp>:
> I noticed a miss on postgresql_unpriv_client() interface.
> Please check the newer one.
>
> Thanks,
>
> 2012/3/25 Kohei KaiGai <kaigai@kaigai.gr.jp>:
>> This patch provides a new trusted procedure type that allows to
>> switch the security label of database client, with interaction of new
>> sepgsql_setcon() function being supported at upcoming v9.2 release.
>>
>> The original idea was given by Joshua Brindle. The sepgsql_setcon()
>> provides an analogy of dynamic domain transition on operating system.
>> Although we don't give privileges to switch security label on confined
>> domains, but it allows to switch via trusted procedure.
>>
>> The new sepgsql_ranged_proc_exec_t is an entrypoint of
>> sepgsql_ranged_proc_t that has mcssetcats and mlsprocsetsl.
>>
>> We assume its typical usage is sepgsql_setcon() getting invoked
>> via trusted procedure that references secret credential tables at
>> beginning of the database session by connection pooling server.
>>
>> Usage example)
>>
>> (*) The credential table is labeled as "sepgsql_secret_table_t",
>> =A0 =A0 that holds a pair of username, credential and security context.
>>
>> postgres=3D# CREATE OR REPLACE FUNCTION client_switch(text)
>> =A0 =A0RETURNS bool LANGUAGE sql
>> =A0 =A0AS 'SELECT sepgsql_setcon(ucontext) FROM credential
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0WHERE uname =3D current_user AND ucred =3D $1=
';
>> CREATE FUNCTION
>> postgres=3D# SECURITY LABEL ON FUNCTION client_switch(text) IS
>> 'system_u:object_r:sepgsql_ranged_proc_exec_t:s0';
>> SECURITY LABEL
>> postgres=3D# CREATE OR REPLACE FUNCTION client_reset()
>> =A0 =A0RETURNS bool LANGUAGE sql AS 'SELECT sepgsql_setcon(NULL)';
>> CREATE FUNCTION
>> postgres=3D# SECURITY LABEL ON FUNCTION client_reset() IS
>> 'system_u:object_r:sepgsql_ranged_proc_exec_t:s0';
>> SECURITY LABEL
>>
>> Then, it shows a scenario to switch the client label via trusted procedu=
re.
>>
>> [alice@iwashi ~]$ psql postgres -q
>> postgres=3D# SELECT sepgsql_getcon();
>> =A0 =A0 =A0 sepgsql_getcon
>> ----------------------------
>> =A0staff_u:staff_r:staff_t:s0
>> (1 row)
>>
>> postgres=3D# SELECT * FROM info_c0;
>> ERROR: =A0SELinux: security policy violation
>> postgres=3D# SELECT * FROM info_c1;
>> ERROR: =A0SELinux: security policy violation
>> -- client have no permission neither info_c0 nor info_c1
>>
>> postgres=3D# SELECT client_switch('6384e2b2184bcbf58eccf10ca7a6563c');
>> =A0client_switch
>> ---------------
>> =A0t
>> (1 row)
>>
>> postgres=3D# SELECT sepgsql_getcon();
>> =A0 =A0 =A0 =A0sepgsql_getcon
>> -------------------------------
>> =A0staff_u:staff_r:staff_t:s0:c1
>> (1 row)
>>
>> postgres=3D# SELECT * FROM info_c0;
>> ERROR: =A0SELinux: security policy violation
>> postgres=3D# SELECT * FROM info_c1;
>> =A0a | =A0b
>> ---+-----
>> =A03 | xxx
>> =A04 | yyy
>> (2 rows)
>>
>> -- needless to say, credential table is not visible
>> postgres=3D# SELECT * FROM credential ;
>> ERROR: =A0SELinux: security policy violation
>>
>> Also see,
>> http://git.postgresql.org/gitweb/?p=3Dpostgresql.git;a=3Dcommit;h=3D5231=
76cbf14a3414170a83dd43686c0eccdc61c6
>>
>> =A0Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
>> --
>> =A0policy/modules/services/postgresql.if | =A0 32 ++++++++++++++++++++++=
+++++++++-
>> =A0policy/modules/services/postgresql.te | =A0 32 ++++++++++++++++++++++=
++++++----
>> =A02 files changed, 59 insertions(+), 5 deletions(-)
>>
>> diff --git a/policy/modules/services/postgresql.if
>> b/policy/modules/services/postgresql.if
>> index 09aeffa..24e9958 100644
>> --- a/policy/modules/services/postgresql.if
>> +++ b/policy/modules/services/postgresql.if
>> @@ -32,6 +32,7 @@ interface(`postgresql_role',`
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0attribute sepgsql_schema_type, sepgsql_sy=
sobj_table_type;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type sepgsql_trusted_proc_exec_t, sepgsql=
_trusted_proc_t;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 type sepgsql_ranged_proc_exec_t, sepgsql_r=
anged_proc_t;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type user_sepgsql_blob_t, user_sepgsql_pr=
oc_exec_t;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type user_sepgsql_schema_t, user_sepgsql_=
seq_t;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type user_sepgsql_sysobj_t, user_sepgsql_=
table_t;
>> @@ -45,6 +46,7 @@ interface(`postgresql_role',`
>>
>> =A0 =A0 =A0 =A0typeattribute $2 sepgsql_client_type;
>> =A0 =A0 =A0 =A0role $1 types sepgsql_trusted_proc_t;
>> + =A0 =A0 =A0 role $1 types sepgsql_ranged_proc_t;
>>
>> =A0 =A0 =A0 =A0##############################
>> =A0 =A0 =A0 =A0#
>> @@ -88,6 +90,10 @@ interface(`postgresql_role',`
>>
>> =A0 =A0 =A0 =A0allow $2 sepgsql_trusted_proc_t:process transition;
>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_trusted_proc_exec_t:process se=
pgsql_trusted_proc_t;
>> +
>> + =A0 =A0 =A0 allow $2 sepgsql_ranged_proc_t:process transition;
>> + =A0 =A0 =A0 type_transition $2 sepgsql_ranged_proc_exec_t:process sepg=
sql_ranged_proc_t;
>> + =A0 =A0 =A0 allow sepgsql_ranged_proc_t $2:process dyntransition;
>> =A0')
>>
>> =A0########################################
>> @@ -223,7 +229,7 @@ interface(`postgresql_view_object',`
>> =A0## </summary>
>> =A0## <param name=3D"type">
>> =A0## =A0 =A0 <summary>
>> -## =A0 =A0 Type marked as a database object type.
>> +## =A0 =A0 Type marked as a procedure object type.
>> =A0## =A0 =A0 </summary>
>> =A0## </param>
>> =A0#
>> @@ -237,6 +243,26 @@ interface(`postgresql_procedure_object',`
>>
>> =A0########################################
>> =A0## <summary>
>> +## =A0 =A0 Marks as a SE-PostgreSQL trusted procedure object type
>> +## </summary>
>> +## <param name=3D"type">
>> +## =A0 =A0 <summary>
>> +## =A0 =A0 Type marked as a trusted procedure object type.
>> +## =A0 =A0 </summary>
>> +## </param>
>> +#
>> +interface(`postgresql_trusted_procedure_object',`
>> + =A0 =A0 =A0 gen_require(`
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 attribute sepgsql_procedure_type;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 attribute sepgsql_trusted_procedure_type;
>> + =A0 =A0 =A0 ')
>> +
>> + =A0 =A0 =A0 typeattribute $1 sepgsql_procedure_type;
>> + =A0 =A0 =A0 typeattribute $1 sepgsql_trusted_procedure_type;
>> +')
>> +
>> +########################################
>> +## <summary>
>> =A0## =A0 =A0 Marks as a SE-PostgreSQL procedural language object type
>> =A0## </summary>
>> =A0## <param name=3D"type">
>> @@ -459,6 +485,10 @@ interface(`postgresql_unpriv_client',`
>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_trusted_proc_exec_t:process se=
pgsql_trusted_proc_t;
>> =A0 =A0 =A0 =A0allow $1 sepgsql_trusted_proc_t:process transition;
>>
>> + =A0 =A0 =A0 type_transition $1 sepgsql_ranged_proc_exec_t:process sepg=
sql_ranged_proc_t;
>> + =A0 =A0 =A0 allow $1 sepgsql_ranged_proc_t:process transition;
>> + =A0 =A0 =A0 allow sepgsql_ranged_proc_t $1:process dyntransition;
>> +
>> =A0 =A0 =A0 =A0tunable_policy(`sepgsql_enable_users_ddl',`
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0allow $1 unpriv_sepgsql_schema_t:db_schem=
a { create drop setattr };
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0allow $1 unpriv_sepgsql_table_t:db_table =
{ create drop setattr };
>> diff --git a/policy/modules/services/postgresql.te
>> b/policy/modules/services/postgresql.te
>> index 4d71f89..2457d10 100644
>> --- a/policy/modules/services/postgresql.te
>> +++ b/policy/modules/services/postgresql.te
>> @@ -70,6 +70,7 @@ attribute sepgsql_sysobj_table_type;
>> =A0attribute sepgsql_sequence_type;
>> =A0attribute sepgsql_view_type;
>> =A0attribute sepgsql_procedure_type;
>> +attribute sepgsql_trusted_procedure_type;
>> =A0attribute sepgsql_language_type;
>> =A0attribute sepgsql_blob_type;
>> =A0attribute sepgsql_module_type;
>> @@ -122,7 +123,10 @@ type sepgsql_table_t;
>> =A0postgresql_table_object(sepgsql_table_t)
>>
>> =A0type sepgsql_trusted_proc_exec_t;
>> -postgresql_procedure_object(sepgsql_trusted_proc_exec_t)
>> +postgresql_trusted_procedure_object(sepgsql_trusted_proc_exec_t)
>> +
>> +type sepgsql_ranged_proc_exec_t;
>> +postgresql_trusted_procedure_object(sepgsql_ranged_proc_exec_t)
>>
>> =A0type sepgsql_view_t;
>> =A0postgresql_view_object(sepgsql_view_t)
>> @@ -133,6 +137,26 @@ domain_type(sepgsql_trusted_proc_t)
>> =A0postgresql_unconfined(sepgsql_trusted_proc_t)
>> =A0role system_r types sepgsql_trusted_proc_t;
>>
>> +# Ranged Trusted Procedure Domain
>> +#
>> +# XXX - the purpose of this domain is to switch security context of
>> +# the database client using dynamic domain transition; typically,
>> +# used for connection pooling software that shall assign a security
>> +# context at beginning of the user session based on the credentials
>> +# being invisible from unprivileged domains.
>> +#
>> +type sepgsql_ranged_proc_t;
>> +domain_type(sepgsql_ranged_proc_t)
>> +postgresql_unconfined(sepgsql_ranged_proc_t)
>> +allow sepgsql_ranged_proc_t self:process { setcurrent };
>> +role system_r types sepgsql_ranged_proc_t;
>> +optional_policy(`
>> + =A0 =A0 =A0 mcs_process_set_categories(sepgsql_ranged_proc_t)
>> +')
>> +optional_policy(`
>> + =A0 =A0 =A0 mls_process_set_level(sepgsql_ranged_proc_t)
>> +')
>> +
>> =A0# Types for unprivileged client
>> =A0type unpriv_sepgsql_blob_t;
>> =A0postgresql_blob_object(unpriv_sepgsql_blob_t)
>> @@ -404,7 +428,7 @@ allow sepgsql_client_type
>> sepgsql_seq_t:db_sequence { getattr get_value next_val
>> =A0allow sepgsql_client_type sepgsql_view_t:db_view { getattr expand };
>>
>> =A0allow sepgsql_client_type sepgsql_proc_exec_t:db_procedure { getattr
>> execute install };
>> -allow sepgsql_client_type sepgsql_trusted_proc_exec_t:db_procedure {
>> getattr execute entrypoint };
>> +allow sepgsql_client_type sepgsql_trusted_procedure_type:db_procedure
>> { getattr execute entrypoint };
>>
>> =A0allow sepgsql_client_type sepgsql_lang_t:db_language { getattr };
>> =A0allow sepgsql_client_type sepgsql_safe_lang_t:db_language { getattr e=
xecute };
>> @@ -493,7 +517,7 @@ tunable_policy(`sepgsql_unconfined_dbadm',`
>> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_view_type:db_view *;
>>
>> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure=
 *;
>> - =A0 =A0 =A0 allow sepgsql_admin_type sepgsql_trusted_proc_exec_t:db_pr=
ocedure ~install;
>> + =A0 =A0 =A0 allow sepgsql_admin_type sepgsql_trusted_procedure_type:db=
_procedure ~install;
>> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_procedure_type:db_proced=
ure ~{
>> execute install };
>>
>> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_language_type:db_languag=
e ~implement;
>> @@ -528,7 +552,7 @@ allow sepgsql_unconfined_type sepgsql_view_type:db_v=
iew *;
>> =A0# unconfined domain is not allowed to invoke user defined procedure d=
irectly.
>> =A0# They have to confirm and relabel it at first.
>> =A0allow sepgsql_unconfined_type sepgsql_proc_exec_t:db_procedure *;
>> -allow sepgsql_unconfined_type
>> sepgsql_trusted_proc_exec_t:db_procedure ~install;
>> +allow sepgsql_unconfined_type
>> sepgsql_trusted_procedure_type:db_procedure ~install;
>> =A0allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure ~{
>> execute install };
>>
>> =A0allow sepgsql_unconfined_type sepgsql_language_type:db_language ~impl=
ement;
>>
>> --
>> KaiGai Kohei <kaigai@kaigai.gr.jp>
>
>
>
> --
> KaiGai Kohei <kaigai@kaigai.gr.jp>



--=20
KaiGai Kohei <kaigai@kaigai.gr.jp>

--f46d040710abdcd78d04bf393f8f
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-1of4-connection-pooling-support.20120503.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-1of4-connection-pooling-support.20120503.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1tiorcu1

IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwuaWYgfCAgIDMzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQogcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNx
bC50ZSB8ICAgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcG9s
aWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC5pZiBiL3BvbGljeS9tb2R1bGVzL3NlcnZp
Y2VzL3Bvc3RncmVzcWwuaWYKaW5kZXggMDlhZWZmYS4uNTk0NmI2YSAxMDA2NDQKLS0tIGEvcG9s
aWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC5pZgorKysgYi9wb2xpY3kvbW9kdWxlcy9z
ZXJ2aWNlcy9wb3N0Z3Jlc3FsLmlmCkBAIC0zMiw2ICszMiw3IEBAIGludGVyZmFjZShgcG9zdGdy
ZXNxbF9yb2xlJyxgCiAJCWF0dHJpYnV0ZSBzZXBnc3FsX3NjaGVtYV90eXBlLCBzZXBnc3FsX3N5
c29ial90YWJsZV90eXBlOwogCiAJCXR5cGUgc2VwZ3NxbF90cnVzdGVkX3Byb2NfZXhlY190LCBz
ZXBnc3FsX3RydXN0ZWRfcHJvY190OworCQl0eXBlIHNlcGdzcWxfcmFuZ2VkX3Byb2NfZXhlY190
LCBzZXBnc3FsX3JhbmdlZF9wcm9jX3Q7CiAJCXR5cGUgdXNlcl9zZXBnc3FsX2Jsb2JfdCwgdXNl
cl9zZXBnc3FsX3Byb2NfZXhlY190OwogCQl0eXBlIHVzZXJfc2VwZ3NxbF9zY2hlbWFfdCwgdXNl
cl9zZXBnc3FsX3NlcV90OwogCQl0eXBlIHVzZXJfc2VwZ3NxbF9zeXNvYmpfdCwgdXNlcl9zZXBn
c3FsX3RhYmxlX3Q7CkBAIC00NSw2ICs0Niw3IEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF9yb2xl
JyxgCiAKIAl0eXBlYXR0cmlidXRlICQyIHNlcGdzcWxfY2xpZW50X3R5cGU7CiAJcm9sZSAkMSB0
eXBlcyBzZXBnc3FsX3RydXN0ZWRfcHJvY190OworCXJvbGUgJDEgdHlwZXMgc2VwZ3NxbF9yYW5n
ZWRfcHJvY190OwogCiAJIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiAJIwpAQCAtODgs
NiArOTAsMTAgQEAgaW50ZXJmYWNlKGBwb3N0Z3Jlc3FsX3JvbGUnLGAKIAogCWFsbG93ICQyIHNl
cGdzcWxfdHJ1c3RlZF9wcm9jX3Q6cHJvY2VzcyB0cmFuc2l0aW9uOwogCXR5cGVfdHJhbnNpdGlv
biAkMiBzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3Q6cHJvY2VzcyBzZXBnc3FsX3RydXN0ZWRf
cHJvY190OworCisJYWxsb3cgJDIgc2VwZ3NxbF9yYW5nZWRfcHJvY190OnByb2Nlc3MgdHJhbnNp
dGlvbjsKKwl0eXBlX3RyYW5zaXRpb24gJDIgc2VwZ3NxbF9yYW5nZWRfcHJvY19leGVjX3Q6cHJv
Y2VzcyBzZXBnc3FsX3JhbmdlZF9wcm9jX3Q7CisJYWxsb3cgc2VwZ3NxbF9yYW5nZWRfcHJvY190
ICQyOnByb2Nlc3MgZHludHJhbnNpdGlvbjsKICcpCiAKICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKQEAgLTIyMyw3ICsyMjksNyBAQCBpbnRlcmZhY2UoYHBvc3RncmVz
cWxfdmlld19vYmplY3QnLGAKICMjIDwvc3VtbWFyeT4KICMjIDxwYXJhbSBuYW1lPSJ0eXBlIj4K
ICMjCTxzdW1tYXJ5PgotIyMJVHlwZSBtYXJrZWQgYXMgYSBkYXRhYmFzZSBvYmplY3QgdHlwZS4K
KyMjCVR5cGUgbWFya2VkIGFzIGEgcHJvY2VkdXJlIG9iamVjdCB0eXBlLgogIyMJPC9zdW1tYXJ5
PgogIyMgPC9wYXJhbT4KICMKQEAgLTIzNyw2ICsyNDMsMjYgQEAgaW50ZXJmYWNlKGBwb3N0Z3Jl
c3FsX3Byb2NlZHVyZV9vYmplY3QnLGAKIAogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwogIyMgPHN1bW1hcnk+CisjIwlNYXJrcyBhcyBhIFNFLVBvc3RncmVTUUwgdHJ1
c3RlZCBwcm9jZWR1cmUgb2JqZWN0IHR5cGUKKyMjIDwvc3VtbWFyeT4KKyMjIDxwYXJhbSBuYW1l
PSJ0eXBlIj4KKyMjCTxzdW1tYXJ5PgorIyMJVHlwZSBtYXJrZWQgYXMgYSB0cnVzdGVkIHByb2Nl
ZHVyZSBvYmplY3QgdHlwZS4KKyMjCTwvc3VtbWFyeT4KKyMjIDwvcGFyYW0+CisjCitpbnRlcmZh
Y2UoYHBvc3RncmVzcWxfdHJ1c3RlZF9wcm9jZWR1cmVfb2JqZWN0JyxgCisJZ2VuX3JlcXVpcmUo
YAorCQlhdHRyaWJ1dGUgc2VwZ3NxbF9wcm9jZWR1cmVfdHlwZTsKKwkJYXR0cmlidXRlIHNlcGdz
cWxfdHJ1c3RlZF9wcm9jZWR1cmVfdHlwZTsKKwknKQorCisJdHlwZWF0dHJpYnV0ZSAkMSBzZXBn
c3FsX3Byb2NlZHVyZV90eXBlOworCXR5cGVhdHRyaWJ1dGUgJDEgc2VwZ3NxbF90cnVzdGVkX3By
b2NlZHVyZV90eXBlOworJykKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIworIyMgPHN1bW1hcnk+CiAjIwlNYXJrcyBhcyBhIFNFLVBvc3RncmVTUUwgcHJvY2VkdXJh
bCBsYW5ndWFnZSBvYmplY3QgdHlwZQogIyMgPC9zdW1tYXJ5PgogIyMgPHBhcmFtIG5hbWU9InR5
cGUiPgpAQCAtNDM4LDYgKzQ2NCw3IEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF91bnByaXZfY2xp
ZW50JyxgCiAJCWF0dHJpYnV0ZSBzZXBnc3FsX3N5c29ial90YWJsZV90eXBlOwogCiAJCXR5cGUg
c2VwZ3NxbF90cnVzdGVkX3Byb2NfdCwgc2VwZ3NxbF90cnVzdGVkX3Byb2NfZXhlY190OworCQl0
eXBlIHNlcGdzcWxfcmFuZ2VkX3Byb2NfdCwgc2VwZ3NxbF9yYW5nZWRfcHJvY19leGVjX3Q7CiAJ
CXR5cGUgdW5wcml2X3NlcGdzcWxfYmxvYl90LCB1bnByaXZfc2VwZ3NxbF9wcm9jX2V4ZWNfdDsK
IAkJdHlwZSB1bnByaXZfc2VwZ3NxbF9zY2hlbWFfdCwgdW5wcml2X3NlcGdzcWxfc2VxX3Q7CiAJ
CXR5cGUgdW5wcml2X3NlcGdzcWxfc3lzb2JqX3QsIHVucHJpdl9zZXBnc3FsX3RhYmxlX3Q7CkBA
IC00NTksNiArNDg2LDEwIEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF91bnByaXZfY2xpZW50Jyxg
CiAJdHlwZV90cmFuc2l0aW9uICQxIHNlcGdzcWxfdHJ1c3RlZF9wcm9jX2V4ZWNfdDpwcm9jZXNz
IHNlcGdzcWxfdHJ1c3RlZF9wcm9jX3Q7CiAJYWxsb3cgJDEgc2VwZ3NxbF90cnVzdGVkX3Byb2Nf
dDpwcm9jZXNzIHRyYW5zaXRpb247CiAKKwl0eXBlX3RyYW5zaXRpb24gJDEgc2VwZ3NxbF9yYW5n
ZWRfcHJvY19leGVjX3Q6cHJvY2VzcyBzZXBnc3FsX3JhbmdlZF9wcm9jX3Q7CisJYWxsb3cgJDEg
c2VwZ3NxbF9yYW5nZWRfcHJvY190OnByb2Nlc3MgdHJhbnNpdGlvbjsKKwlhbGxvdyBzZXBnc3Fs
X3JhbmdlZF9wcm9jX3QgJDE6cHJvY2VzcyBkeW50cmFuc2l0aW9uOworCiAJdHVuYWJsZV9wb2xp
Y3koYHNlcGdzcWxfZW5hYmxlX3VzZXJzX2RkbCcsYAogCQlhbGxvdyAkMSB1bnByaXZfc2VwZ3Nx
bF9zY2hlbWFfdDpkYl9zY2hlbWEgeyBjcmVhdGUgZHJvcCBzZXRhdHRyIH07CiAJCWFsbG93ICQx
IHVucHJpdl9zZXBnc3FsX3RhYmxlX3Q6ZGJfdGFibGUgeyBjcmVhdGUgZHJvcCBzZXRhdHRyIH07
CmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlIGIvcG9s
aWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZQppbmRleCA0ZDcxZjg5Li45NzY1ZDI4
IDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlCisrKyBi
L3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUKQEAgLTcwLDYgKzcwLDcgQEAg
YXR0cmlidXRlIHNlcGdzcWxfc3lzb2JqX3RhYmxlX3R5cGU7CiBhdHRyaWJ1dGUgc2VwZ3NxbF9z
ZXF1ZW5jZV90eXBlOwogYXR0cmlidXRlIHNlcGdzcWxfdmlld190eXBlOwogYXR0cmlidXRlIHNl
cGdzcWxfcHJvY2VkdXJlX3R5cGU7CithdHRyaWJ1dGUgc2VwZ3NxbF90cnVzdGVkX3Byb2NlZHVy
ZV90eXBlOwogYXR0cmlidXRlIHNlcGdzcWxfbGFuZ3VhZ2VfdHlwZTsKIGF0dHJpYnV0ZSBzZXBn
c3FsX2Jsb2JfdHlwZTsKIGF0dHJpYnV0ZSBzZXBnc3FsX21vZHVsZV90eXBlOwpAQCAtMTIyLDcg
KzEyMywxMCBAQCB0eXBlIHNlcGdzcWxfdGFibGVfdDsKIHBvc3RncmVzcWxfdGFibGVfb2JqZWN0
KHNlcGdzcWxfdGFibGVfdCkKIAogdHlwZSBzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3Q7Ci1w
b3N0Z3Jlc3FsX3Byb2NlZHVyZV9vYmplY3Qoc2VwZ3NxbF90cnVzdGVkX3Byb2NfZXhlY190KQor
cG9zdGdyZXNxbF90cnVzdGVkX3Byb2NlZHVyZV9vYmplY3Qoc2VwZ3NxbF90cnVzdGVkX3Byb2Nf
ZXhlY190KQorCit0eXBlIHNlcGdzcWxfcmFuZ2VkX3Byb2NfZXhlY190OworcG9zdGdyZXNxbF90
cnVzdGVkX3Byb2NlZHVyZV9vYmplY3Qoc2VwZ3NxbF9yYW5nZWRfcHJvY19leGVjX3QpCiAKIHR5
cGUgc2VwZ3NxbF92aWV3X3Q7CiBwb3N0Z3Jlc3FsX3ZpZXdfb2JqZWN0KHNlcGdzcWxfdmlld190
KQpAQCAtMTMzLDYgKzEzNywyNyBAQCBkb21haW5fdHlwZShzZXBnc3FsX3RydXN0ZWRfcHJvY190
KQogcG9zdGdyZXNxbF91bmNvbmZpbmVkKHNlcGdzcWxfdHJ1c3RlZF9wcm9jX3QpCiByb2xlIHN5
c3RlbV9yIHR5cGVzIHNlcGdzcWxfdHJ1c3RlZF9wcm9jX3Q7CiAKKyMgUmFuZ2VkIFRydXN0ZWQg
UHJvY2VkdXJlIERvbWFpbgorIworIyBYWFggLSB0aGUgcHVycG9zZSBvZiB0aGlzIGRvbWFpbiBp
cyB0byBzd2l0Y2ggc2VjdXJpdHkgY29udGV4dCBvZgorIyB0aGUgZGF0YWJhc2UgY2xpZW50IHVz
aW5nIGR5bmFtaWMgZG9tYWluIHRyYW5zaXRpb247IHR5cGljYWxseSwKKyMgdXNlZCBmb3IgY29u
bmVjdGlvbiBwb29saW5nIHNvZnR3YXJlIHRoYXQgc2hhbGwgYXNzaWduIGEgc2VjdXJpdHkKKyMg
Y29udGV4dCBhdCBiZWdpbm5pbmcgb2YgdGhlIHVzZXIgc2Vzc2lvbiBiYXNlZCBvbiB0aGUgY3Jl
ZGVudGlhbHMKKyMgYmVpbmcgaW52aXNpYmxlIGZyb20gdW5wcml2aWxlZ2VkIGRvbWFpbnMuCisj
Cit0eXBlIHNlcGdzcWxfcmFuZ2VkX3Byb2NfdDsKK2RvbWFpbl90eXBlKHNlcGdzcWxfcmFuZ2Vk
X3Byb2NfdCkKK3Bvc3RncmVzcWxfdW5jb25maW5lZChzZXBnc3FsX3JhbmdlZF9wcm9jX3QpCitk
b21haW5fZHludHJhbnNfdHlwZShzZXBnc3FsX3JhbmdlZF9wcm9jX3QpCithbGxvdyBzZXBnc3Fs
X3JhbmdlZF9wcm9jX3Qgc2VsZjpwcm9jZXNzIHsgc2V0Y3VycmVudCB9Oworcm9sZSBzeXN0ZW1f
ciB0eXBlcyBzZXBnc3FsX3JhbmdlZF9wcm9jX3Q7CitvcHRpb25hbF9wb2xpY3koYAorCW1jc19w
cm9jZXNzX3NldF9jYXRlZ29yaWVzKHNlcGdzcWxfcmFuZ2VkX3Byb2NfdCkKKycpCitvcHRpb25h
bF9wb2xpY3koYAorCW1sc19wcm9jZXNzX3NldF9sZXZlbChzZXBnc3FsX3JhbmdlZF9wcm9jX3Qp
CisnKQorCiAjIFR5cGVzIGZvciB1bnByaXZpbGVnZWQgY2xpZW50CiB0eXBlIHVucHJpdl9zZXBn
c3FsX2Jsb2JfdDsKIHBvc3RncmVzcWxfYmxvYl9vYmplY3QodW5wcml2X3NlcGdzcWxfYmxvYl90
KQpAQCAtNDA0LDcgKzQyOSw3IEBAIGFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9z
ZXFfdDpkYl9zZXF1ZW5jZSB7IGdldGF0dHIgZ2V0X3ZhbHVlIG5leHRfdmFsCiBhbGxvdyBzZXBn
c3FsX2NsaWVudF90eXBlIHNlcGdzcWxfdmlld190OmRiX3ZpZXcgeyBnZXRhdHRyIGV4cGFuZCB9
OwogCiBhbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfcHJvY19leGVjX3Q6ZGJfcHJv
Y2VkdXJlIHsgZ2V0YXR0ciBleGVjdXRlIGluc3RhbGwgfTsKLWFsbG93IHNlcGdzcWxfY2xpZW50
X3R5cGUgc2VwZ3NxbF90cnVzdGVkX3Byb2NfZXhlY190OmRiX3Byb2NlZHVyZSB7IGdldGF0dHIg
ZXhlY3V0ZSBlbnRyeXBvaW50IH07CithbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxf
dHJ1c3RlZF9wcm9jZWR1cmVfdHlwZTpkYl9wcm9jZWR1cmUgeyBnZXRhdHRyIGV4ZWN1dGUgZW50
cnlwb2ludCB9OwogCiBhbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfbGFuZ190OmRi
X2xhbmd1YWdlIHsgZ2V0YXR0ciB9OwogYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3Fs
X3NhZmVfbGFuZ190OmRiX2xhbmd1YWdlIHsgZ2V0YXR0ciBleGVjdXRlIH07CkBAIC00OTMsNyAr
NTE4LDcgQEAgdHVuYWJsZV9wb2xpY3koYHNlcGdzcWxfdW5jb25maW5lZF9kYmFkbScsYAogCWFs
bG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3ZpZXdfdHlwZTpkYl92aWV3ICo7CiAKIAlh
bGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9wcm9jX2V4ZWNfdDpkYl9wcm9jZWR1cmUg
KjsKLQlhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF90cnVzdGVkX3Byb2NfZXhlY190
OmRiX3Byb2NlZHVyZSB+aW5zdGFsbDsKKwlhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3Nx
bF90cnVzdGVkX3Byb2NlZHVyZV90eXBlOmRiX3Byb2NlZHVyZSB+aW5zdGFsbDsKIAlhbGxvdyBz
ZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9wcm9jZWR1cmVfdHlwZTpkYl9wcm9jZWR1cmUgfnsg
ZXhlY3V0ZSBpbnN0YWxsIH07CiAKIAlhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9s
YW5ndWFnZV90eXBlOmRiX2xhbmd1YWdlIH5pbXBsZW1lbnQ7CkBAIC01MjgsNyArNTUzLDcgQEAg
YWxsb3cgc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3NxbF92aWV3X3R5cGU6ZGJfdmlldyAq
OwogIyB1bmNvbmZpbmVkIGRvbWFpbiBpcyBub3QgYWxsb3dlZCB0byBpbnZva2UgdXNlciBkZWZp
bmVkIHByb2NlZHVyZSBkaXJlY3RseS4KICMgVGhleSBoYXZlIHRvIGNvbmZpcm0gYW5kIHJlbGFi
ZWwgaXQgYXQgZmlyc3QuCiBhbGxvdyBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX3By
b2NfZXhlY190OmRiX3Byb2NlZHVyZSAqOwotYWxsb3cgc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUg
c2VwZ3NxbF90cnVzdGVkX3Byb2NfZXhlY190OmRiX3Byb2NlZHVyZSB+aW5zdGFsbDsKK2FsbG93
IHNlcGdzcWxfdW5jb25maW5lZF90eXBlIHNlcGdzcWxfdHJ1c3RlZF9wcm9jZWR1cmVfdHlwZTpk
Yl9wcm9jZWR1cmUgfmluc3RhbGw7CiBhbGxvdyBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBn
c3FsX3Byb2NlZHVyZV90eXBlOmRiX3Byb2NlZHVyZSB+eyBleGVjdXRlIGluc3RhbGwgfTsKIAog
YWxsb3cgc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3NxbF9sYW5ndWFnZV90eXBlOmRiX2xh
bmd1YWdlIH5pbXBsZW1lbnQ7Cg==
--f46d040710abdcd78d04bf393f8f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
