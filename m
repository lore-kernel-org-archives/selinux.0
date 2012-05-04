Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q44HOdbC011925
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 13:24:41 -0400
Received: by lbbgk8 with SMTP id gk8so2403126lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 04 May 2012 10:24:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FA3FAE4.8010803@tresys.com>
References: <CADyhKSXLR1rHgOd8Kfb3spNVWZ3Y5-mM9zYECWaC=ebmYvf-=w@mail.gmail.com>
	<CADyhKSUBg4nScZm+CDFX_hcRgbF-OG4y5NSbjk2NOsVK7LHneg@mail.gmail.com>
	<4FA3FAE4.8010803@tresys.com>
Date: Fri, 4 May 2012 19:24:39 +0200
Message-ID: <CADyhKSU41BXh9H7FA8WEbKBAX-j9iGpa80CwXWuWSf=ckaWhNg@mail.gmail.com>
Subject: Re: [4/4] sepgsql -redefinition of use permission onto system objects
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=f46d04016ab9fb001004bf3931ce
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

--f46d04016ab9fb001004bf3931ce
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/5/4 Christopher J. PeBenito <cpebenito@tresys.com>:
> On 05/04/12 09:33, Kohei KaiGai wrote:
>> The patch 3 of 4 also required the 4 of 4 being refreshed to apply corre=
ctly.
>> In addition, I forgot to allow sepgsql_admin_type to allow to "use" syst=
em
>> objects.
>>
>> Please check the newer version. Thanks,
>
> Looks like the revised patch is missing.
>
Sorry, it is the attached one.

Thanks,

>> 2012/3/25 Kohei KaiGai <kaigai@kaigai.gr.jp>:
>>> This patch might be arguable. It redefines the "use" permission on db_t=
uple
>>> class that has marked deprecated for a few years, to control usage of s=
ystem
>>> objects but without individual object classes.
>>>
>>> We didn't try to port all the supported database object types in Postgr=
eSQL
>>> into SELinux policy model, because its variation is too large to port a=
nd
>>> less priority in comparison with "major" object classes such as tables.
>>>
>>> So, we handle permissions to create, drop and alter these objects as
>>> permissions to insert, delete or update of system catalogs; labeled as
>>> sepgsql_sysobj_t, and so on.
>>>
>>> On the other hand, some of system objects requires to check permission
>>> when user "use" these objects, such as data types, tablespaces,
>>> operators and so on.
>>> I don't think it is reasonable approach to define individual object cla=
sses
>>> for each object types reflects to PostgreSQL. However, it is preferable
>>> to have double checks by selinux on strategic points.
>>>
>>> So, I try to redefine "use" permission on db_tuple class; that means
>>> permission to "use" this object when the tuple is an entry of system
>>> catalog corresponding to a particular database object but don't have
>>> a particular object class like tables.
>>>
>>> The deprecated permissions and rules are not in use for a few years,
>>> so, it is a time to be utilized or eliminated.
>>>
>>> Thanks,
>>>
>>> =A0Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
>>> --
>>> =A0policy/flask/access_vectors =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +---
>>> =A0policy/modules/services/postgresql.if | =A0 16 ++++++----------
>>> =A0policy/modules/services/postgresql.te | =A0 31 +++++++++++----------=
----------
>>> =A03 files changed, 18 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
>>> index bf24160..f462e95 100644
>>> --- a/policy/flask/access_vectors
>>> +++ b/policy/flask/access_vectors
>>> @@ -761,7 +761,6 @@ inherits database
>>> =A0class db_table
>>> =A0inherits database
>>> =A0{
>>> - =A0 =A0 =A0 use =A0 =A0 =A0 =A0 =A0 =A0 # deprecated
>>> =A0 =A0 =A0 =A0select
>>> =A0 =A0 =A0 =A0update
>>> =A0 =A0 =A0 =A0insert
>>> @@ -780,7 +779,6 @@ inherits database
>>> =A0class db_column
>>> =A0inherits database
>>> =A0{
>>> - =A0 =A0 =A0 use =A0 =A0 =A0 =A0 =A0 =A0 # deprecated
>>> =A0 =A0 =A0 =A0select
>>> =A0 =A0 =A0 =A0update
>>> =A0 =A0 =A0 =A0insert
>>> @@ -790,7 +788,7 @@ class db_tuple
>>> =A0{
>>> =A0 =A0 =A0 =A0relabelfrom
>>> =A0 =A0 =A0 =A0relabelto
>>> - =A0 =A0 =A0 use =A0 =A0 =A0 =A0 =A0 =A0 # deprecated
>>> + =A0 =A0 =A0 use
>>> =A0 =A0 =A0 =A0select
>>> =A0 =A0 =A0 =A0update
>>> =A0 =A0 =A0 =A0insert
>>> diff --git a/policy/modules/services/postgresql.if
>>> b/policy/modules/services/postgresql.if
>>> index 56fc5fa..71f2572 100644
>>> --- a/policy/modules/services/postgresql.if
>>> +++ b/policy/modules/services/postgresql.if
>>> @@ -70,10 +70,9 @@ interface(`postgresql_role',`
>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_database_type:db_schema user_=
sepgsql_schema_t;
>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_database_type:db_schema
>>> sepgsql_temp_schema_t "pg_temp";
>>>
>>> - =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_table =A0{ getattr use s=
elect update
>>> insert delete lock };
>>> - =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_column { getattr use sel=
ect update insert };
>>> - =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_tuple =A0{ use select up=
date insert delete };
>>> - =A0 =A0 =A0 type_transition $2 sepgsql_database_type:db_table
>>> user_sepgsql_table_t; =A0 =A0 =A0 =A0 =A0 # deprecated
>>> + =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_table =A0{ getattr selec=
t update
>>> insert delete lock };
>>> + =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_column { getattr select =
update insert };
>>> + =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_tuple =A0{ select update=
 insert delete };
>>> =A0 =A0 =A0 =A0type_transition $2 {sepgsql_schema_type -
>>> sepgsql_temp_schema_t}:db_table user_sepgsql_table_t;
>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_temp_schema_t:db_table sepgsq=
l_temp_table_t;
>>>
>>> @@ -89,7 +88,6 @@ interface(`postgresql_role',`
>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_temp_schema_t:db_view sepgsql=
_temp_view_t;
>>>
>>> =A0 =A0 =A0 =A0allow $2 user_sepgsql_proc_exec_t:db_procedure { getattr=
 execute };
>>> - =A0 =A0 =A0 type_transition $2 sepgsql_database_type:db_procedure
>>> user_sepgsql_proc_exec_t; =A0 =A0 =A0 # deprecated
>>> =A0 =A0 =A0 =A0type_transition $2 {sepgsql_schema_type -
>>> sepgsql_temp_schema_t}:db_procedure user_sepgsql_proc_exec_t;
>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_temp_schema_t:db_procedure
>>> sepgsql_temp_proc_exec_t;
>>>
>>> @@ -513,10 +511,9 @@ interface(`postgresql_unpriv_client',`
>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_database_type:db_schema unpri=
v_sepgsql_schema_t;
>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_database_type:db_schema
>>> unpriv_sepgsql_schema_t "pg_temp";
>>>
>>> - =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_table { getattr use se=
lect update
>>> insert delete lock };
>>> - =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_column { getattr use s=
elect
>>> update insert };
>>> - =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_tuple { use select upd=
ate insert delete };
>>> - =A0 =A0 =A0 type_transition $1 sepgsql_database_type:db_table
>>> unpriv_sepgsql_table_t; # deprecated
>>> + =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_table { getattr select=
 update
>>> insert delete lock };
>>> + =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_column { getattr selec=
t update insert };
>>> + =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_tuple { select update =
insert delete };
>>> =A0 =A0 =A0 =A0type_transition $1 {sepgsql_schema_type -
>>> sepgsql_temp_schema_t}:db_table unpriv_sepgsql_table_t;
>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_temp_schema_t:db_table sepgsq=
l_temp_table_t;
>>>
>>> @@ -532,7 +529,6 @@ interface(`postgresql_unpriv_client',`
>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_sysobj_table_type:db_tuple un=
priv_sepgsql_sysobj_t;
>>>
>>> =A0 =A0 =A0 =A0allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { getat=
tr execute };
>>> - =A0 =A0 =A0 type_transition $1 sepgsql_database_type:db_procedure
>>> unpriv_sepgsql_proc_exec_t; # deprecated
>>> =A0 =A0 =A0 =A0type_transition $1 {sepgsql_schema_type -
>>> sepgsql_temp_schema_t}:db_procedure unpriv_sepgsql_proc_exec_t;
>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_temp_schema_t:db_procedure
>>> sepgsql_temp_proc_exec_t;
>>>
>>> diff --git a/policy/modules/services/postgresql.te
>>> b/policy/modules/services/postgresql.te
>>> index 8a3c2bd..92d6e66 100644
>>> --- a/policy/modules/services/postgresql.te
>>> +++ b/policy/modules/services/postgresql.te
>>> @@ -259,7 +259,6 @@ tunable_policy(`sepgsql_transmit_client_label',`
>>> =A0')
>>>
>>> =A0allow postgresql_t sepgsql_database_type:db_database *;
>>> -type_transition postgresql_t postgresql_t:db_database
>>> sepgsql_db_t; =A0 =A0 =A0 =A0 =A0 # deprecated
>>>
>>> =A0allow postgresql_t sepgsql_module_type:db_database install_module;
>>> =A0# Database/Loadable module
>>> @@ -270,7 +269,6 @@ type_transition postgresql_t
>>> sepgsql_database_type:db_schema sepgsql_schema_t;
>>> =A0type_transition postgresql_t sepgsql_database_type:db_schema
>>> sepgsql_temp_schema_t "pg_temp";
>>>
>>> =A0allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple =
} *;
>>> -type_transition postgresql_t sepgsql_database_type:db_table
>>> sepgsql_sysobj_t; =A0 =A0 =A0 # deprecated
>>> =A0type_transition postgresql_t sepgsql_schema_type:db_table sepgsql_sy=
sobj_t;
>>>
>>> =A0allow postgresql_t sepgsql_sequence_type:db_sequence *;
>>> @@ -280,7 +278,6 @@ allow postgresql_t sepgsql_view_type:db_view *;
>>> =A0type_transition postgresql_t sepgsql_schema_type:db_view sepgsql_vie=
w_t;
>>>
>>> =A0allow postgresql_t sepgsql_procedure_type:db_procedure *;
>>> -type_transition postgresql_t sepgsql_database_type:db_procedure
>>> sepgsql_proc_exec_t; =A0 =A0# deprecated
>>> =A0type_transition postgresql_t sepgsql_schema_type:db_procedure
>>> sepgsql_proc_exec_t;
>>>
>>> =A0allow postgresql_t sepgsql_blob_type:db_blob *;
>>> @@ -431,23 +428,23 @@ type_transition sepgsql_client_type
>>> sepgsql_client_type:db_database sepgsql_db_t
>>>
>>> =A0allow sepgsql_client_type sepgsql_schema_t:db_schema { getattr searc=
h };
>>>
>>> -allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr
>>> use select insert lock };
>>> -allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr
>>> use select insert };
>>> -allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select =
insert };
>>> +allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr
>>> select insert lock };
>>> +allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr
>>> select insert };
>>> +allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { select inse=
rt };
>>>
>>> -allow sepgsql_client_type sepgsql_table_t:db_table { getattr use
>>> select update insert delete lock };
>>> -allow sepgsql_client_type sepgsql_table_t:db_column { getattr use
>>> select update insert };
>>> -allow sepgsql_client_type sepgsql_table_t:db_tuple { use select
>>> update insert delete };
>>> +allow sepgsql_client_type sepgsql_table_t:db_table { getattr select
>>> update insert delete lock };
>>> +allow sepgsql_client_type sepgsql_table_t:db_column { getattr select
>>> update insert };
>>> +allow sepgsql_client_type sepgsql_table_t:db_tuple { select update
>>> insert delete };
>>>
>>> -allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use
>>> select lock };
>>> -allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr use s=
elect };
>>> -allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { use select };
>>> +allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr select=
 lock };
>>> +allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr selec=
t };
>>> +allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { select };
>>>
>>> =A0allow sepgsql_client_type sepgsql_secret_table_t:db_table getattr;
>>> =A0allow sepgsql_client_type sepgsql_secret_table_t:db_column getattr;
>>>
>>> -allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use
>>> select lock };
>>> -allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use sel=
ect };
>>> +allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr select l=
ock };
>>> +allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr select =
};
>>> =A0allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };
>>>
>>> =A0allow sepgsql_client_type sepgsql_temp_table_t:db_table ~{ relabelto
>>> relabelfrom };
>>> @@ -503,7 +500,6 @@ tunable_policy(`sepgsql_enable_users_ddl',`
>>> =A0#
>>>
>>> =A0allow sepgsql_admin_type sepgsql_database_type:db_database { create
>>> drop getattr setattr relabelfrom relabelto access };
>>> -type_transition sepgsql_admin_type sepgsql_admin_type:db_database
>>> sepgsql_db_t; =A0 =A0 =A0 =A0 =A0 # deprecated
>>>
>>> =A0allow sepgsql_admin_type sepgsql_schema_type:db_schema { create drop
>>> getattr setattr relabelfrom relabelto search add_name remove_name };
>>> =A0type_transition sepgsql_admin_type sepgsql_database_type:db_schema
>>> sepgsql_schema_t;
>>> @@ -513,7 +509,6 @@ allow sepgsql_admin_type
>>> sepgsql_table_type:db_table { create drop getattr setat
>>> =A0allow sepgsql_admin_type sepgsql_table_type:db_column { create drop
>>> getattr setattr relabelfrom relabelto };
>>> =A0allow sepgsql_admin_type sepgsql_sysobj_table_type:db_tuple {
>>> relabelfrom relabelto select update insert delete };
>>>
>>> -type_transition sepgsql_admin_type sepgsql_database_type:db_table
>>> sepgsql_table_t; =A0 =A0 =A0 =A0# deprecated
>>> =A0type_transition sepgsql_admin_type sepgsql_schema_type:db_table
>>> sepgsql_table_t;
>>>
>>> =A0allow sepgsql_admin_type sepgsql_sequence_type:db_sequence { create
>>> drop getattr setattr relabelfrom relabelto get_value next_value
>>> set_value };
>>> @@ -527,7 +522,6 @@ type_transition sepgsql_admin_type
>>> sepgsql_schema_type:db_view sepgsql_view_t;
>>> =A0allow sepgsql_admin_type sepgsql_procedure_type:db_procedure { creat=
e
>>> drop getattr relabelfrom relabelto };
>>> =A0allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure execute;
>>>
>>> -type_transition sepgsql_admin_type sepgsql_database_type:db_procedure
>>> sepgsql_proc_exec_t; =A0 =A0# deprecated
>>> =A0type_transition sepgsql_admin_type sepgsql_schema_type:db_procedure
>>> sepgsql_proc_exec_t;
>>>
>>> =A0allow sepgsql_admin_type sepgsql_language_type:db_language { create
>>> drop getattr setattr relabelfrom relabelto execute };
>>> @@ -566,14 +560,11 @@ tunable_policy(`sepgsql_unconfined_dbadm',`
>>> =A0#
>>>
>>> =A0allow sepgsql_unconfined_type sepgsql_database_type:db_database *;
>>> -type_transition sepgsql_unconfined_type
>>> sepgsql_unconfined_type:db_database sepgsql_db_t; =A0 =A0 =A0 # depreca=
ted
>>>
>>> =A0allow sepgsql_unconfined_type sepgsql_schema_type:db_schema *;
>>> =A0type_transition sepgsql_unconfined_type
>>> sepgsql_database_type:db_schema sepgsql_schema_t;
>>> =A0type_transition sepgsql_unconfined_type
>>> sepgsql_database_type:db_schema sepgsql_schema_t "pg_temp";
>>>
>>> -type_transition sepgsql_unconfined_type
>>> sepgsql_database_type:db_table sepgsql_table_t; =A0 =A0 =A0 =A0 # depre=
cated
>>> -type_transition sepgsql_unconfined_type
>>> sepgsql_database_type:db_procedure sepgsql_proc_exec_t; # deprecated
>>> =A0type_transition sepgsql_unconfined_type sepgsql_schema_type:db_table
>>> sepgsql_table_t;
>>> =A0type_transition sepgsql_unconfined_type
>>> sepgsql_schema_type:db_sequence sepgsql_seq_t;
>>> =A0type_transition sepgsql_unconfined_type sepgsql_schema_type:db_view
>>> sepgsql_view_t;
>>>
>>> --
>>> KaiGai Kohei <kaigai@kaigai.gr.jp>
>>
>>
>>
>
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com



--=20
KaiGai Kohei <kaigai@kaigai.gr.jp>

--f46d04016ab9fb001004bf3931ce
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-4of4-redefine-use-permission.20120502.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-4of4-redefine-use-permission.20120502.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1tijxcv0

ZGlmZiAtLWdpdCBhL3BvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycyBiL3BvbGljeS9mbGFzay9h
Y2Nlc3NfdmVjdG9ycwppbmRleCBiZjI0MTYwLi5mNDYyZTk1IDEwMDY0NAotLS0gYS9wb2xpY3kv
Zmxhc2svYWNjZXNzX3ZlY3RvcnMKKysrIGIvcG9saWN5L2ZsYXNrL2FjY2Vzc192ZWN0b3JzCkBA
IC03NjEsNyArNzYxLDYgQEAgaW5oZXJpdHMgZGF0YWJhc2UKIGNsYXNzIGRiX3RhYmxlCiBpbmhl
cml0cyBkYXRhYmFzZQogewotCXVzZQkJIyBkZXByZWNhdGVkCiAJc2VsZWN0CiAJdXBkYXRlCiAJ
aW5zZXJ0CkBAIC03ODAsNyArNzc5LDYgQEAgaW5oZXJpdHMgZGF0YWJhc2UKIGNsYXNzIGRiX2Nv
bHVtbgogaW5oZXJpdHMgZGF0YWJhc2UKIHsKLQl1c2UJCSMgZGVwcmVjYXRlZAogCXNlbGVjdAog
CXVwZGF0ZQogCWluc2VydApAQCAtNzkwLDcgKzc4OCw3IEBAIGNsYXNzIGRiX3R1cGxlCiB7CiAJ
cmVsYWJlbGZyb20KIAlyZWxhYmVsdG8KLQl1c2UJCSMgZGVwcmVjYXRlZAorCXVzZQogCXNlbGVj
dAogCXVwZGF0ZQogCWluc2VydApkaWZmIC0tZ2l0IGEvcG9saWN5L21jcyBiL3BvbGljeS9tY3MK
aW5kZXggZGY4ZTBmYS4uNjJjOTg5YSAxMDA2NDQKLS0tIGEvcG9saWN5L21jcworKysgYi9wb2xp
Y3kvbWNzCkBAIC0xMjAsMTAgKzEyMCwxMCBAQCBtbHNjb25zdHJhaW4gZGJfZGF0YWJhc2UgeyBk
cm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVsZnJvbSBhY2Nlc3MgaW5zdGFsbF9tb2R1bAogbWxz
Y29uc3RyYWluIGRiX2xhbmd1YWdlIHsgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVsYWJlbGZyb20g
ZXhlY3V0ZSB9CiAJKCBoMSBkb20gaDIgKTsKIAotbWxzY29uc3RyYWluIGRiX3RhYmxlIHsgZHJv
cCBnZXRhdHRyIHNldGF0dHIgcmVsYWJlbGZyb20gc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRl
IHVzZSBsb2NrIH0KK21sc2NvbnN0cmFpbiBkYl90YWJsZSB7IGRyb3AgZ2V0YXR0ciBzZXRhdHRy
IHJlbGFiZWxmcm9tIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0ZSBsb2NrIH0KIAkoIGgxIGRv
bSBoMiApOwogCi1tbHNjb25zdHJhaW4gZGJfY29sdW1uIHsgZHJvcCBnZXRhdHRyIHNldGF0dHIg
cmVsYWJlbGZyb20gc2VsZWN0IHVwZGF0ZSBpbnNlcnQgdXNlIH0KK21sc2NvbnN0cmFpbiBkYl9j
b2x1bW4geyBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVsZnJvbSBzZWxlY3QgdXBkYXRlIGlu
c2VydCB9CiAJKCBoMSBkb20gaDIgKTsKIAogbWxzY29uc3RyYWluIGRiX3R1cGxlIHsgcmVsYWJl
bGZyb20gc2VsZWN0IHVwZGF0ZSBkZWxldGUgdXNlIH0KZGlmZiAtLWdpdCBhL3BvbGljeS9tbHMg
Yi9wb2xpY3kvbWxzCmluZGV4IDBlODQ3NGIuLmZmYjFiMDEgMTAwNjQ0Ci0tLSBhL3BvbGljeS9t
bHMKKysrIGIvcG9saWN5L21scwpAQCAtNzQ5LDEzICs3NDksMTMgQEAgbWxzY29uc3RyYWluIHsg
ZGJfc2NoZW1hIH0geyBnZXRhdHRyIHNlYXJjaCB9CiAJICggdDEgPT0gbWxzZGJyZWFkICkgb3IK
IAkgKCB0MiA9PSBtbHN0cnVzdGVkb2JqZWN0ICkpOwogCi1tbHNjb25zdHJhaW4geyBkYl90YWJs
ZSB9IHsgZ2V0YXR0ciB1c2Ugc2VsZWN0IGxvY2sgfQorbWxzY29uc3RyYWluIHsgZGJfdGFibGUg
fSB7IGdldGF0dHIgc2VsZWN0IGxvY2sgfQogCSgoIGwxIGRvbSBsMiApIG9yCiAJICgoIHQxID09
IG1sc2RicmVhZHRvY2xyICkgYW5kICggaDEgZG9tIGwyICkpIG9yCiAJICggdDEgPT0gbWxzZGJy
ZWFkICkgb3IKIAkgKCB0MiA9PSBtbHN0cnVzdGVkb2JqZWN0ICkpOwogCi1tbHNjb25zdHJhaW4g
eyBkYl9jb2x1bW4gfSB7IGdldGF0dHIgdXNlIHNlbGVjdCB9CittbHNjb25zdHJhaW4geyBkYl9j
b2x1bW4gfSB7IGdldGF0dHIgc2VsZWN0IH0KIAkoKCBsMSBkb20gbDIgKSBvcgogCSAoKCB0MSA9
PSBtbHNkYnJlYWR0b2NsciApIGFuZCAoIGgxIGRvbSBsMiApKSBvcgogCSAoIHQxID09IG1sc2Ri
cmVhZCApIG9yCmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3Fs
LmlmIGIvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC5pZgppbmRleCA2ZjMwYjFh
Li5jOWZmMDQ5IDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3Fs
LmlmCisrKyBiL3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwuaWYKQEAgLTY4LDEw
ICs2OCw5IEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF9yb2xlJyxgCiAJdHlwZV90cmFuc2l0aW9u
ICQyIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgdXNlcl9zZXBnc3FsX3NjaGVtYV90
OwogCXR5cGVfdHJhbnNpdGlvbiAkMiBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfc2NoZW1hIHNl
cGdzcWxfdGVtcF9vYmplY3RfdCAicGdfdGVtcCI7CiAKLQlhbGxvdyAkMiB1c2VyX3NlcGdzcWxf
dGFibGVfdDpkYl90YWJsZQl7IGdldGF0dHIgdXNlIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0
ZSBsb2NrIH07Ci0JYWxsb3cgJDIgdXNlcl9zZXBnc3FsX3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0
YXR0ciB1c2Ugc2VsZWN0IHVwZGF0ZSBpbnNlcnQgfTsKLQlhbGxvdyAkMiB1c2VyX3NlcGdzcWxf
dGFibGVfdDpkYl90dXBsZQl7IHVzZSBzZWxlY3QgdXBkYXRlIGluc2VydCBkZWxldGUgfTsKLQl0
eXBlX3RyYW5zaXRpb24gJDIgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3RhYmxlIHVzZXJfc2Vw
Z3NxbF90YWJsZV90OwkJIyBkZXByZWNhdGVkCisJYWxsb3cgJDIgdXNlcl9zZXBnc3FsX3RhYmxl
X3Q6ZGJfdGFibGUJeyBnZXRhdHRyIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0ZSBsb2NrIH07
CisJYWxsb3cgJDIgdXNlcl9zZXBnc3FsX3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0YXR0ciBzZWxl
Y3QgdXBkYXRlIGluc2VydCB9OworCWFsbG93ICQyIHVzZXJfc2VwZ3NxbF90YWJsZV90OmRiX3R1
cGxlCXsgc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIH07CiAJdHlwZV90cmFuc2l0aW9uICQy
IHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJfdGFibGUgdXNlcl9zZXBnc3FsX3RhYmxlX3Q7CiAKIAlh
bGxvdyAkMiB1c2VyX3NlcGdzcWxfc3lzb2JqX3Q6ZGJfdHVwbGUJeyB1c2Ugc2VsZWN0IH07CkBA
IC04NCw3ICs4Myw2IEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF9yb2xlJyxgCiAJdHlwZV90cmFu
c2l0aW9uICQyIHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJfdmlldyB1c2VyX3NlcGdzcWxfdmlld190
OwogCiAJYWxsb3cgJDIgdXNlcl9zZXBnc3FsX3Byb2NfZXhlY190OmRiX3Byb2NlZHVyZSB7IGdl
dGF0dHIgZXhlY3V0ZSB9OwotCXR5cGVfdHJhbnNpdGlvbiAkMiBzZXBnc3FsX2RhdGFiYXNlX3R5
cGU6ZGJfcHJvY2VkdXJlIHVzZXJfc2VwZ3NxbF9wcm9jX2V4ZWNfdDsJIyBkZXByZWNhdGVkCiAJ
dHlwZV90cmFuc2l0aW9uICQyIHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJfcHJvY2VkdXJlIHVzZXJf
c2VwZ3NxbF9wcm9jX2V4ZWNfdDsKIAogCWFsbG93ICQyIHVzZXJfc2VwZ3NxbF9ibG9iX3Q6ZGJf
YmxvYiB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWFkIHdyaXRlIGltcG9ydCBleHBv
cnQgfTsKQEAgLTUwNiwxMCArNTA0LDkgQEAgaW50ZXJmYWNlKGBwb3N0Z3Jlc3FsX3VucHJpdl9j
bGllbnQnLGAKIAl0eXBlX3RyYW5zaXRpb24gJDEgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3Nj
aGVtYSB1bnByaXZfc2VwZ3NxbF9zY2hlbWFfdDsKIAl0eXBlX3RyYW5zaXRpb24gJDEgc2VwZ3Nx
bF9kYXRhYmFzZV90eXBlOmRiX3NjaGVtYSBzZXBnc3FsX3RlbXBfb2JqZWN0X3QgInBnX3RlbXAi
OwogCi0JYWxsb3cgJDEgdW5wcml2X3NlcGdzcWxfdGFibGVfdDpkYl90YWJsZSB7IGdldGF0dHIg
dXNlIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0ZSBsb2NrIH07Ci0JYWxsb3cgJDEgdW5wcml2
X3NlcGdzcWxfdGFibGVfdDpkYl9jb2x1bW4geyBnZXRhdHRyIHVzZSBzZWxlY3QgdXBkYXRlIGlu
c2VydCB9OwotCWFsbG93ICQxIHVucHJpdl9zZXBnc3FsX3RhYmxlX3Q6ZGJfdHVwbGUgeyB1c2Ug
c2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIH07Ci0JdHlwZV90cmFuc2l0aW9uICQxIHNlcGdz
cWxfZGF0YWJhc2VfdHlwZTpkYl90YWJsZSB1bnByaXZfc2VwZ3NxbF90YWJsZV90OwkjIGRlcHJl
Y2F0ZWQKKwlhbGxvdyAkMSB1bnByaXZfc2VwZ3NxbF90YWJsZV90OmRiX3RhYmxlIHsgZ2V0YXR0
ciBzZWxlY3QgdXBkYXRlIGluc2VydCBkZWxldGUgbG9jayB9OworCWFsbG93ICQxIHVucHJpdl9z
ZXBnc3FsX3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0YXR0ciBzZWxlY3QgdXBkYXRlIGluc2VydCB9
OworCWFsbG93ICQxIHVucHJpdl9zZXBnc3FsX3RhYmxlX3Q6ZGJfdHVwbGUgeyBzZWxlY3QgdXBk
YXRlIGluc2VydCBkZWxldGUgfTsKIAl0eXBlX3RyYW5zaXRpb24gJDEgc2VwZ3NxbF9zY2hlbWFf
dHlwZTpkYl90YWJsZSB1bnByaXZfc2VwZ3NxbF90YWJsZV90OwogCiAJYWxsb3cgJDEgdW5wcml2
X3NlcGdzcWxfc2VxX3Q6ZGJfc2VxdWVuY2UgeyBnZXRhdHRyIGdldF92YWx1ZSBuZXh0X3ZhbHVl
IHNldF92YWx1ZSB9OwpAQCAtNTIyLDcgKzUxOSw2IEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF91
bnByaXZfY2xpZW50JyxgCiAJdHlwZV90cmFuc2l0aW9uICQxIHNlcGdzcWxfc3lzb2JqX3RhYmxl
X3R5cGU6ZGJfdHVwbGUgdW5wcml2X3NlcGdzcWxfc3lzb2JqX3Q7CiAKIAlhbGxvdyAkMSB1bnBy
aXZfc2VwZ3NxbF9wcm9jX2V4ZWNfdDpkYl9wcm9jZWR1cmUgeyBnZXRhdHRyIGV4ZWN1dGUgfTsK
LQl0eXBlX3RyYW5zaXRpb24gJDEgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3Byb2NlZHVyZSB1
bnByaXZfc2VwZ3NxbF9wcm9jX2V4ZWNfdDsgIyBkZXByZWNhdGVkCiAJdHlwZV90cmFuc2l0aW9u
ICQxIHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJfcHJvY2VkdXJlIHVucHJpdl9zZXBnc3FsX3Byb2Nf
ZXhlY190OwogCiAJYWxsb3cgJDEgdW5wcml2X3NlcGdzcWxfYmxvYl90OmRiX2Jsb2IgeyBjcmVh
dGUgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVhZCB3cml0ZSBpbXBvcnQgZXhwb3J0IH07CmRpZmYg
LS1naXQgYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlIGIvcG9saWN5L21v
ZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZQppbmRleCA1NzE5M2U1Li41Zjc1YjgzIDEwMDY0
NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlCisrKyBiL3BvbGlj
eS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUKQEAgLTI1Niw3ICsyNTYsNiBAQCB0dW5h
YmxlX3BvbGljeShgc2VwZ3NxbF90cmFuc21pdF9jbGllbnRfbGFiZWwnLGAKICcpCiAKIGFsbG93
IHBvc3RncmVzcWxfdCBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfZGF0YWJhc2UgKjsKLXR5cGVf
dHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3QgcG9zdGdyZXNxbF90OmRiX2RhdGFiYXNlIHNlcGdzcWxf
ZGJfdDsJCSMgZGVwcmVjYXRlZAogCiBhbGxvdyBwb3N0Z3Jlc3FsX3Qgc2VwZ3NxbF9tb2R1bGVf
dHlwZTpkYl9kYXRhYmFzZSBpbnN0YWxsX21vZHVsZTsKICMgRGF0YWJhc2UvTG9hZGFibGUgbW9k
dWxlCkBAIC0yNjcsNyArMjY2LDYgQEAgdHlwZV90cmFuc2l0aW9uIHBvc3RncmVzcWxfdCBzZXBn
c3FsX2RhdGFiYXNlX3R5cGU6ZGJfc2NoZW1hIHNlcGdzcWxfc2NoZW1hX3Q7CiB0eXBlX3RyYW5z
aXRpb24gcG9zdGdyZXNxbF90IHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgc2VwZ3Nx
bF90ZW1wX29iamVjdF90ICJwZ190ZW1wIjsKIAogYWxsb3cgcG9zdGdyZXNxbF90IHNlcGdzcWxf
dGFibGVfdHlwZTp7IGRiX3RhYmxlIGRiX2NvbHVtbiBkYl90dXBsZSB9ICo7Ci10eXBlX3RyYW5z
aXRpb24gcG9zdGdyZXNxbF90IHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl90YWJsZSBzZXBnc3Fs
X3N5c29ial90OwkjIGRlcHJlY2F0ZWQKIHR5cGVfdHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3Qgc2Vw
Z3NxbF9zY2hlbWFfdHlwZTpkYl90YWJsZSBzZXBnc3FsX3N5c29ial90OwogCiBhbGxvdyBwb3N0
Z3Jlc3FsX3Qgc2VwZ3NxbF9zZXF1ZW5jZV90eXBlOmRiX3NlcXVlbmNlICo7CkBAIC0yNzcsNyAr
Mjc1LDYgQEAgYWxsb3cgcG9zdGdyZXNxbF90IHNlcGdzcWxfdmlld190eXBlOmRiX3ZpZXcgKjsK
IHR5cGVfdHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3Qgc2VwZ3NxbF9zY2hlbWFfdHlwZTpkYl92aWV3
IHNlcGdzcWxfdmlld190OwogCiBhbGxvdyBwb3N0Z3Jlc3FsX3Qgc2VwZ3NxbF9wcm9jZWR1cmVf
dHlwZTpkYl9wcm9jZWR1cmUgKjsKLXR5cGVfdHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3Qgc2VwZ3Nx
bF9kYXRhYmFzZV90eXBlOmRiX3Byb2NlZHVyZSBzZXBnc3FsX3Byb2NfZXhlY190OwkjIGRlcHJl
Y2F0ZWQKIHR5cGVfdHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3Qgc2VwZ3NxbF9zY2hlbWFfdHlwZTpk
Yl9wcm9jZWR1cmUgc2VwZ3NxbF9wcm9jX2V4ZWNfdDsKIAogYWxsb3cgcG9zdGdyZXNxbF90IHNl
cGdzcWxfYmxvYl90eXBlOmRiX2Jsb2IgKjsKQEAgLTQyOCwyMyArNDI1LDIzIEBAIHR5cGVfdHJh
bnNpdGlvbiBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfY2xpZW50X3R5cGU6ZGJfZGF0YWJh
c2Ugc2VwZ3NxbF9kYl90CiAKIGFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9zY2hl
bWFfdDpkYl9zY2hlbWEgeyBnZXRhdHRyIHNlYXJjaCB9OwogCi1hbGxvdyBzZXBnc3FsX2NsaWVu
dF90eXBlIHNlcGdzcWxfZml4ZWRfdGFibGVfdDpkYl90YWJsZSB7IGdldGF0dHIgdXNlIHNlbGVj
dCBpbnNlcnQgbG9jayB9OwotYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX2ZpeGVk
X3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0YXR0ciB1c2Ugc2VsZWN0IGluc2VydCB9OwotYWxsb3cg
c2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX2ZpeGVkX3RhYmxlX3Q6ZGJfdHVwbGUgeyB1c2Ug
c2VsZWN0IGluc2VydCB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX2ZpeGVk
X3RhYmxlX3Q6ZGJfdGFibGUgeyBnZXRhdHRyIHNlbGVjdCBpbnNlcnQgbG9jayB9OworYWxsb3cg
c2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX2ZpeGVkX3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0
YXR0ciBzZWxlY3QgaW5zZXJ0IH07CithbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxf
Zml4ZWRfdGFibGVfdDpkYl90dXBsZSB7IHNlbGVjdCBpbnNlcnQgfTsKIAotYWxsb3cgc2VwZ3Nx
bF9jbGllbnRfdHlwZSBzZXBnc3FsX3RhYmxlX3Q6ZGJfdGFibGUgeyBnZXRhdHRyIHVzZSBzZWxl
Y3QgdXBkYXRlIGluc2VydCBkZWxldGUgbG9jayB9OwotYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlw
ZSBzZXBnc3FsX3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0YXR0ciB1c2Ugc2VsZWN0IHVwZGF0ZSBp
bnNlcnQgfTsKLWFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF90YWJsZV90OmRiX3R1
cGxlIHsgdXNlIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0ZSB9OworYWxsb3cgc2VwZ3NxbF9j
bGllbnRfdHlwZSBzZXBnc3FsX3RhYmxlX3Q6ZGJfdGFibGUgeyBnZXRhdHRyIHNlbGVjdCB1cGRh
dGUgaW5zZXJ0IGRlbGV0ZSBsb2NrIH07CithbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdz
cWxfdGFibGVfdDpkYl9jb2x1bW4geyBnZXRhdHRyIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IH07Cith
bGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfdGFibGVfdDpkYl90dXBsZSB7IHNlbGVj
dCB1cGRhdGUgaW5zZXJ0IGRlbGV0ZSB9OwogCi1hbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNl
cGdzcWxfcm9fdGFibGVfdDpkYl90YWJsZSB7IGdldGF0dHIgdXNlIHNlbGVjdCBsb2NrIH07Ci1h
bGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfcm9fdGFibGVfdDpkYl9jb2x1bW4geyBn
ZXRhdHRyIHVzZSBzZWxlY3QgfTsKLWFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9y
b190YWJsZV90OmRiX3R1cGxlIHsgdXNlIHNlbGVjdCB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRf
dHlwZSBzZXBnc3FsX3JvX3RhYmxlX3Q6ZGJfdGFibGUgeyBnZXRhdHRyIHNlbGVjdCBsb2NrIH07
CithbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfcm9fdGFibGVfdDpkYl9jb2x1bW4g
eyBnZXRhdHRyIHNlbGVjdCB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3Jv
X3RhYmxlX3Q6ZGJfdHVwbGUgeyBzZWxlY3QgfTsKIAogYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlw
ZSBzZXBnc3FsX3NlY3JldF90YWJsZV90OmRiX3RhYmxlIGdldGF0dHI7CiBhbGxvdyBzZXBnc3Fs
X2NsaWVudF90eXBlIHNlcGdzcWxfc2VjcmV0X3RhYmxlX3Q6ZGJfY29sdW1uIGdldGF0dHI7CiAK
LWFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9zeXNvYmpfdDpkYl90YWJsZSB7IGdl
dGF0dHIgdXNlIHNlbGVjdCBsb2NrIH07Ci1hbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdz
cWxfc3lzb2JqX3Q6ZGJfY29sdW1uIHsgZ2V0YXR0ciB1c2Ugc2VsZWN0IH07CithbGxvdyBzZXBn
c3FsX2NsaWVudF90eXBlIHNlcGdzcWxfc3lzb2JqX3Q6ZGJfdGFibGUgeyBnZXRhdHRyIHNlbGVj
dCBsb2NrIH07CithbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfc3lzb2JqX3Q6ZGJf
Y29sdW1uIHsgZ2V0YXR0ciBzZWxlY3QgfTsKIGFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2Vw
Z3NxbF9zeXNvYmpfdDpkYl90dXBsZSB7IHVzZSBzZWxlY3QgfTsKIAogYWxsb3cgc2VwZ3NxbF9j
bGllbnRfdHlwZSBzZXBnc3FsX3NlcV90OmRiX3NlcXVlbmNlIHsgZ2V0YXR0ciBnZXRfdmFsdWUg
bmV4dF92YWx1ZSB9OwpAQCAtNDk2LDcgKzQ5Myw2IEBAIHR1bmFibGVfcG9saWN5KGBzZXBnc3Fs
X2VuYWJsZV91c2Vyc19kZGwnLGAKICMKIAogYWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdz
cWxfZGF0YWJhc2VfdHlwZTpkYl9kYXRhYmFzZSB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0YXR0
ciByZWxhYmVsZnJvbSByZWxhYmVsdG8gYWNjZXNzIH07Ci10eXBlX3RyYW5zaXRpb24gc2VwZ3Nx
bF9hZG1pbl90eXBlIHNlcGdzcWxfYWRtaW5fdHlwZTpkYl9kYXRhYmFzZSBzZXBnc3FsX2RiX3Q7
CQkjIGRlcHJlY2F0ZWQKIAogYWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfc2NoZW1h
X3R5cGU6ZGJfc2NoZW1hIHsgY3JlYXRlIGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9t
IHJlbGFiZWx0byBzZWFyY2ggYWRkX25hbWUgcmVtb3ZlX25hbWUgfTsKIHR5cGVfdHJhbnNpdGlv
biBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3NjaGVtYSBzZXBn
c3FsX3NjaGVtYV90OwpAQCAtNTA0LDkgKzUwMCw4IEBAIHR5cGVfdHJhbnNpdGlvbiBzZXBnc3Fs
X2FkbWluX3R5cGUgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3NjaGVtYSBzZXBnc3FsX3RlbXBf
CiAKIGFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3RhYmxlX3R5cGU6ZGJfdGFibGUg
eyBjcmVhdGUgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVsYWJlbGZyb20gcmVsYWJlbHRvIGxvY2sg
fTsKIGFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3RhYmxlX3R5cGU6ZGJfY29sdW1u
IHsgY3JlYXRlIGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9tIHJlbGFiZWx0byB9Owot
YWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfc3lzb2JqX3RhYmxlX3R5cGU6ZGJfdHVw
bGUgeyByZWxhYmVsZnJvbSByZWxhYmVsdG8gc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIH07
CithbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9zeXNvYmpfdGFibGVfdHlwZTpkYl90
dXBsZSB7IHJlbGFiZWxmcm9tIHJlbGFiZWx0byB1c2Ugc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVs
ZXRlIH07CiAKLXR5cGVfdHJhbnNpdGlvbiBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9kYXRh
YmFzZV90eXBlOmRiX3RhYmxlIHNlcGdzcWxfdGFibGVfdDsJIyBkZXByZWNhdGVkCiB0eXBlX3Ry
YW5zaXRpb24gc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJfdGFibGUg
c2VwZ3NxbF90YWJsZV90OwogCiBhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9zZXF1
ZW5jZV90eXBlOmRiX3NlcXVlbmNlIHsgY3JlYXRlIGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFi
ZWxmcm9tIHJlbGFiZWx0byBnZXRfdmFsdWUgbmV4dF92YWx1ZSBzZXRfdmFsdWUgfTsKQEAgLTUy
MCw3ICs1MTUsNiBAQCB0eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxf
c2NoZW1hX3R5cGU6ZGJfdmlldyBzZXBnc3FsX3ZpZXdfdDsKIGFsbG93IHNlcGdzcWxfYWRtaW5f
dHlwZSBzZXBnc3FsX3Byb2NlZHVyZV90eXBlOmRiX3Byb2NlZHVyZSB7IGNyZWF0ZSBkcm9wIGdl
dGF0dHIgcmVsYWJlbGZyb20gcmVsYWJlbHRvIH07CiBhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUg
c2VwZ3NxbF9wcm9jX2V4ZWNfdDpkYl9wcm9jZWR1cmUgZXhlY3V0ZTsKIAotdHlwZV90cmFuc2l0
aW9uIHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfcHJvY2VkdXJl
IHNlcGdzcWxfcHJvY19leGVjX3Q7CSMgZGVwcmVjYXRlZAogdHlwZV90cmFuc2l0aW9uIHNlcGdz
cWxfYWRtaW5fdHlwZSBzZXBnc3FsX3NjaGVtYV90eXBlOmRiX3Byb2NlZHVyZSBzZXBnc3FsX3By
b2NfZXhlY190OwogCiBhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9sYW5ndWFnZV90
eXBlOmRiX2xhbmd1YWdlIHsgY3JlYXRlIGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9t
IHJlbGFiZWx0byBleGVjdXRlIH07CkBAIC01NjEsMTQgKzU1NSwxMSBAQCBhbGxvdyBzZXBnc3Fs
X2FkbWluX3R5cGUgc2VwZ3NxbF90ZW1wX29iamVjdF90OntkYl9zY2hlbWEgZGJfdGFibGUgZGJf
Y29sdW1uIGRiXwogIwogCiBhbGxvdyBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX2Rh
dGFiYXNlX3R5cGU6ZGJfZGF0YWJhc2UgKjsKLXR5cGVfdHJhbnNpdGlvbiBzZXBnc3FsX3VuY29u
ZmluZWRfdHlwZSBzZXBnc3FsX3VuY29uZmluZWRfdHlwZTpkYl9kYXRhYmFzZSBzZXBnc3FsX2Ri
X3Q7CSMgZGVwcmVjYXRlZAogCiBhbGxvdyBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSB7c2VwZ3Nx
bF9zY2hlbWFfdHlwZSBzZXBnc3FsX3RlbXBfb2JqZWN0X3R9OmRiX3NjaGVtYSAqOwogdHlwZV90
cmFuc2l0aW9uIHNlcGdzcWxfdW5jb25maW5lZF90eXBlIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpk
Yl9zY2hlbWEgc2VwZ3NxbF9zY2hlbWFfdDsKIHR5cGVfdHJhbnNpdGlvbiBzZXBnc3FsX3VuY29u
ZmluZWRfdHlwZSBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfc2NoZW1hIHNlcGdzcWxfdGVtcF9v
YmplY3RfdCAicGdfdGVtcCI7CiAKLXR5cGVfdHJhbnNpdGlvbiBzZXBnc3FsX3VuY29uZmluZWRf
dHlwZSBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfdGFibGUgc2VwZ3NxbF90YWJsZV90OwkJIyBk
ZXByZWNhdGVkCi10eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3Nx
bF9kYXRhYmFzZV90eXBlOmRiX3Byb2NlZHVyZSBzZXBnc3FsX3Byb2NfZXhlY190OwkjIGRlcHJl
Y2F0ZWQKIHR5cGVfdHJhbnNpdGlvbiBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX3Nj
aGVtYV90eXBlOmRiX3RhYmxlIHNlcGdzcWxfdGFibGVfdDsKIHR5cGVfdHJhbnNpdGlvbiBzZXBn
c3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX3NjaGVtYV90eXBlOmRiX3NlcXVlbmNlIHNlcGdz
cWxfc2VxX3Q7CiB0eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3Nx
bF9zY2hlbWFfdHlwZTpkYl92aWV3IHNlcGdzcWxfdmlld190Owo=
--f46d04016ab9fb001004bf3931ce--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
