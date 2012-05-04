Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q44DNiqh027198
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 09:23:44 -0400
Received: by lahc1 with SMTP id c1so2184286lah.12
        for <selinux@tycho.nsa.gov>; Fri, 04 May 2012 06:23:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADyhKSUb0q06VGR5hEa5pKB-_n7Gn3OFzB_r5yASuVFGE4AJGQ@mail.gmail.com>
References: <CADyhKSUb0q06VGR5hEa5pKB-_n7Gn3OFzB_r5yASuVFGE4AJGQ@mail.gmail.com>
Date: Fri, 4 May 2012 15:23:43 +0200
Message-ID: <CADyhKSXv0fb+4cVoe-XfzCmccvTuBJKLyGAwbwpjsbAAh1-yZw@mail.gmail.com>
Subject: Re: [1/4] sepgsql - add connection pooling server support
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=f46d04016ab96050b604bf35d4d0
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

--f46d04016ab96050b604bf35d4d0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I noticed a miss on postgresql_unpriv_client() interface.
Please check the newer one.

Thanks,

2012/3/25 Kohei KaiGai <kaigai@kaigai.gr.jp>:
> This patch provides a new trusted procedure type that allows to
> switch the security label of database client, with interaction of new
> sepgsql_setcon() function being supported at upcoming v9.2 release.
>
> The original idea was given by Joshua Brindle. The sepgsql_setcon()
> provides an analogy of dynamic domain transition on operating system.
> Although we don't give privileges to switch security label on confined
> domains, but it allows to switch via trusted procedure.
>
> The new sepgsql_ranged_proc_exec_t is an entrypoint of
> sepgsql_ranged_proc_t that has mcssetcats and mlsprocsetsl.
>
> We assume its typical usage is sepgsql_setcon() getting invoked
> via trusted procedure that references secret credential tables at
> beginning of the database session by connection pooling server.
>
> Usage example)
>
> (*) The credential table is labeled as "sepgsql_secret_table_t",
> =A0 =A0 that holds a pair of username, credential and security context.
>
> postgres=3D# CREATE OR REPLACE FUNCTION client_switch(text)
> =A0 =A0RETURNS bool LANGUAGE sql
> =A0 =A0AS 'SELECT sepgsql_setcon(ucontext) FROM credential
> =A0 =A0 =A0 =A0 =A0 =A0 =A0WHERE uname =3D current_user AND ucred =3D $1'=
;
> CREATE FUNCTION
> postgres=3D# SECURITY LABEL ON FUNCTION client_switch(text) IS
> 'system_u:object_r:sepgsql_ranged_proc_exec_t:s0';
> SECURITY LABEL
> postgres=3D# CREATE OR REPLACE FUNCTION client_reset()
> =A0 =A0RETURNS bool LANGUAGE sql AS 'SELECT sepgsql_setcon(NULL)';
> CREATE FUNCTION
> postgres=3D# SECURITY LABEL ON FUNCTION client_reset() IS
> 'system_u:object_r:sepgsql_ranged_proc_exec_t:s0';
> SECURITY LABEL
>
> Then, it shows a scenario to switch the client label via trusted procedur=
e.
>
> [alice@iwashi ~]$ psql postgres -q
> postgres=3D# SELECT sepgsql_getcon();
> =A0 =A0 =A0 sepgsql_getcon
> ----------------------------
> =A0staff_u:staff_r:staff_t:s0
> (1 row)
>
> postgres=3D# SELECT * FROM info_c0;
> ERROR: =A0SELinux: security policy violation
> postgres=3D# SELECT * FROM info_c1;
> ERROR: =A0SELinux: security policy violation
> -- client have no permission neither info_c0 nor info_c1
>
> postgres=3D# SELECT client_switch('6384e2b2184bcbf58eccf10ca7a6563c');
> =A0client_switch
> ---------------
> =A0t
> (1 row)
>
> postgres=3D# SELECT sepgsql_getcon();
> =A0 =A0 =A0 =A0sepgsql_getcon
> -------------------------------
> =A0staff_u:staff_r:staff_t:s0:c1
> (1 row)
>
> postgres=3D# SELECT * FROM info_c0;
> ERROR: =A0SELinux: security policy violation
> postgres=3D# SELECT * FROM info_c1;
> =A0a | =A0b
> ---+-----
> =A03 | xxx
> =A04 | yyy
> (2 rows)
>
> -- needless to say, credential table is not visible
> postgres=3D# SELECT * FROM credential ;
> ERROR: =A0SELinux: security policy violation
>
> Also see,
> http://git.postgresql.org/gitweb/?p=3Dpostgresql.git;a=3Dcommit;h=3D52317=
6cbf14a3414170a83dd43686c0eccdc61c6
>
> =A0Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
> --
> =A0policy/modules/services/postgresql.if | =A0 32 +++++++++++++++++++++++=
++++++++-
> =A0policy/modules/services/postgresql.te | =A0 32 +++++++++++++++++++++++=
+++++----
> =A02 files changed, 59 insertions(+), 5 deletions(-)
>
> diff --git a/policy/modules/services/postgresql.if
> b/policy/modules/services/postgresql.if
> index 09aeffa..24e9958 100644
> --- a/policy/modules/services/postgresql.if
> +++ b/policy/modules/services/postgresql.if
> @@ -32,6 +32,7 @@ interface(`postgresql_role',`
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0attribute sepgsql_schema_type, sepgsql_sys=
obj_table_type;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type sepgsql_trusted_proc_exec_t, sepgsql_=
trusted_proc_t;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 type sepgsql_ranged_proc_exec_t, sepgsql_ra=
nged_proc_t;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type user_sepgsql_blob_t, user_sepgsql_pro=
c_exec_t;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type user_sepgsql_schema_t, user_sepgsql_s=
eq_t;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type user_sepgsql_sysobj_t, user_sepgsql_t=
able_t;
> @@ -45,6 +46,7 @@ interface(`postgresql_role',`
>
> =A0 =A0 =A0 =A0typeattribute $2 sepgsql_client_type;
> =A0 =A0 =A0 =A0role $1 types sepgsql_trusted_proc_t;
> + =A0 =A0 =A0 role $1 types sepgsql_ranged_proc_t;
>
> =A0 =A0 =A0 =A0##############################
> =A0 =A0 =A0 =A0#
> @@ -88,6 +90,10 @@ interface(`postgresql_role',`
>
> =A0 =A0 =A0 =A0allow $2 sepgsql_trusted_proc_t:process transition;
> =A0 =A0 =A0 =A0type_transition $2 sepgsql_trusted_proc_exec_t:process sep=
gsql_trusted_proc_t;
> +
> + =A0 =A0 =A0 allow $2 sepgsql_ranged_proc_t:process transition;
> + =A0 =A0 =A0 type_transition $2 sepgsql_ranged_proc_exec_t:process sepgs=
ql_ranged_proc_t;
> + =A0 =A0 =A0 allow sepgsql_ranged_proc_t $2:process dyntransition;
> =A0')
>
> =A0########################################
> @@ -223,7 +229,7 @@ interface(`postgresql_view_object',`
> =A0## </summary>
> =A0## <param name=3D"type">
> =A0## =A0 =A0 <summary>
> -## =A0 =A0 Type marked as a database object type.
> +## =A0 =A0 Type marked as a procedure object type.
> =A0## =A0 =A0 </summary>
> =A0## </param>
> =A0#
> @@ -237,6 +243,26 @@ interface(`postgresql_procedure_object',`
>
> =A0########################################
> =A0## <summary>
> +## =A0 =A0 Marks as a SE-PostgreSQL trusted procedure object type
> +## </summary>
> +## <param name=3D"type">
> +## =A0 =A0 <summary>
> +## =A0 =A0 Type marked as a trusted procedure object type.
> +## =A0 =A0 </summary>
> +## </param>
> +#
> +interface(`postgresql_trusted_procedure_object',`
> + =A0 =A0 =A0 gen_require(`
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 attribute sepgsql_procedure_type;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 attribute sepgsql_trusted_procedure_type;
> + =A0 =A0 =A0 ')
> +
> + =A0 =A0 =A0 typeattribute $1 sepgsql_procedure_type;
> + =A0 =A0 =A0 typeattribute $1 sepgsql_trusted_procedure_type;
> +')
> +
> +########################################
> +## <summary>
> =A0## =A0 =A0 Marks as a SE-PostgreSQL procedural language object type
> =A0## </summary>
> =A0## <param name=3D"type">
> @@ -459,6 +485,10 @@ interface(`postgresql_unpriv_client',`
> =A0 =A0 =A0 =A0type_transition $1 sepgsql_trusted_proc_exec_t:process sep=
gsql_trusted_proc_t;
> =A0 =A0 =A0 =A0allow $1 sepgsql_trusted_proc_t:process transition;
>
> + =A0 =A0 =A0 type_transition $1 sepgsql_ranged_proc_exec_t:process sepgs=
ql_ranged_proc_t;
> + =A0 =A0 =A0 allow $1 sepgsql_ranged_proc_t:process transition;
> + =A0 =A0 =A0 allow sepgsql_ranged_proc_t $1:process dyntransition;
> +
> =A0 =A0 =A0 =A0tunable_policy(`sepgsql_enable_users_ddl',`
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0allow $1 unpriv_sepgsql_schema_t:db_schema=
 { create drop setattr };
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0allow $1 unpriv_sepgsql_table_t:db_table {=
 create drop setattr };
> diff --git a/policy/modules/services/postgresql.te
> b/policy/modules/services/postgresql.te
> index 4d71f89..2457d10 100644
> --- a/policy/modules/services/postgresql.te
> +++ b/policy/modules/services/postgresql.te
> @@ -70,6 +70,7 @@ attribute sepgsql_sysobj_table_type;
> =A0attribute sepgsql_sequence_type;
> =A0attribute sepgsql_view_type;
> =A0attribute sepgsql_procedure_type;
> +attribute sepgsql_trusted_procedure_type;
> =A0attribute sepgsql_language_type;
> =A0attribute sepgsql_blob_type;
> =A0attribute sepgsql_module_type;
> @@ -122,7 +123,10 @@ type sepgsql_table_t;
> =A0postgresql_table_object(sepgsql_table_t)
>
> =A0type sepgsql_trusted_proc_exec_t;
> -postgresql_procedure_object(sepgsql_trusted_proc_exec_t)
> +postgresql_trusted_procedure_object(sepgsql_trusted_proc_exec_t)
> +
> +type sepgsql_ranged_proc_exec_t;
> +postgresql_trusted_procedure_object(sepgsql_ranged_proc_exec_t)
>
> =A0type sepgsql_view_t;
> =A0postgresql_view_object(sepgsql_view_t)
> @@ -133,6 +137,26 @@ domain_type(sepgsql_trusted_proc_t)
> =A0postgresql_unconfined(sepgsql_trusted_proc_t)
> =A0role system_r types sepgsql_trusted_proc_t;
>
> +# Ranged Trusted Procedure Domain
> +#
> +# XXX - the purpose of this domain is to switch security context of
> +# the database client using dynamic domain transition; typically,
> +# used for connection pooling software that shall assign a security
> +# context at beginning of the user session based on the credentials
> +# being invisible from unprivileged domains.
> +#
> +type sepgsql_ranged_proc_t;
> +domain_type(sepgsql_ranged_proc_t)
> +postgresql_unconfined(sepgsql_ranged_proc_t)
> +allow sepgsql_ranged_proc_t self:process { setcurrent };
> +role system_r types sepgsql_ranged_proc_t;
> +optional_policy(`
> + =A0 =A0 =A0 mcs_process_set_categories(sepgsql_ranged_proc_t)
> +')
> +optional_policy(`
> + =A0 =A0 =A0 mls_process_set_level(sepgsql_ranged_proc_t)
> +')
> +
> =A0# Types for unprivileged client
> =A0type unpriv_sepgsql_blob_t;
> =A0postgresql_blob_object(unpriv_sepgsql_blob_t)
> @@ -404,7 +428,7 @@ allow sepgsql_client_type
> sepgsql_seq_t:db_sequence { getattr get_value next_val
> =A0allow sepgsql_client_type sepgsql_view_t:db_view { getattr expand };
>
> =A0allow sepgsql_client_type sepgsql_proc_exec_t:db_procedure { getattr
> execute install };
> -allow sepgsql_client_type sepgsql_trusted_proc_exec_t:db_procedure {
> getattr execute entrypoint };
> +allow sepgsql_client_type sepgsql_trusted_procedure_type:db_procedure
> { getattr execute entrypoint };
>
> =A0allow sepgsql_client_type sepgsql_lang_t:db_language { getattr };
> =A0allow sepgsql_client_type sepgsql_safe_lang_t:db_language { getattr ex=
ecute };
> @@ -493,7 +517,7 @@ tunable_policy(`sepgsql_unconfined_dbadm',`
> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_view_type:db_view *;
>
> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure =
*;
> - =A0 =A0 =A0 allow sepgsql_admin_type sepgsql_trusted_proc_exec_t:db_pro=
cedure ~install;
> + =A0 =A0 =A0 allow sepgsql_admin_type sepgsql_trusted_procedure_type:db_=
procedure ~install;
> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_procedure_type:db_procedu=
re ~{
> execute install };
>
> =A0 =A0 =A0 =A0allow sepgsql_admin_type sepgsql_language_type:db_language=
 ~implement;
> @@ -528,7 +552,7 @@ allow sepgsql_unconfined_type sepgsql_view_type:db_vi=
ew *;
> =A0# unconfined domain is not allowed to invoke user defined procedure di=
rectly.
> =A0# They have to confirm and relabel it at first.
> =A0allow sepgsql_unconfined_type sepgsql_proc_exec_t:db_procedure *;
> -allow sepgsql_unconfined_type
> sepgsql_trusted_proc_exec_t:db_procedure ~install;
> +allow sepgsql_unconfined_type
> sepgsql_trusted_procedure_type:db_procedure ~install;
> =A0allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure ~{
> execute install };
>
> =A0allow sepgsql_unconfined_type sepgsql_language_type:db_language ~imple=
ment;
>
> --
> KaiGai Kohei <kaigai@kaigai.gr.jp>



--=20
KaiGai Kohei <kaigai@kaigai.gr.jp>

--f46d04016ab96050b604bf35d4d0
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-1of4-connection-pooling-support.20120502.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-1of4-connection-pooling-support.20120502.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1t9nxkt0

IHBvbGljeS9tb2R1bGVzL2NvbnRyaWIgICAgICAgICAgICAgICAgfCAgICAyICstCiBwb2xpY3kv
bW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLmlmIHwgICAzMyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0KIHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUgfCAg
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDYx
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVs
ZXMvY29udHJpYiBiL3BvbGljeS9tb2R1bGVzL2NvbnRyaWIKaW5kZXggNmMxOTJjNy4uMTcyMTdi
MyAxNjAwMDAKLS0tIGEvcG9saWN5L21vZHVsZXMvY29udHJpYgorKysgYi9wb2xpY3kvbW9kdWxl
cy9jb250cmliCkBAIC0xICsxIEBACi1TdWJwcm9qZWN0IGNvbW1pdCA2YzE5MmM3NDc4MDJhODY2
MDM4ZjQ3MGY4ZjYwZDVkNjY0NTA3YTRmCitTdWJwcm9qZWN0IGNvbW1pdCAxNzIxN2IzYTdhYjZj
MWYyZjc4YjJmODdjNDc3MzA4M2NjNWUwNjEwCmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9z
ZXJ2aWNlcy9wb3N0Z3Jlc3FsLmlmIGIvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNx
bC5pZgppbmRleCAwOWFlZmZhLi41OTQ2YjZhIDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9z
ZXJ2aWNlcy9wb3N0Z3Jlc3FsLmlmCisrKyBiL3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3Rn
cmVzcWwuaWYKQEAgLTMyLDYgKzMyLDcgQEAgaW50ZXJmYWNlKGBwb3N0Z3Jlc3FsX3JvbGUnLGAK
IAkJYXR0cmlidXRlIHNlcGdzcWxfc2NoZW1hX3R5cGUsIHNlcGdzcWxfc3lzb2JqX3RhYmxlX3R5
cGU7CiAKIAkJdHlwZSBzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3QsIHNlcGdzcWxfdHJ1c3Rl
ZF9wcm9jX3Q7CisJCXR5cGUgc2VwZ3NxbF9yYW5nZWRfcHJvY19leGVjX3QsIHNlcGdzcWxfcmFu
Z2VkX3Byb2NfdDsKIAkJdHlwZSB1c2VyX3NlcGdzcWxfYmxvYl90LCB1c2VyX3NlcGdzcWxfcHJv
Y19leGVjX3Q7CiAJCXR5cGUgdXNlcl9zZXBnc3FsX3NjaGVtYV90LCB1c2VyX3NlcGdzcWxfc2Vx
X3Q7CiAJCXR5cGUgdXNlcl9zZXBnc3FsX3N5c29ial90LCB1c2VyX3NlcGdzcWxfdGFibGVfdDsK
QEAgLTQ1LDYgKzQ2LDcgQEAgaW50ZXJmYWNlKGBwb3N0Z3Jlc3FsX3JvbGUnLGAKIAogCXR5cGVh
dHRyaWJ1dGUgJDIgc2VwZ3NxbF9jbGllbnRfdHlwZTsKIAlyb2xlICQxIHR5cGVzIHNlcGdzcWxf
dHJ1c3RlZF9wcm9jX3Q7CisJcm9sZSAkMSB0eXBlcyBzZXBnc3FsX3JhbmdlZF9wcm9jX3Q7CiAK
IAkjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIAkjCkBAIC04OCw2ICs5MCwxMCBAQCBp
bnRlcmZhY2UoYHBvc3RncmVzcWxfcm9sZScsYAogCiAJYWxsb3cgJDIgc2VwZ3NxbF90cnVzdGVk
X3Byb2NfdDpwcm9jZXNzIHRyYW5zaXRpb247CiAJdHlwZV90cmFuc2l0aW9uICQyIHNlcGdzcWxf
dHJ1c3RlZF9wcm9jX2V4ZWNfdDpwcm9jZXNzIHNlcGdzcWxfdHJ1c3RlZF9wcm9jX3Q7CisKKwlh
bGxvdyAkMiBzZXBnc3FsX3JhbmdlZF9wcm9jX3Q6cHJvY2VzcyB0cmFuc2l0aW9uOworCXR5cGVf
dHJhbnNpdGlvbiAkMiBzZXBnc3FsX3JhbmdlZF9wcm9jX2V4ZWNfdDpwcm9jZXNzIHNlcGdzcWxf
cmFuZ2VkX3Byb2NfdDsKKwlhbGxvdyBzZXBnc3FsX3JhbmdlZF9wcm9jX3QgJDI6cHJvY2VzcyBk
eW50cmFuc2l0aW9uOwogJykKIAogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpAQCAtMjIzLDcgKzIyOSw3IEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF92aWV3X29iamVj
dCcsYAogIyMgPC9zdW1tYXJ5PgogIyMgPHBhcmFtIG5hbWU9InR5cGUiPgogIyMJPHN1bW1hcnk+
Ci0jIwlUeXBlIG1hcmtlZCBhcyBhIGRhdGFiYXNlIG9iamVjdCB0eXBlLgorIyMJVHlwZSBtYXJr
ZWQgYXMgYSBwcm9jZWR1cmUgb2JqZWN0IHR5cGUuCiAjIwk8L3N1bW1hcnk+CiAjIyA8L3BhcmFt
PgogIwpAQCAtMjM3LDYgKzI0MywyNiBAQCBpbnRlcmZhY2UoYHBvc3RncmVzcWxfcHJvY2VkdXJl
X29iamVjdCcsYAogCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiAj
IyA8c3VtbWFyeT4KKyMjCU1hcmtzIGFzIGEgU0UtUG9zdGdyZVNRTCB0cnVzdGVkIHByb2NlZHVy
ZSBvYmplY3QgdHlwZQorIyMgPC9zdW1tYXJ5PgorIyMgPHBhcmFtIG5hbWU9InR5cGUiPgorIyMJ
PHN1bW1hcnk+CisjIwlUeXBlIG1hcmtlZCBhcyBhIHRydXN0ZWQgcHJvY2VkdXJlIG9iamVjdCB0
eXBlLgorIyMJPC9zdW1tYXJ5PgorIyMgPC9wYXJhbT4KKyMKK2ludGVyZmFjZShgcG9zdGdyZXNx
bF90cnVzdGVkX3Byb2NlZHVyZV9vYmplY3QnLGAKKwlnZW5fcmVxdWlyZShgCisJCWF0dHJpYnV0
ZSBzZXBnc3FsX3Byb2NlZHVyZV90eXBlOworCQlhdHRyaWJ1dGUgc2VwZ3NxbF90cnVzdGVkX3By
b2NlZHVyZV90eXBlOworCScpCisKKwl0eXBlYXR0cmlidXRlICQxIHNlcGdzcWxfcHJvY2VkdXJl
X3R5cGU7CisJdHlwZWF0dHJpYnV0ZSAkMSBzZXBnc3FsX3RydXN0ZWRfcHJvY2VkdXJlX3R5cGU7
CisnKQorCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCisjIyA8c3Vt
bWFyeT4KICMjCU1hcmtzIGFzIGEgU0UtUG9zdGdyZVNRTCBwcm9jZWR1cmFsIGxhbmd1YWdlIG9i
amVjdCB0eXBlCiAjIyA8L3N1bW1hcnk+CiAjIyA8cGFyYW0gbmFtZT0idHlwZSI+CkBAIC00Mzgs
NiArNDY0LDcgQEAgaW50ZXJmYWNlKGBwb3N0Z3Jlc3FsX3VucHJpdl9jbGllbnQnLGAKIAkJYXR0
cmlidXRlIHNlcGdzcWxfc3lzb2JqX3RhYmxlX3R5cGU7CiAKIAkJdHlwZSBzZXBnc3FsX3RydXN0
ZWRfcHJvY190LCBzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3Q7CisJCXR5cGUgc2VwZ3NxbF9y
YW5nZWRfcHJvY190LCBzZXBnc3FsX3JhbmdlZF9wcm9jX2V4ZWNfdDsKIAkJdHlwZSB1bnByaXZf
c2VwZ3NxbF9ibG9iX3QsIHVucHJpdl9zZXBnc3FsX3Byb2NfZXhlY190OwogCQl0eXBlIHVucHJp
dl9zZXBnc3FsX3NjaGVtYV90LCB1bnByaXZfc2VwZ3NxbF9zZXFfdDsKIAkJdHlwZSB1bnByaXZf
c2VwZ3NxbF9zeXNvYmpfdCwgdW5wcml2X3NlcGdzcWxfdGFibGVfdDsKQEAgLTQ1OSw2ICs0ODYs
MTAgQEAgaW50ZXJmYWNlKGBwb3N0Z3Jlc3FsX3VucHJpdl9jbGllbnQnLGAKIAl0eXBlX3RyYW5z
aXRpb24gJDEgc2VwZ3NxbF90cnVzdGVkX3Byb2NfZXhlY190OnByb2Nlc3Mgc2VwZ3NxbF90cnVz
dGVkX3Byb2NfdDsKIAlhbGxvdyAkMSBzZXBnc3FsX3RydXN0ZWRfcHJvY190OnByb2Nlc3MgdHJh
bnNpdGlvbjsKIAorCXR5cGVfdHJhbnNpdGlvbiAkMSBzZXBnc3FsX3JhbmdlZF9wcm9jX2V4ZWNf
dDpwcm9jZXNzIHNlcGdzcWxfcmFuZ2VkX3Byb2NfdDsKKwlhbGxvdyAkMSBzZXBnc3FsX3Jhbmdl
ZF9wcm9jX3Q6cHJvY2VzcyB0cmFuc2l0aW9uOworCWFsbG93IHNlcGdzcWxfcmFuZ2VkX3Byb2Nf
dCAkMTpwcm9jZXNzIGR5bnRyYW5zaXRpb247CisKIAl0dW5hYmxlX3BvbGljeShgc2VwZ3NxbF9l
bmFibGVfdXNlcnNfZGRsJyxgCiAJCWFsbG93ICQxIHVucHJpdl9zZXBnc3FsX3NjaGVtYV90OmRi
X3NjaGVtYSB7IGNyZWF0ZSBkcm9wIHNldGF0dHIgfTsKIAkJYWxsb3cgJDEgdW5wcml2X3NlcGdz
cWxfdGFibGVfdDpkYl90YWJsZSB7IGNyZWF0ZSBkcm9wIHNldGF0dHIgfTsKZGlmZiAtLWdpdCBh
L3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUgYi9wb2xpY3kvbW9kdWxlcy9z
ZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlCmluZGV4IDRkNzFmODkuLjI0NTdkMTAgMTAwNjQ0Ci0tLSBh
L3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUKKysrIGIvcG9saWN5L21vZHVs
ZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZQpAQCAtNzAsNiArNzAsNyBAQCBhdHRyaWJ1dGUgc2Vw
Z3NxbF9zeXNvYmpfdGFibGVfdHlwZTsKIGF0dHJpYnV0ZSBzZXBnc3FsX3NlcXVlbmNlX3R5cGU7
CiBhdHRyaWJ1dGUgc2VwZ3NxbF92aWV3X3R5cGU7CiBhdHRyaWJ1dGUgc2VwZ3NxbF9wcm9jZWR1
cmVfdHlwZTsKK2F0dHJpYnV0ZSBzZXBnc3FsX3RydXN0ZWRfcHJvY2VkdXJlX3R5cGU7CiBhdHRy
aWJ1dGUgc2VwZ3NxbF9sYW5ndWFnZV90eXBlOwogYXR0cmlidXRlIHNlcGdzcWxfYmxvYl90eXBl
OwogYXR0cmlidXRlIHNlcGdzcWxfbW9kdWxlX3R5cGU7CkBAIC0xMjIsNyArMTIzLDEwIEBAIHR5
cGUgc2VwZ3NxbF90YWJsZV90OwogcG9zdGdyZXNxbF90YWJsZV9vYmplY3Qoc2VwZ3NxbF90YWJs
ZV90KQogCiB0eXBlIHNlcGdzcWxfdHJ1c3RlZF9wcm9jX2V4ZWNfdDsKLXBvc3RncmVzcWxfcHJv
Y2VkdXJlX29iamVjdChzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3QpCitwb3N0Z3Jlc3FsX3Ry
dXN0ZWRfcHJvY2VkdXJlX29iamVjdChzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3QpCisKK3R5
cGUgc2VwZ3NxbF9yYW5nZWRfcHJvY19leGVjX3Q7Citwb3N0Z3Jlc3FsX3RydXN0ZWRfcHJvY2Vk
dXJlX29iamVjdChzZXBnc3FsX3JhbmdlZF9wcm9jX2V4ZWNfdCkKIAogdHlwZSBzZXBnc3FsX3Zp
ZXdfdDsKIHBvc3RncmVzcWxfdmlld19vYmplY3Qoc2VwZ3NxbF92aWV3X3QpCkBAIC0xMzMsNiAr
MTM3LDI2IEBAIGRvbWFpbl90eXBlKHNlcGdzcWxfdHJ1c3RlZF9wcm9jX3QpCiBwb3N0Z3Jlc3Fs
X3VuY29uZmluZWQoc2VwZ3NxbF90cnVzdGVkX3Byb2NfdCkKIHJvbGUgc3lzdGVtX3IgdHlwZXMg
c2VwZ3NxbF90cnVzdGVkX3Byb2NfdDsKIAorIyBSYW5nZWQgVHJ1c3RlZCBQcm9jZWR1cmUgRG9t
YWluCisjCisjIFhYWCAtIHRoZSBwdXJwb3NlIG9mIHRoaXMgZG9tYWluIGlzIHRvIHN3aXRjaCBz
ZWN1cml0eSBjb250ZXh0IG9mCisjIHRoZSBkYXRhYmFzZSBjbGllbnQgdXNpbmcgZHluYW1pYyBk
b21haW4gdHJhbnNpdGlvbjsgdHlwaWNhbGx5LAorIyB1c2VkIGZvciBjb25uZWN0aW9uIHBvb2xp
bmcgc29mdHdhcmUgdGhhdCBzaGFsbCBhc3NpZ24gYSBzZWN1cml0eQorIyBjb250ZXh0IGF0IGJl
Z2lubmluZyBvZiB0aGUgdXNlciBzZXNzaW9uIGJhc2VkIG9uIHRoZSBjcmVkZW50aWFscworIyBi
ZWluZyBpbnZpc2libGUgZnJvbSB1bnByaXZpbGVnZWQgZG9tYWlucy4KKyMKK3R5cGUgc2VwZ3Nx
bF9yYW5nZWRfcHJvY190OworZG9tYWluX3R5cGUoc2VwZ3NxbF9yYW5nZWRfcHJvY190KQorcG9z
dGdyZXNxbF91bmNvbmZpbmVkKHNlcGdzcWxfcmFuZ2VkX3Byb2NfdCkKK2FsbG93IHNlcGdzcWxf
cmFuZ2VkX3Byb2NfdCBzZWxmOnByb2Nlc3MgeyBzZXRjdXJyZW50IH07Cityb2xlIHN5c3RlbV9y
IHR5cGVzIHNlcGdzcWxfcmFuZ2VkX3Byb2NfdDsKK29wdGlvbmFsX3BvbGljeShgCisJbWNzX3By
b2Nlc3Nfc2V0X2NhdGVnb3JpZXMoc2VwZ3NxbF9yYW5nZWRfcHJvY190KQorJykKK29wdGlvbmFs
X3BvbGljeShgCisJbWxzX3Byb2Nlc3Nfc2V0X2xldmVsKHNlcGdzcWxfcmFuZ2VkX3Byb2NfdCkK
KycpCisKICMgVHlwZXMgZm9yIHVucHJpdmlsZWdlZCBjbGllbnQKIHR5cGUgdW5wcml2X3NlcGdz
cWxfYmxvYl90OwogcG9zdGdyZXNxbF9ibG9iX29iamVjdCh1bnByaXZfc2VwZ3NxbF9ibG9iX3Qp
CkBAIC00MDQsNyArNDI4LDcgQEAgYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3Nl
cV90OmRiX3NlcXVlbmNlIHsgZ2V0YXR0ciBnZXRfdmFsdWUgbmV4dF92YWwKIGFsbG93IHNlcGdz
cWxfY2xpZW50X3R5cGUgc2VwZ3NxbF92aWV3X3Q6ZGJfdmlldyB7IGdldGF0dHIgZXhwYW5kIH07
CiAKIGFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9wcm9jX2V4ZWNfdDpkYl9wcm9j
ZWR1cmUgeyBnZXRhdHRyIGV4ZWN1dGUgaW5zdGFsbCB9OwotYWxsb3cgc2VwZ3NxbF9jbGllbnRf
dHlwZSBzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3Q6ZGJfcHJvY2VkdXJlIHsgZ2V0YXR0ciBl
eGVjdXRlIGVudHJ5cG9pbnQgfTsKK2FsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF90
cnVzdGVkX3Byb2NlZHVyZV90eXBlOmRiX3Byb2NlZHVyZSB7IGdldGF0dHIgZXhlY3V0ZSBlbnRy
eXBvaW50IH07CiAKIGFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9sYW5nX3Q6ZGJf
bGFuZ3VhZ2UgeyBnZXRhdHRyIH07CiBhbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxf
c2FmZV9sYW5nX3Q6ZGJfbGFuZ3VhZ2UgeyBnZXRhdHRyIGV4ZWN1dGUgfTsKQEAgLTQ5Myw3ICs1
MTcsNyBAQCB0dW5hYmxlX3BvbGljeShgc2VwZ3NxbF91bmNvbmZpbmVkX2RiYWRtJyxgCiAJYWxs
b3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfdmlld190eXBlOmRiX3ZpZXcgKjsKIAogCWFs
bG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3Byb2NfZXhlY190OmRiX3Byb2NlZHVyZSAq
OwotCWFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3Q6
ZGJfcHJvY2VkdXJlIH5pbnN0YWxsOworCWFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3Fs
X3RydXN0ZWRfcHJvY2VkdXJlX3R5cGU6ZGJfcHJvY2VkdXJlIH5pbnN0YWxsOwogCWFsbG93IHNl
cGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3Byb2NlZHVyZV90eXBlOmRiX3Byb2NlZHVyZSB+eyBl
eGVjdXRlIGluc3RhbGwgfTsKIAogCWFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX2xh
bmd1YWdlX3R5cGU6ZGJfbGFuZ3VhZ2UgfmltcGxlbWVudDsKQEAgLTUyOCw3ICs1NTIsNyBAQCBh
bGxvdyBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX3ZpZXdfdHlwZTpkYl92aWV3ICo7
CiAjIHVuY29uZmluZWQgZG9tYWluIGlzIG5vdCBhbGxvd2VkIHRvIGludm9rZSB1c2VyIGRlZmlu
ZWQgcHJvY2VkdXJlIGRpcmVjdGx5LgogIyBUaGV5IGhhdmUgdG8gY29uZmlybSBhbmQgcmVsYWJl
bCBpdCBhdCBmaXJzdC4KIGFsbG93IHNlcGdzcWxfdW5jb25maW5lZF90eXBlIHNlcGdzcWxfcHJv
Y19leGVjX3Q6ZGJfcHJvY2VkdXJlICo7Ci1hbGxvdyBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBz
ZXBnc3FsX3RydXN0ZWRfcHJvY19leGVjX3Q6ZGJfcHJvY2VkdXJlIH5pbnN0YWxsOworYWxsb3cg
c2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3NxbF90cnVzdGVkX3Byb2NlZHVyZV90eXBlOmRi
X3Byb2NlZHVyZSB+aW5zdGFsbDsKIGFsbG93IHNlcGdzcWxfdW5jb25maW5lZF90eXBlIHNlcGdz
cWxfcHJvY2VkdXJlX3R5cGU6ZGJfcHJvY2VkdXJlIH57IGV4ZWN1dGUgaW5zdGFsbCB9OwogCiBh
bGxvdyBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX2xhbmd1YWdlX3R5cGU6ZGJfbGFu
Z3VhZ2UgfmltcGxlbWVudDsK
--f46d04016ab96050b604bf35d4d0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
