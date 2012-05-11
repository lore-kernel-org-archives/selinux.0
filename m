Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4BDHC5G008196
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 09:17:12 -0400
Received: by lbbgk8 with SMTP id gk8so2088854lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 06:17:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FABB8BF.2070201@tresys.com>
References: <CADyhKSXLR1rHgOd8Kfb3spNVWZ3Y5-mM9zYECWaC=ebmYvf-=w@mail.gmail.com>
	<CADyhKSUBg4nScZm+CDFX_hcRgbF-OG4y5NSbjk2NOsVK7LHneg@mail.gmail.com>
	<4FA3FAE4.8010803@tresys.com>
	<CADyhKSU41BXh9H7FA8WEbKBAX-j9iGpa80CwXWuWSf=ckaWhNg@mail.gmail.com>
	<4FABB8BF.2070201@tresys.com>
Date: Fri, 11 May 2012 15:17:11 +0200
Message-ID: <CADyhKSUNhZAbwKt+Qq7GJ2CxLs4dPqdDMEK666m4Gac_goejVw@mail.gmail.com>
Subject: Re: [4/4] sepgsql -redefinition of use permission onto system objects
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=f46d0401730bedaaca04bfc28da6
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401730bedaaca04bfc28da6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/5/10 Christopher J. PeBenito <cpebenito@tresys.com>:
> On 05/04/12 13:24, Kohei KaiGai wrote:
>> 2012/5/4 Christopher J. PeBenito <cpebenito@tresys.com>:
>>> On 05/04/12 09:33, Kohei KaiGai wrote:
>>>> The patch 3 of 4 also required the 4 of 4 being refreshed to apply cor=
rectly.
>>>> In addition, I forgot to allow sepgsql_admin_type to allow to "use" sy=
stem
>>>> objects.
>>>>
>>>> Please check the newer version. Thanks,
>>>
>>> Looks like the revised patch is missing.
>>>
>> Sorry, it is the attached one.
>>
>> Thanks,
>
> This one doesn't apply, the last hunk fails. =A0I also had a problem with=
 the 3rd patch, as the contrib hunk stopped it from applying too.
>
Sorry, I generated the series of patches based on the latest refpolicy and
contrib tree.

And, I added "0of4" patch that fixes bugs in MLS/MCS that I noticed during
regression test efforts. MCS rules are defined twice for db_language class
in spite of db_schema being forgotten, and "entrypoint" permission was not
restricted at both of MCS / MLS policy.

Here is no updates on part-1 ~ part-4 except for patch rebasing.

Thanks,

>>>> 2012/3/25 Kohei KaiGai <kaigai@kaigai.gr.jp>:
>>>>> This patch might be arguable. It redefines the "use" permission on db=
_tuple
>>>>> class that has marked deprecated for a few years, to control usage of=
 system
>>>>> objects but without individual object classes.
>>>>>
>>>>> We didn't try to port all the supported database object types in Post=
greSQL
>>>>> into SELinux policy model, because its variation is too large to port=
 and
>>>>> less priority in comparison with "major" object classes such as table=
s.
>>>>>
>>>>> So, we handle permissions to create, drop and alter these objects as
>>>>> permissions to insert, delete or update of system catalogs; labeled a=
s
>>>>> sepgsql_sysobj_t, and so on.
>>>>>
>>>>> On the other hand, some of system objects requires to check permissio=
n
>>>>> when user "use" these objects, such as data types, tablespaces,
>>>>> operators and so on.
>>>>> I don't think it is reasonable approach to define individual object c=
lasses
>>>>> for each object types reflects to PostgreSQL. However, it is preferab=
le
>>>>> to have double checks by selinux on strategic points.
>>>>>
>>>>> So, I try to redefine "use" permission on db_tuple class; that means
>>>>> permission to "use" this object when the tuple is an entry of system
>>>>> catalog corresponding to a particular database object but don't have
>>>>> a particular object class like tables.
>>>>>
>>>>> The deprecated permissions and rules are not in use for a few years,
>>>>> so, it is a time to be utilized or eliminated.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> =A0Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
>>>>> --
>>>>> =A0policy/flask/access_vectors =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +---
>>>>> =A0policy/modules/services/postgresql.if | =A0 16 ++++++----------
>>>>> =A0policy/modules/services/postgresql.te | =A0 31 +++++++++++--------=
------------
>>>>> =A03 files changed, 18 insertions(+), 33 deletions(-)
>>>>>
>>>>> diff --git a/policy/flask/access_vectors b/policy/flask/access_vector=
s
>>>>> index bf24160..f462e95 100644
>>>>> --- a/policy/flask/access_vectors
>>>>> +++ b/policy/flask/access_vectors
>>>>> @@ -761,7 +761,6 @@ inherits database
>>>>> =A0class db_table
>>>>> =A0inherits database
>>>>> =A0{
>>>>> - =A0 =A0 =A0 use =A0 =A0 =A0 =A0 =A0 =A0 # deprecated
>>>>> =A0 =A0 =A0 =A0select
>>>>> =A0 =A0 =A0 =A0update
>>>>> =A0 =A0 =A0 =A0insert
>>>>> @@ -780,7 +779,6 @@ inherits database
>>>>> =A0class db_column
>>>>> =A0inherits database
>>>>> =A0{
>>>>> - =A0 =A0 =A0 use =A0 =A0 =A0 =A0 =A0 =A0 # deprecated
>>>>> =A0 =A0 =A0 =A0select
>>>>> =A0 =A0 =A0 =A0update
>>>>> =A0 =A0 =A0 =A0insert
>>>>> @@ -790,7 +788,7 @@ class db_tuple
>>>>> =A0{
>>>>> =A0 =A0 =A0 =A0relabelfrom
>>>>> =A0 =A0 =A0 =A0relabelto
>>>>> - =A0 =A0 =A0 use =A0 =A0 =A0 =A0 =A0 =A0 # deprecated
>>>>> + =A0 =A0 =A0 use
>>>>> =A0 =A0 =A0 =A0select
>>>>> =A0 =A0 =A0 =A0update
>>>>> =A0 =A0 =A0 =A0insert
>>>>> diff --git a/policy/modules/services/postgresql.if
>>>>> b/policy/modules/services/postgresql.if
>>>>> index 56fc5fa..71f2572 100644
>>>>> --- a/policy/modules/services/postgresql.if
>>>>> +++ b/policy/modules/services/postgresql.if
>>>>> @@ -70,10 +70,9 @@ interface(`postgresql_role',`
>>>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_database_type:db_schema use=
r_sepgsql_schema_t;
>>>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_database_type:db_schema
>>>>> sepgsql_temp_schema_t "pg_temp";
>>>>>
>>>>> - =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_table =A0{ getattr use=
 select update
>>>>> insert delete lock };
>>>>> - =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_column { getattr use s=
elect update insert };
>>>>> - =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_tuple =A0{ use select =
update insert delete };
>>>>> - =A0 =A0 =A0 type_transition $2 sepgsql_database_type:db_table
>>>>> user_sepgsql_table_t; =A0 =A0 =A0 =A0 =A0 # deprecated
>>>>> + =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_table =A0{ getattr sel=
ect update
>>>>> insert delete lock };
>>>>> + =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_column { getattr selec=
t update insert };
>>>>> + =A0 =A0 =A0 allow $2 user_sepgsql_table_t:db_tuple =A0{ select upda=
te insert delete };
>>>>> =A0 =A0 =A0 =A0type_transition $2 {sepgsql_schema_type -
>>>>> sepgsql_temp_schema_t}:db_table user_sepgsql_table_t;
>>>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_temp_schema_t:db_table sepg=
sql_temp_table_t;
>>>>>
>>>>> @@ -89,7 +88,6 @@ interface(`postgresql_role',`
>>>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_temp_schema_t:db_view sepgs=
ql_temp_view_t;
>>>>>
>>>>> =A0 =A0 =A0 =A0allow $2 user_sepgsql_proc_exec_t:db_procedure { getat=
tr execute };
>>>>> - =A0 =A0 =A0 type_transition $2 sepgsql_database_type:db_procedure
>>>>> user_sepgsql_proc_exec_t; =A0 =A0 =A0 # deprecated
>>>>> =A0 =A0 =A0 =A0type_transition $2 {sepgsql_schema_type -
>>>>> sepgsql_temp_schema_t}:db_procedure user_sepgsql_proc_exec_t;
>>>>> =A0 =A0 =A0 =A0type_transition $2 sepgsql_temp_schema_t:db_procedure
>>>>> sepgsql_temp_proc_exec_t;
>>>>>
>>>>> @@ -513,10 +511,9 @@ interface(`postgresql_unpriv_client',`
>>>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_database_type:db_schema unp=
riv_sepgsql_schema_t;
>>>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_database_type:db_schema
>>>>> unpriv_sepgsql_schema_t "pg_temp";
>>>>>
>>>>> - =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_table { getattr use =
select update
>>>>> insert delete lock };
>>>>> - =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_column { getattr use=
 select
>>>>> update insert };
>>>>> - =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_tuple { use select u=
pdate insert delete };
>>>>> - =A0 =A0 =A0 type_transition $1 sepgsql_database_type:db_table
>>>>> unpriv_sepgsql_table_t; # deprecated
>>>>> + =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_table { getattr sele=
ct update
>>>>> insert delete lock };
>>>>> + =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_column { getattr sel=
ect update insert };
>>>>> + =A0 =A0 =A0 allow $1 unpriv_sepgsql_table_t:db_tuple { select updat=
e insert delete };
>>>>> =A0 =A0 =A0 =A0type_transition $1 {sepgsql_schema_type -
>>>>> sepgsql_temp_schema_t}:db_table unpriv_sepgsql_table_t;
>>>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_temp_schema_t:db_table sepg=
sql_temp_table_t;
>>>>>
>>>>> @@ -532,7 +529,6 @@ interface(`postgresql_unpriv_client',`
>>>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_sysobj_table_type:db_tuple =
unpriv_sepgsql_sysobj_t;
>>>>>
>>>>> =A0 =A0 =A0 =A0allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { get=
attr execute };
>>>>> - =A0 =A0 =A0 type_transition $1 sepgsql_database_type:db_procedure
>>>>> unpriv_sepgsql_proc_exec_t; # deprecated
>>>>> =A0 =A0 =A0 =A0type_transition $1 {sepgsql_schema_type -
>>>>> sepgsql_temp_schema_t}:db_procedure unpriv_sepgsql_proc_exec_t;
>>>>> =A0 =A0 =A0 =A0type_transition $1 sepgsql_temp_schema_t:db_procedure
>>>>> sepgsql_temp_proc_exec_t;
>>>>>
>>>>> diff --git a/policy/modules/services/postgresql.te
>>>>> b/policy/modules/services/postgresql.te
>>>>> index 8a3c2bd..92d6e66 100644
>>>>> --- a/policy/modules/services/postgresql.te
>>>>> +++ b/policy/modules/services/postgresql.te
>>>>> @@ -259,7 +259,6 @@ tunable_policy(`sepgsql_transmit_client_label',`
>>>>> =A0')
>>>>>
>>>>> =A0allow postgresql_t sepgsql_database_type:db_database *;
>>>>> -type_transition postgresql_t postgresql_t:db_database
>>>>> sepgsql_db_t; =A0 =A0 =A0 =A0 =A0 # deprecated
>>>>>
>>>>> =A0allow postgresql_t sepgsql_module_type:db_database install_module;
>>>>> =A0# Database/Loadable module
>>>>> @@ -270,7 +269,6 @@ type_transition postgresql_t
>>>>> sepgsql_database_type:db_schema sepgsql_schema_t;
>>>>> =A0type_transition postgresql_t sepgsql_database_type:db_schema
>>>>> sepgsql_temp_schema_t "pg_temp";
>>>>>
>>>>> =A0allow postgresql_t sepgsql_table_type:{ db_table db_column db_tupl=
e } *;
>>>>> -type_transition postgresql_t sepgsql_database_type:db_table
>>>>> sepgsql_sysobj_t; =A0 =A0 =A0 # deprecated
>>>>> =A0type_transition postgresql_t sepgsql_schema_type:db_table sepgsql_=
sysobj_t;
>>>>>
>>>>> =A0allow postgresql_t sepgsql_sequence_type:db_sequence *;
>>>>> @@ -280,7 +278,6 @@ allow postgresql_t sepgsql_view_type:db_view *;
>>>>> =A0type_transition postgresql_t sepgsql_schema_type:db_view sepgsql_v=
iew_t;
>>>>>
>>>>> =A0allow postgresql_t sepgsql_procedure_type:db_procedure *;
>>>>> -type_transition postgresql_t sepgsql_database_type:db_procedure
>>>>> sepgsql_proc_exec_t; =A0 =A0# deprecated
>>>>> =A0type_transition postgresql_t sepgsql_schema_type:db_procedure
>>>>> sepgsql_proc_exec_t;
>>>>>
>>>>> =A0allow postgresql_t sepgsql_blob_type:db_blob *;
>>>>> @@ -431,23 +428,23 @@ type_transition sepgsql_client_type
>>>>> sepgsql_client_type:db_database sepgsql_db_t
>>>>>
>>>>> =A0allow sepgsql_client_type sepgsql_schema_t:db_schema { getattr sea=
rch };
>>>>>
>>>>> -allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr
>>>>> use select insert lock };
>>>>> -allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr
>>>>> use select insert };
>>>>> -allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use selec=
t insert };
>>>>> +allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr
>>>>> select insert lock };
>>>>> +allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr
>>>>> select insert };
>>>>> +allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { select in=
sert };
>>>>>
>>>>> -allow sepgsql_client_type sepgsql_table_t:db_table { getattr use
>>>>> select update insert delete lock };
>>>>> -allow sepgsql_client_type sepgsql_table_t:db_column { getattr use
>>>>> select update insert };
>>>>> -allow sepgsql_client_type sepgsql_table_t:db_tuple { use select
>>>>> update insert delete };
>>>>> +allow sepgsql_client_type sepgsql_table_t:db_table { getattr select
>>>>> update insert delete lock };
>>>>> +allow sepgsql_client_type sepgsql_table_t:db_column { getattr select
>>>>> update insert };
>>>>> +allow sepgsql_client_type sepgsql_table_t:db_tuple { select update
>>>>> insert delete };
>>>>>
>>>>> -allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use
>>>>> select lock };
>>>>> -allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr use=
 select };
>>>>> -allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { use select }=
;
>>>>> +allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr sele=
ct lock };
>>>>> +allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr sel=
ect };
>>>>> +allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { select };
>>>>>
>>>>> =A0allow sepgsql_client_type sepgsql_secret_table_t:db_table getattr;
>>>>> =A0allow sepgsql_client_type sepgsql_secret_table_t:db_column getattr=
;
>>>>>
>>>>> -allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use
>>>>> select lock };
>>>>> -allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use s=
elect };
>>>>> +allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr select=
 lock };
>>>>> +allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr selec=
t };
>>>>> =A0allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select }=
;
>>>>>
>>>>> =A0allow sepgsql_client_type sepgsql_temp_table_t:db_table ~{ relabel=
to
>>>>> relabelfrom };
>>>>> @@ -503,7 +500,6 @@ tunable_policy(`sepgsql_enable_users_ddl',`
>>>>> =A0#
>>>>>
>>>>> =A0allow sepgsql_admin_type sepgsql_database_type:db_database { creat=
e
>>>>> drop getattr setattr relabelfrom relabelto access };
>>>>> -type_transition sepgsql_admin_type sepgsql_admin_type:db_database
>>>>> sepgsql_db_t; =A0 =A0 =A0 =A0 =A0 # deprecated
>>>>>
>>>>> =A0allow sepgsql_admin_type sepgsql_schema_type:db_schema { create dr=
op
>>>>> getattr setattr relabelfrom relabelto search add_name remove_name };
>>>>> =A0type_transition sepgsql_admin_type sepgsql_database_type:db_schema
>>>>> sepgsql_schema_t;
>>>>> @@ -513,7 +509,6 @@ allow sepgsql_admin_type
>>>>> sepgsql_table_type:db_table { create drop getattr setat
>>>>> =A0allow sepgsql_admin_type sepgsql_table_type:db_column { create dro=
p
>>>>> getattr setattr relabelfrom relabelto };
>>>>> =A0allow sepgsql_admin_type sepgsql_sysobj_table_type:db_tuple {
>>>>> relabelfrom relabelto select update insert delete };
>>>>>
>>>>> -type_transition sepgsql_admin_type sepgsql_database_type:db_table
>>>>> sepgsql_table_t; =A0 =A0 =A0 =A0# deprecated
>>>>> =A0type_transition sepgsql_admin_type sepgsql_schema_type:db_table
>>>>> sepgsql_table_t;
>>>>>
>>>>> =A0allow sepgsql_admin_type sepgsql_sequence_type:db_sequence { creat=
e
>>>>> drop getattr setattr relabelfrom relabelto get_value next_value
>>>>> set_value };
>>>>> @@ -527,7 +522,6 @@ type_transition sepgsql_admin_type
>>>>> sepgsql_schema_type:db_view sepgsql_view_t;
>>>>> =A0allow sepgsql_admin_type sepgsql_procedure_type:db_procedure { cre=
ate
>>>>> drop getattr relabelfrom relabelto };
>>>>> =A0allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure execute;
>>>>>
>>>>> -type_transition sepgsql_admin_type sepgsql_database_type:db_procedur=
e
>>>>> sepgsql_proc_exec_t; =A0 =A0# deprecated
>>>>> =A0type_transition sepgsql_admin_type sepgsql_schema_type:db_procedur=
e
>>>>> sepgsql_proc_exec_t;
>>>>>
>>>>> =A0allow sepgsql_admin_type sepgsql_language_type:db_language { creat=
e
>>>>> drop getattr setattr relabelfrom relabelto execute };
>>>>> @@ -566,14 +560,11 @@ tunable_policy(`sepgsql_unconfined_dbadm',`
>>>>> =A0#
>>>>>
>>>>> =A0allow sepgsql_unconfined_type sepgsql_database_type:db_database *;
>>>>> -type_transition sepgsql_unconfined_type
>>>>> sepgsql_unconfined_type:db_database sepgsql_db_t; =A0 =A0 =A0 # depre=
cated
>>>>>
>>>>> =A0allow sepgsql_unconfined_type sepgsql_schema_type:db_schema *;
>>>>> =A0type_transition sepgsql_unconfined_type
>>>>> sepgsql_database_type:db_schema sepgsql_schema_t;
>>>>> =A0type_transition sepgsql_unconfined_type
>>>>> sepgsql_database_type:db_schema sepgsql_schema_t "pg_temp";
>>>>>
>>>>> -type_transition sepgsql_unconfined_type
>>>>> sepgsql_database_type:db_table sepgsql_table_t; =A0 =A0 =A0 =A0 # dep=
recated
>>>>> -type_transition sepgsql_unconfined_type
>>>>> sepgsql_database_type:db_procedure sepgsql_proc_exec_t; # deprecated
>>>>> =A0type_transition sepgsql_unconfined_type sepgsql_schema_type:db_tab=
le
>>>>> sepgsql_table_t;
>>>>> =A0type_transition sepgsql_unconfined_type
>>>>> sepgsql_schema_type:db_sequence sepgsql_seq_t;
>>>>> =A0type_transition sepgsql_unconfined_type sepgsql_schema_type:db_vie=
w
>>>>> sepgsql_view_t;
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com



--=20
KaiGai Kohei <kaigai@kaigai.gr.jp>

--f46d0401730bedaaca04bfc28da6
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-4of4-redefine-use-permission.20120511.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-4of4-redefine-use-permission.20120511.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h239927x0

IHBvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycyAgICAgICAgICAgfCAgICA0ICstLS0KIHBvbGlj
eS9tY3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0ICsrLS0KIHBvbGljeS9tbHMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0ICsrLS0KIHBvbGljeS9tb2R1bGVzL3Nl
cnZpY2VzL3Bvc3RncmVzcWwuaWYgfCAgIDE2ICsrKysrKy0tLS0tLS0tLS0KIHBvbGljeS9tb2R1
bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUgfCAgIDMzICsrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9wb2xpY3kvZmxhc2svYWNjZXNzX3ZlY3RvcnMgYi9wb2xpY3kv
Zmxhc2svYWNjZXNzX3ZlY3RvcnMKaW5kZXggYmYyNDE2MC4uZjQ2MmU5NSAxMDA2NDQKLS0tIGEv
cG9saWN5L2ZsYXNrL2FjY2Vzc192ZWN0b3JzCisrKyBiL3BvbGljeS9mbGFzay9hY2Nlc3NfdmVj
dG9ycwpAQCAtNzYxLDcgKzc2MSw2IEBAIGluaGVyaXRzIGRhdGFiYXNlCiBjbGFzcyBkYl90YWJs
ZQogaW5oZXJpdHMgZGF0YWJhc2UKIHsKLQl1c2UJCSMgZGVwcmVjYXRlZAogCXNlbGVjdAogCXVw
ZGF0ZQogCWluc2VydApAQCAtNzgwLDcgKzc3OSw2IEBAIGluaGVyaXRzIGRhdGFiYXNlCiBjbGFz
cyBkYl9jb2x1bW4KIGluaGVyaXRzIGRhdGFiYXNlCiB7Ci0JdXNlCQkjIGRlcHJlY2F0ZWQKIAlz
ZWxlY3QKIAl1cGRhdGUKIAlpbnNlcnQKQEAgLTc5MCw3ICs3ODgsNyBAQCBjbGFzcyBkYl90dXBs
ZQogewogCXJlbGFiZWxmcm9tCiAJcmVsYWJlbHRvCi0JdXNlCQkjIGRlcHJlY2F0ZWQKKwl1c2UK
IAlzZWxlY3QKIAl1cGRhdGUKIAlpbnNlcnQKZGlmZiAtLWdpdCBhL3BvbGljeS9tY3MgYi9wb2xp
Y3kvbWNzCmluZGV4IDIxNzU1NzIuLmY0NzdjN2YgMTAwNjQ0Ci0tLSBhL3BvbGljeS9tY3MKKysr
IGIvcG9saWN5L21jcwpAQCAtMTIwLDEwICsxMjAsMTAgQEAgbWxzY29uc3RyYWluIGRiX2RhdGFi
YXNlIHsgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVsYWJlbGZyb20gYWNjZXNzIGluc3RhbGxfbW9k
dWwKIG1sc2NvbnN0cmFpbiBkYl9zY2hlbWEgeyBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVs
ZnJvbSBzZWFyY2ggfQogCSggaDEgZG9tIGgyICk7CiAKLW1sc2NvbnN0cmFpbiBkYl90YWJsZSB7
IGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9tIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRl
bGV0ZSB1c2UgbG9jayB9CittbHNjb25zdHJhaW4gZGJfdGFibGUgeyBkcm9wIGdldGF0dHIgc2V0
YXR0ciByZWxhYmVsZnJvbSBzZWxlY3QgdXBkYXRlIGluc2VydCBkZWxldGUgbG9jayB9CiAJKCBo
MSBkb20gaDIgKTsKIAotbWxzY29uc3RyYWluIGRiX2NvbHVtbiB7IGRyb3AgZ2V0YXR0ciBzZXRh
dHRyIHJlbGFiZWxmcm9tIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IHVzZSB9CittbHNjb25zdHJhaW4g
ZGJfY29sdW1uIHsgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVsYWJlbGZyb20gc2VsZWN0IHVwZGF0
ZSBpbnNlcnQgfQogCSggaDEgZG9tIGgyICk7CiAKIG1sc2NvbnN0cmFpbiBkYl90dXBsZSB7IHJl
bGFiZWxmcm9tIHNlbGVjdCB1cGRhdGUgZGVsZXRlIHVzZSB9CmRpZmYgLS1naXQgYS9wb2xpY3kv
bWxzIGIvcG9saWN5L21scwppbmRleCA3YzBiZWNjLi5kMjE4Mzg3IDEwMDY0NAotLS0gYS9wb2xp
Y3kvbWxzCisrKyBiL3BvbGljeS9tbHMKQEAgLTc0OSwxMyArNzQ5LDEzIEBAIG1sc2NvbnN0cmFp
biB7IGRiX3NjaGVtYSB9IHsgZ2V0YXR0ciBzZWFyY2ggfQogCSAoIHQxID09IG1sc2RicmVhZCAp
IG9yCiAJICggdDIgPT0gbWxzdHJ1c3RlZG9iamVjdCApKTsKIAotbWxzY29uc3RyYWluIHsgZGJf
dGFibGUgfSB7IGdldGF0dHIgdXNlIHNlbGVjdCBsb2NrIH0KK21sc2NvbnN0cmFpbiB7IGRiX3Rh
YmxlIH0geyBnZXRhdHRyIHNlbGVjdCBsb2NrIH0KIAkoKCBsMSBkb20gbDIgKSBvcgogCSAoKCB0
MSA9PSBtbHNkYnJlYWR0b2NsciApIGFuZCAoIGgxIGRvbSBsMiApKSBvcgogCSAoIHQxID09IG1s
c2RicmVhZCApIG9yCiAJICggdDIgPT0gbWxzdHJ1c3RlZG9iamVjdCApKTsKIAotbWxzY29uc3Ry
YWluIHsgZGJfY29sdW1uIH0geyBnZXRhdHRyIHVzZSBzZWxlY3QgfQorbWxzY29uc3RyYWluIHsg
ZGJfY29sdW1uIH0geyBnZXRhdHRyIHNlbGVjdCB9CiAJKCggbDEgZG9tIGwyICkgb3IKIAkgKCgg
dDEgPT0gbWxzZGJyZWFkdG9jbHIgKSBhbmQgKCBoMSBkb20gbDIgKSkgb3IKIAkgKCB0MSA9PSBt
bHNkYnJlYWQgKSBvcgpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdy
ZXNxbC5pZiBiL3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwuaWYKaW5kZXggNmYz
MGIxYS4uYzlmZjA0OSAxMDA2NDQKLS0tIGEvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdy
ZXNxbC5pZgorKysgYi9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLmlmCkBAIC02
OCwxMCArNjgsOSBAQCBpbnRlcmZhY2UoYHBvc3RncmVzcWxfcm9sZScsYAogCXR5cGVfdHJhbnNp
dGlvbiAkMiBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfc2NoZW1hIHVzZXJfc2VwZ3NxbF9zY2hl
bWFfdDsKIAl0eXBlX3RyYW5zaXRpb24gJDIgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3NjaGVt
YSBzZXBnc3FsX3RlbXBfb2JqZWN0X3QgInBnX3RlbXAiOwogCi0JYWxsb3cgJDIgdXNlcl9zZXBn
c3FsX3RhYmxlX3Q6ZGJfdGFibGUJeyBnZXRhdHRyIHVzZSBzZWxlY3QgdXBkYXRlIGluc2VydCBk
ZWxldGUgbG9jayB9OwotCWFsbG93ICQyIHVzZXJfc2VwZ3NxbF90YWJsZV90OmRiX2NvbHVtbiB7
IGdldGF0dHIgdXNlIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IH07Ci0JYWxsb3cgJDIgdXNlcl9zZXBn
c3FsX3RhYmxlX3Q6ZGJfdHVwbGUJeyB1c2Ugc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIH07
Ci0JdHlwZV90cmFuc2l0aW9uICQyIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl90YWJsZSB1c2Vy
X3NlcGdzcWxfdGFibGVfdDsJCSMgZGVwcmVjYXRlZAorCWFsbG93ICQyIHVzZXJfc2VwZ3NxbF90
YWJsZV90OmRiX3RhYmxlCXsgZ2V0YXR0ciBzZWxlY3QgdXBkYXRlIGluc2VydCBkZWxldGUgbG9j
ayB9OworCWFsbG93ICQyIHVzZXJfc2VwZ3NxbF90YWJsZV90OmRiX2NvbHVtbiB7IGdldGF0dHIg
c2VsZWN0IHVwZGF0ZSBpbnNlcnQgfTsKKwlhbGxvdyAkMiB1c2VyX3NlcGdzcWxfdGFibGVfdDpk
Yl90dXBsZQl7IHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0ZSB9OwogCXR5cGVfdHJhbnNpdGlv
biAkMiBzZXBnc3FsX3NjaGVtYV90eXBlOmRiX3RhYmxlIHVzZXJfc2VwZ3NxbF90YWJsZV90Owog
CiAJYWxsb3cgJDIgdXNlcl9zZXBnc3FsX3N5c29ial90OmRiX3R1cGxlCXsgdXNlIHNlbGVjdCB9
OwpAQCAtODQsNyArODMsNiBAQCBpbnRlcmZhY2UoYHBvc3RncmVzcWxfcm9sZScsYAogCXR5cGVf
dHJhbnNpdGlvbiAkMiBzZXBnc3FsX3NjaGVtYV90eXBlOmRiX3ZpZXcgdXNlcl9zZXBnc3FsX3Zp
ZXdfdDsKIAogCWFsbG93ICQyIHVzZXJfc2VwZ3NxbF9wcm9jX2V4ZWNfdDpkYl9wcm9jZWR1cmUg
eyBnZXRhdHRyIGV4ZWN1dGUgfTsKLQl0eXBlX3RyYW5zaXRpb24gJDIgc2VwZ3NxbF9kYXRhYmFz
ZV90eXBlOmRiX3Byb2NlZHVyZSB1c2VyX3NlcGdzcWxfcHJvY19leGVjX3Q7CSMgZGVwcmVjYXRl
ZAogCXR5cGVfdHJhbnNpdGlvbiAkMiBzZXBnc3FsX3NjaGVtYV90eXBlOmRiX3Byb2NlZHVyZSB1
c2VyX3NlcGdzcWxfcHJvY19leGVjX3Q7CiAKIAlhbGxvdyAkMiB1c2VyX3NlcGdzcWxfYmxvYl90
OmRiX2Jsb2IgeyBjcmVhdGUgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVhZCB3cml0ZSBpbXBvcnQg
ZXhwb3J0IH07CkBAIC01MDYsMTAgKzUwNCw5IEBAIGludGVyZmFjZShgcG9zdGdyZXNxbF91bnBy
aXZfY2xpZW50JyxgCiAJdHlwZV90cmFuc2l0aW9uICQxIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpk
Yl9zY2hlbWEgdW5wcml2X3NlcGdzcWxfc2NoZW1hX3Q7CiAJdHlwZV90cmFuc2l0aW9uICQxIHNl
cGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgc2VwZ3NxbF90ZW1wX29iamVjdF90ICJwZ190
ZW1wIjsKIAotCWFsbG93ICQxIHVucHJpdl9zZXBnc3FsX3RhYmxlX3Q6ZGJfdGFibGUgeyBnZXRh
dHRyIHVzZSBzZWxlY3QgdXBkYXRlIGluc2VydCBkZWxldGUgbG9jayB9OwotCWFsbG93ICQxIHVu
cHJpdl9zZXBnc3FsX3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0YXR0ciB1c2Ugc2VsZWN0IHVwZGF0
ZSBpbnNlcnQgfTsKLQlhbGxvdyAkMSB1bnByaXZfc2VwZ3NxbF90YWJsZV90OmRiX3R1cGxlIHsg
dXNlIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0ZSB9OwotCXR5cGVfdHJhbnNpdGlvbiAkMSBz
ZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfdGFibGUgdW5wcml2X3NlcGdzcWxfdGFibGVfdDsJIyBk
ZXByZWNhdGVkCisJYWxsb3cgJDEgdW5wcml2X3NlcGdzcWxfdGFibGVfdDpkYl90YWJsZSB7IGdl
dGF0dHIgc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIGxvY2sgfTsKKwlhbGxvdyAkMSB1bnBy
aXZfc2VwZ3NxbF90YWJsZV90OmRiX2NvbHVtbiB7IGdldGF0dHIgc2VsZWN0IHVwZGF0ZSBpbnNl
cnQgfTsKKwlhbGxvdyAkMSB1bnByaXZfc2VwZ3NxbF90YWJsZV90OmRiX3R1cGxlIHsgc2VsZWN0
IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIH07CiAJdHlwZV90cmFuc2l0aW9uICQxIHNlcGdzcWxfc2No
ZW1hX3R5cGU6ZGJfdGFibGUgdW5wcml2X3NlcGdzcWxfdGFibGVfdDsKIAogCWFsbG93ICQxIHVu
cHJpdl9zZXBnc3FsX3NlcV90OmRiX3NlcXVlbmNlIHsgZ2V0YXR0ciBnZXRfdmFsdWUgbmV4dF92
YWx1ZSBzZXRfdmFsdWUgfTsKQEAgLTUyMiw3ICs1MTksNiBAQCBpbnRlcmZhY2UoYHBvc3RncmVz
cWxfdW5wcml2X2NsaWVudCcsYAogCXR5cGVfdHJhbnNpdGlvbiAkMSBzZXBnc3FsX3N5c29ial90
YWJsZV90eXBlOmRiX3R1cGxlIHVucHJpdl9zZXBnc3FsX3N5c29ial90OwogCiAJYWxsb3cgJDEg
dW5wcml2X3NlcGdzcWxfcHJvY19leGVjX3Q6ZGJfcHJvY2VkdXJlIHsgZ2V0YXR0ciBleGVjdXRl
IH07Ci0JdHlwZV90cmFuc2l0aW9uICQxIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9wcm9jZWR1
cmUgdW5wcml2X3NlcGdzcWxfcHJvY19leGVjX3Q7ICMgZGVwcmVjYXRlZAogCXR5cGVfdHJhbnNp
dGlvbiAkMSBzZXBnc3FsX3NjaGVtYV90eXBlOmRiX3Byb2NlZHVyZSB1bnByaXZfc2VwZ3NxbF9w
cm9jX2V4ZWNfdDsKIAogCWFsbG93ICQxIHVucHJpdl9zZXBnc3FsX2Jsb2JfdDpkYl9ibG9iIHsg
Y3JlYXRlIGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlYWQgd3JpdGUgaW1wb3J0IGV4cG9ydCB9Owpk
aWZmIC0tZ2l0IGEvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZSBiL3BvbGlj
eS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUKaW5kZXggYzZmYmM0YS4uYjgyOGVmMSAx
MDA2NDQKLS0tIGEvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZQorKysgYi9w
b2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlCkBAIC0yNTcsNyArMjU3LDYgQEAg
dHVuYWJsZV9wb2xpY3koYHNlcGdzcWxfdHJhbnNtaXRfY2xpZW50X2xhYmVsJyxgCiAnKQogCiBh
bGxvdyBwb3N0Z3Jlc3FsX3Qgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX2RhdGFiYXNlICo7Ci10
eXBlX3RyYW5zaXRpb24gcG9zdGdyZXNxbF90IHBvc3RncmVzcWxfdDpkYl9kYXRhYmFzZSBzZXBn
c3FsX2RiX3Q7CQkjIGRlcHJlY2F0ZWQKIAogYWxsb3cgcG9zdGdyZXNxbF90IHNlcGdzcWxfbW9k
dWxlX3R5cGU6ZGJfZGF0YWJhc2UgaW5zdGFsbF9tb2R1bGU7CiAjIERhdGFiYXNlL0xvYWRhYmxl
IG1vZHVsZQpAQCAtMjY4LDcgKzI2Nyw2IEBAIHR5cGVfdHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3Qg
c2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3NjaGVtYSBzZXBnc3FsX3NjaGVtYV90OwogdHlwZV90
cmFuc2l0aW9uIHBvc3RncmVzcWxfdCBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfc2NoZW1hIHNl
cGdzcWxfdGVtcF9vYmplY3RfdCAicGdfdGVtcCI7CiAKIGFsbG93IHBvc3RncmVzcWxfdCBzZXBn
c3FsX3RhYmxlX3R5cGU6eyBkYl90YWJsZSBkYl9jb2x1bW4gZGJfdHVwbGUgfSAqOwotdHlwZV90
cmFuc2l0aW9uIHBvc3RncmVzcWxfdCBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfdGFibGUgc2Vw
Z3NxbF9zeXNvYmpfdDsJIyBkZXByZWNhdGVkCiB0eXBlX3RyYW5zaXRpb24gcG9zdGdyZXNxbF90
IHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJfdGFibGUgc2VwZ3NxbF9zeXNvYmpfdDsKIAogYWxsb3cg
cG9zdGdyZXNxbF90IHNlcGdzcWxfc2VxdWVuY2VfdHlwZTpkYl9zZXF1ZW5jZSAqOwpAQCAtMjc4
LDcgKzI3Niw2IEBAIGFsbG93IHBvc3RncmVzcWxfdCBzZXBnc3FsX3ZpZXdfdHlwZTpkYl92aWV3
ICo7CiB0eXBlX3RyYW5zaXRpb24gcG9zdGdyZXNxbF90IHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJf
dmlldyBzZXBnc3FsX3ZpZXdfdDsKIAogYWxsb3cgcG9zdGdyZXNxbF90IHNlcGdzcWxfcHJvY2Vk
dXJlX3R5cGU6ZGJfcHJvY2VkdXJlICo7Ci10eXBlX3RyYW5zaXRpb24gcG9zdGdyZXNxbF90IHNl
cGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9wcm9jZWR1cmUgc2VwZ3NxbF9wcm9jX2V4ZWNfdDsJIyBk
ZXByZWNhdGVkCiB0eXBlX3RyYW5zaXRpb24gcG9zdGdyZXNxbF90IHNlcGdzcWxfc2NoZW1hX3R5
cGU6ZGJfcHJvY2VkdXJlIHNlcGdzcWxfcHJvY19leGVjX3Q7CiAKIGFsbG93IHBvc3RncmVzcWxf
dCBzZXBnc3FsX2Jsb2JfdHlwZTpkYl9ibG9iICo7CkBAIC00MjksMjMgKzQyNiwyMyBAQCB0eXBl
X3RyYW5zaXRpb24gc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX2NsaWVudF90eXBlOmRiX2Rh
dGFiYXNlIHNlcGdzcWxfZGJfdAogCiBhbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxf
c2NoZW1hX3Q6ZGJfc2NoZW1hIHsgZ2V0YXR0ciBzZWFyY2ggfTsKIAotYWxsb3cgc2VwZ3NxbF9j
bGllbnRfdHlwZSBzZXBnc3FsX2ZpeGVkX3RhYmxlX3Q6ZGJfdGFibGUgeyBnZXRhdHRyIHVzZSBz
ZWxlY3QgaW5zZXJ0IGxvY2sgfTsKLWFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9m
aXhlZF90YWJsZV90OmRiX2NvbHVtbiB7IGdldGF0dHIgdXNlIHNlbGVjdCBpbnNlcnQgfTsKLWFs
bG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9maXhlZF90YWJsZV90OmRiX3R1cGxlIHsg
dXNlIHNlbGVjdCBpbnNlcnQgfTsKK2FsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9m
aXhlZF90YWJsZV90OmRiX3RhYmxlIHsgZ2V0YXR0ciBzZWxlY3QgaW5zZXJ0IGxvY2sgfTsKK2Fs
bG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9maXhlZF90YWJsZV90OmRiX2NvbHVtbiB7
IGdldGF0dHIgc2VsZWN0IGluc2VydCB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBn
c3FsX2ZpeGVkX3RhYmxlX3Q6ZGJfdHVwbGUgeyBzZWxlY3QgaW5zZXJ0IH07CiAKLWFsbG93IHNl
cGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF90YWJsZV90OmRiX3RhYmxlIHsgZ2V0YXR0ciB1c2Ug
c2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIGxvY2sgfTsKLWFsbG93IHNlcGdzcWxfY2xpZW50
X3R5cGUgc2VwZ3NxbF90YWJsZV90OmRiX2NvbHVtbiB7IGdldGF0dHIgdXNlIHNlbGVjdCB1cGRh
dGUgaW5zZXJ0IH07Ci1hbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfdGFibGVfdDpk
Yl90dXBsZSB7IHVzZSBzZWxlY3QgdXBkYXRlIGluc2VydCBkZWxldGUgfTsKK2FsbG93IHNlcGdz
cWxfY2xpZW50X3R5cGUgc2VwZ3NxbF90YWJsZV90OmRiX3RhYmxlIHsgZ2V0YXR0ciBzZWxlY3Qg
dXBkYXRlIGluc2VydCBkZWxldGUgbG9jayB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBz
ZXBnc3FsX3RhYmxlX3Q6ZGJfY29sdW1uIHsgZ2V0YXR0ciBzZWxlY3QgdXBkYXRlIGluc2VydCB9
OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3RhYmxlX3Q6ZGJfdHVwbGUgeyBz
ZWxlY3QgdXBkYXRlIGluc2VydCBkZWxldGUgfTsKIAotYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlw
ZSBzZXBnc3FsX3JvX3RhYmxlX3Q6ZGJfdGFibGUgeyBnZXRhdHRyIHVzZSBzZWxlY3QgbG9jayB9
OwotYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3JvX3RhYmxlX3Q6ZGJfY29sdW1u
IHsgZ2V0YXR0ciB1c2Ugc2VsZWN0IH07Ci1hbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdz
cWxfcm9fdGFibGVfdDpkYl90dXBsZSB7IHVzZSBzZWxlY3QgfTsKK2FsbG93IHNlcGdzcWxfY2xp
ZW50X3R5cGUgc2VwZ3NxbF9yb190YWJsZV90OmRiX3RhYmxlIHsgZ2V0YXR0ciBzZWxlY3QgbG9j
ayB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3JvX3RhYmxlX3Q6ZGJfY29s
dW1uIHsgZ2V0YXR0ciBzZWxlY3QgfTsKK2FsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3Nx
bF9yb190YWJsZV90OmRiX3R1cGxlIHsgc2VsZWN0IH07CiAKIGFsbG93IHNlcGdzcWxfY2xpZW50
X3R5cGUgc2VwZ3NxbF9zZWNyZXRfdGFibGVfdDpkYl90YWJsZSBnZXRhdHRyOwogYWxsb3cgc2Vw
Z3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3NlY3JldF90YWJsZV90OmRiX2NvbHVtbiBnZXRhdHRy
OwogCi1hbGxvdyBzZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfc3lzb2JqX3Q6ZGJfdGFibGUg
eyBnZXRhdHRyIHVzZSBzZWxlY3QgbG9jayB9OwotYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBz
ZXBnc3FsX3N5c29ial90OmRiX2NvbHVtbiB7IGdldGF0dHIgdXNlIHNlbGVjdCB9OworYWxsb3cg
c2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3N5c29ial90OmRiX3RhYmxlIHsgZ2V0YXR0ciBz
ZWxlY3QgbG9jayB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3N5c29ial90
OmRiX2NvbHVtbiB7IGdldGF0dHIgc2VsZWN0IH07CiBhbGxvdyBzZXBnc3FsX2NsaWVudF90eXBl
IHNlcGdzcWxfc3lzb2JqX3Q6ZGJfdHVwbGUgeyB1c2Ugc2VsZWN0IH07CiAKIGFsbG93IHNlcGdz
cWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9zZXFfdDpkYl9zZXF1ZW5jZSB7IGdldGF0dHIgZ2V0X3Zh
bHVlIG5leHRfdmFsdWUgfTsKQEAgLTQ5Nyw3ICs0OTQsNiBAQCB0dW5hYmxlX3BvbGljeShgc2Vw
Z3NxbF9lbmFibGVfdXNlcnNfZGRsJyxgCiAjCiAKIGFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBz
ZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfZGF0YWJhc2UgeyBjcmVhdGUgZHJvcCBnZXRhdHRyIHNl
dGF0dHIgcmVsYWJlbGZyb20gcmVsYWJlbHRvIGFjY2VzcyB9OwotdHlwZV90cmFuc2l0aW9uIHNl
cGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX2FkbWluX3R5cGU6ZGJfZGF0YWJhc2Ugc2VwZ3NxbF9k
Yl90OwkJIyBkZXByZWNhdGVkCiAKIGFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3Nj
aGVtYV90eXBlOmRiX3NjaGVtYSB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVs
ZnJvbSByZWxhYmVsdG8gc2VhcmNoIGFkZF9uYW1lIHJlbW92ZV9uYW1lIH07CiB0eXBlX3RyYW5z
aXRpb24gc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEg
c2VwZ3NxbF9zY2hlbWFfdDsKQEAgLTUwNSw5ICs1MDEsOCBAQCB0eXBlX3RyYW5zaXRpb24gc2Vw
Z3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgc2VwZ3NxbF90
ZW1wXwogCiBhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF90YWJsZV90eXBlOmRiX3Rh
YmxlIHsgY3JlYXRlIGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9tIHJlbGFiZWx0byBs
b2NrIH07CiBhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF90YWJsZV90eXBlOmRiX2Nv
bHVtbiB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVsZnJvbSByZWxhYmVsdG8g
fTsKLWFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3N5c29ial90YWJsZV90eXBlOmRi
X3R1cGxlIHsgcmVsYWJlbGZyb20gcmVsYWJlbHRvIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IGRlbGV0
ZSB9OworYWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfc3lzb2JqX3RhYmxlX3R5cGU6
ZGJfdHVwbGUgeyByZWxhYmVsZnJvbSByZWxhYmVsdG8gdXNlIHNlbGVjdCB1cGRhdGUgaW5zZXJ0
IGRlbGV0ZSB9OwogCi10eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxf
ZGF0YWJhc2VfdHlwZTpkYl90YWJsZSBzZXBnc3FsX3RhYmxlX3Q7CSMgZGVwcmVjYXRlZAogdHlw
ZV90cmFuc2l0aW9uIHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX3NjaGVtYV90eXBlOmRiX3Rh
YmxlIHNlcGdzcWxfdGFibGVfdDsKIAogYWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxf
c2VxdWVuY2VfdHlwZTpkYl9zZXF1ZW5jZSB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0YXR0ciBy
ZWxhYmVsZnJvbSByZWxhYmVsdG8gZ2V0X3ZhbHVlIG5leHRfdmFsdWUgc2V0X3ZhbHVlIH07CkBA
IC01MjEsNyArNTE2LDYgQEAgdHlwZV90cmFuc2l0aW9uIHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBn
c3FsX3NjaGVtYV90eXBlOmRiX3ZpZXcgc2VwZ3NxbF92aWV3X3Q7CiBhbGxvdyBzZXBnc3FsX2Fk
bWluX3R5cGUgc2VwZ3NxbF9wcm9jZWR1cmVfdHlwZTpkYl9wcm9jZWR1cmUgeyBjcmVhdGUgZHJv
cCBnZXRhdHRyIHJlbGFiZWxmcm9tIHJlbGFiZWx0byB9OwogYWxsb3cgc2VwZ3NxbF9hZG1pbl90
eXBlIHNlcGdzcWxfcHJvY19leGVjX3Q6ZGJfcHJvY2VkdXJlIGV4ZWN1dGU7CiAKLXR5cGVfdHJh
bnNpdGlvbiBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3Byb2Nl
ZHVyZSBzZXBnc3FsX3Byb2NfZXhlY190OwkjIGRlcHJlY2F0ZWQKIHR5cGVfdHJhbnNpdGlvbiBz
ZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9zY2hlbWFfdHlwZTpkYl9wcm9jZWR1cmUgc2VwZ3Nx
bF9wcm9jX2V4ZWNfdDsKIAogYWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfbGFuZ3Vh
Z2VfdHlwZTpkYl9sYW5ndWFnZSB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVs
ZnJvbSByZWxhYmVsdG8gZXhlY3V0ZSB9OwpAQCAtNTYyLDE0ICs1NTYsMTEgQEAgYWxsb3cgc2Vw
Z3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfdGVtcF9vYmplY3RfdDp7ZGJfc2NoZW1hIGRiX3RhYmxl
IGRiX2NvbHVtbiBkYl8KICMKIAogYWxsb3cgc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3Nx
bF9kYXRhYmFzZV90eXBlOmRiX2RhdGFiYXNlICo7Ci10eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF91
bmNvbmZpbmVkX3R5cGUgc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGU6ZGJfZGF0YWJhc2Ugc2VwZ3Nx
bF9kYl90OwkjIGRlcHJlY2F0ZWQKIAogYWxsb3cgc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUge3Nl
cGdzcWxfc2NoZW1hX3R5cGUgc2VwZ3NxbF90ZW1wX29iamVjdF90fTpkYl9zY2hlbWEgKjsKIHR5
cGVfdHJhbnNpdGlvbiBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX2RhdGFiYXNlX3R5
cGU6ZGJfc2NoZW1hIHNlcGdzcWxfc2NoZW1hX3Q7CiB0eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF91
bmNvbmZpbmVkX3R5cGUgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3NjaGVtYSBzZXBnc3FsX3Rl
bXBfb2JqZWN0X3QgInBnX3RlbXAiOwogCi10eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF91bmNvbmZp
bmVkX3R5cGUgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3RhYmxlIHNlcGdzcWxfdGFibGVfdDsJ
CSMgZGVwcmVjYXRlZAotdHlwZV90cmFuc2l0aW9uIHNlcGdzcWxfdW5jb25maW5lZF90eXBlIHNl
cGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9wcm9jZWR1cmUgc2VwZ3NxbF9wcm9jX2V4ZWNfdDsJIyBk
ZXByZWNhdGVkCiB0eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3Nx
bF9zY2hlbWFfdHlwZTpkYl90YWJsZSBzZXBnc3FsX3RhYmxlX3Q7CiB0eXBlX3RyYW5zaXRpb24g
c2VwZ3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3NxbF9zY2hlbWFfdHlwZTpkYl9zZXF1ZW5jZSBz
ZXBnc3FsX3NlcV90OwogdHlwZV90cmFuc2l0aW9uIHNlcGdzcWxfdW5jb25maW5lZF90eXBlIHNl
cGdzcWxfc2NoZW1hX3R5cGU6ZGJfdmlldyBzZXBnc3FsX3ZpZXdfdDsK
--f46d0401730bedaaca04bfc28da6
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-3of4-temp-database-objects.20120511.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-3of4-temp-database-objects.20120511.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h239927z1

IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwuaWYgfCAgICA0ICsrKysKIHBvbGlj
eS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUgfCAgIDI1ICsrKysrKysrKysrKysrKysr
KysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLmlmIGIv
cG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC5pZgppbmRleCA1OTQ2YjZhLi42ZjMw
YjFhIDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLmlmCisr
KyBiL3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwuaWYKQEAgLTM3LDYgKzM3LDcg
QEAgaW50ZXJmYWNlKGBwb3N0Z3Jlc3FsX3JvbGUnLGAKIAkJdHlwZSB1c2VyX3NlcGdzcWxfc2No
ZW1hX3QsIHVzZXJfc2VwZ3NxbF9zZXFfdDsKIAkJdHlwZSB1c2VyX3NlcGdzcWxfc3lzb2JqX3Qs
IHVzZXJfc2VwZ3NxbF90YWJsZV90OwogCQl0eXBlIHVzZXJfc2VwZ3NxbF92aWV3X3Q7CisJCXR5
cGUgc2VwZ3NxbF90ZW1wX29iamVjdF90OwogCScpCiAKIAkjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjCkBAIC02NSw2ICs2Niw3IEBAIGludGVyZmFjZShgcG9zdGdyZXNx
bF9yb2xlJyxgCiAKIAlhbGxvdyAkMiB1c2VyX3NlcGdzcWxfc2NoZW1hX3Q6ZGJfc2NoZW1hIHsg
Z2V0YXR0ciBzZWFyY2ggYWRkX25hbWUgcmVtb3ZlX25hbWUgfTsKIAl0eXBlX3RyYW5zaXRpb24g
JDIgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3NjaGVtYSB1c2VyX3NlcGdzcWxfc2NoZW1hX3Q7
CisJdHlwZV90cmFuc2l0aW9uICQyIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgc2Vw
Z3NxbF90ZW1wX29iamVjdF90ICJwZ190ZW1wIjsKIAogCWFsbG93ICQyIHVzZXJfc2VwZ3NxbF90
YWJsZV90OmRiX3RhYmxlCXsgZ2V0YXR0ciB1c2Ugc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRl
IGxvY2sgfTsKIAlhbGxvdyAkMiB1c2VyX3NlcGdzcWxfdGFibGVfdDpkYl9jb2x1bW4geyBnZXRh
dHRyIHVzZSBzZWxlY3QgdXBkYXRlIGluc2VydCB9OwpAQCAtNDY5LDYgKzQ3MSw3IEBAIGludGVy
ZmFjZShgcG9zdGdyZXNxbF91bnByaXZfY2xpZW50JyxgCiAJCXR5cGUgdW5wcml2X3NlcGdzcWxf
c2NoZW1hX3QsIHVucHJpdl9zZXBnc3FsX3NlcV90OwogCQl0eXBlIHVucHJpdl9zZXBnc3FsX3N5
c29ial90LCB1bnByaXZfc2VwZ3NxbF90YWJsZV90OwogCQl0eXBlIHVucHJpdl9zZXBnc3FsX3Zp
ZXdfdDsKKwkJdHlwZSBzZXBnc3FsX3RlbXBfb2JqZWN0X3Q7CiAJJykKIAogCSMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKQEAgLTUwMSw2ICs1MDQsNyBAQCBpbnRlcmZh
Y2UoYHBvc3RncmVzcWxfdW5wcml2X2NsaWVudCcsYAogCScpCiAJYWxsb3cgJDEgdW5wcml2X3Nl
cGdzcWxfc2NoZW1hX3Q6ZGJfc2NoZW1hIHsgZ2V0YXR0ciBhZGRfbmFtZSByZW1vdmVfbmFtZSB9
OwogCXR5cGVfdHJhbnNpdGlvbiAkMSBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJfc2NoZW1hIHVu
cHJpdl9zZXBnc3FsX3NjaGVtYV90OworCXR5cGVfdHJhbnNpdGlvbiAkMSBzZXBnc3FsX2RhdGFi
YXNlX3R5cGU6ZGJfc2NoZW1hIHNlcGdzcWxfdGVtcF9vYmplY3RfdCAicGdfdGVtcCI7CiAKIAlh
bGxvdyAkMSB1bnByaXZfc2VwZ3NxbF90YWJsZV90OmRiX3RhYmxlIHsgZ2V0YXR0ciB1c2Ugc2Vs
ZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRlIGxvY2sgfTsKIAlhbGxvdyAkMSB1bnByaXZfc2VwZ3Nx
bF90YWJsZV90OmRiX2NvbHVtbiB7IGdldGF0dHIgdXNlIHNlbGVjdCB1cGRhdGUgaW5zZXJ0IH07
CmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlIGIvcG9s
aWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZQppbmRleCBiNDhhY2ExLi5jNmZiYzRh
IDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlCisrKyBi
L3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUKQEAgLTE2NSw2ICsxNjUsMTkg
QEAgb3B0aW9uYWxfcG9saWN5KGAKIAltbHNfcHJvY2Vzc19zZXRfbGV2ZWwoc2VwZ3NxbF9yYW5n
ZWRfcHJvY190KQogJykKIAorIyBUeXBlcyBmb3IgdGVtcG9yYXJ5IG9iamVjdHMKKyMKKyMgWFhY
IC0gQWxsIHRoZSB0ZW1wb3Jhcnkgb2JqZWN0cyBhcmUgZWxpbWluYXRlZCBhdCBlbmQgb2YgZGF0
YWJhc2Ugc2Vzc2lvbgorIyBhbmQgaW52aXNpYmxlIGZyb20gb3RoZXIgc2Vzc2lvbnMsIHNvIGl0
IGlzIHVubmVjZXNzYXJ5IHRvIHJlc3RyaWN0IHVzZXJzCisjIG9wZXJhdGlvbnMgb24gdGVtcG9y
YXJ5IG9iamVjdC4gRm9yIHBvbGljeSBzaW1wbGlmaWNhdGlvbiwgb25seSBvbmUgdHlwZQorIyBp
cyBkZWZpbmVkIGZvciB0ZW1wb3Jhcnkgb2JqZWN0cyB1bmRlciB0aGUgInBnX3RlbXAiIHNjaGVt
YS4KK3R5cGUgc2VwZ3NxbF90ZW1wX29iamVjdF90OworCitwb3N0Z3Jlc3FsX3RhYmxlX29iamVj
dChzZXBnc3FsX3RlbXBfb2JqZWN0X3QpCitwb3N0Z3Jlc3FsX3NlcXVlbmNlX29iamVjdChzZXBn
c3FsX3RlbXBfb2JqZWN0X3QpCitwb3N0Z3Jlc3FsX3ZpZXdfb2JqZWN0KHNlcGdzcWxfdGVtcF9v
YmplY3RfdCkKK3Bvc3RncmVzcWxfcHJvY2VkdXJlX29iamVjdChzZXBnc3FsX3RlbXBfb2JqZWN0
X3QpCisKICMgVHlwZXMgZm9yIHVucHJpdmlsZWdlZCBjbGllbnQKIHR5cGUgdW5wcml2X3NlcGdz
cWxfYmxvYl90OwogcG9zdGdyZXNxbF9ibG9iX29iamVjdCh1bnByaXZfc2VwZ3NxbF9ibG9iX3Qp
CkBAIC0yNTAsOCArMjYzLDkgQEAgYWxsb3cgcG9zdGdyZXNxbF90IHNlcGdzcWxfbW9kdWxlX3R5
cGU6ZGJfZGF0YWJhc2UgaW5zdGFsbF9tb2R1bGU7CiAjIERhdGFiYXNlL0xvYWRhYmxlIG1vZHVs
ZQogYWxsb3cgc2VwZ3NxbF9kYXRhYmFzZV90eXBlIHNlcGdzcWxfbW9kdWxlX3R5cGU6ZGJfZGF0
YWJhc2UgbG9hZF9tb2R1bGU7CiAKLWFsbG93IHBvc3RncmVzcWxfdCBzZXBnc3FsX3NjaGVtYV90
eXBlOmRiX3NjaGVtYSAqOworYWxsb3cgcG9zdGdyZXNxbF90IHtzZXBnc3FsX3NjaGVtYV90eXBl
IHNlcGdzcWxfdGVtcF9vYmplY3RfdH06ZGJfc2NoZW1hICo7CiB0eXBlX3RyYW5zaXRpb24gcG9z
dGdyZXNxbF90IHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgc2VwZ3NxbF9zY2hlbWFf
dDsKK3R5cGVfdHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3Qgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRi
X3NjaGVtYSBzZXBnc3FsX3RlbXBfb2JqZWN0X3QgInBnX3RlbXAiOwogCiBhbGxvdyBwb3N0Z3Jl
c3FsX3Qgc2VwZ3NxbF90YWJsZV90eXBlOnsgZGJfdGFibGUgZGJfY29sdW1uIGRiX3R1cGxlIH0g
KjsKIHR5cGVfdHJhbnNpdGlvbiBwb3N0Z3Jlc3FsX3Qgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRi
X3RhYmxlIHNlcGdzcWxfc3lzb2JqX3Q7CSMgZGVwcmVjYXRlZApAQCAtNDY3LDYgKzQ4MSw5IEBA
IGFsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2VwZ3NxbF9zZWNyZXRfYmxvYl90OmRiX2Jsb2Ig
Z2V0YXR0cjsKICMgVGhlcmVmb3JlLCB0aGUgZm9sbG93aW5nIHJ1bGUgaXMgYXBwbGllZCBmb3Ig
YW55IGRvbWFpbnMgd2hpY2ggY2FuIGNvbm5lY3QgU0UtUG9zdGdyZVNRTC4KIGRvbnRhdWRpdCB7
IHBvc3RncmVzcWxfdCBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBn
c3FsX3VuY29uZmluZWRfdHlwZSB9IHsgc2VwZ3NxbF90YWJsZV90eXBlIC1zZXBnc3FsX3N5c29i
al90YWJsZV90eXBlIH06ZGJfdHVwbGUgeyB1c2Ugc2VsZWN0IHVwZGF0ZSBpbnNlcnQgZGVsZXRl
IH07CiAKKyMgSXQgaXMgYWx3YXlzIGFsbG93ZWQgdG8gb3BlcmF0ZSB0ZW1wb3Jhcnkgb2JqZWN0
cyBmb3IgYW55IGRhdGFiYXNlIGNsaWVudC4KK2FsbG93IHNlcGdzcWxfY2xpZW50X3R5cGUgc2Vw
Z3NxbF90ZW1wX29iamVjdF90OntkYl9zY2hlbWEgZGJfdGFibGUgZGJfY29sdW1uIGRiX3R1cGxl
IGRiX3NlcXVlbmNlIGRiX3ZpZXcgZGJfcHJvY2VkdXJlfSB+eyByZWxhYmVsdG8gcmVsYWJlbGZy
b20gfTsKKwogIyBOb3RlIHRoYXQgcGVybWlzc2lvbiBvZiBjcmVhdGlvbi9kZWxldGlvbiBhcmUg
ZXZlbnR1YWxseSBjb250cm9sbGVkIGJ5CiAjIGNyZWF0ZSBvciBkcm9wIHBlcm1pc3Npb24gb2Yg
aW5kaXZpZHVhbCBvYmplY3RzIHdpdGhpbiBzaGFyZWQgc2NoZW1hcy4KICMgU28sIGl0IGp1c3Qg
YWxsb3dzIHRvIGNyZWF0ZS9kcm9wIHVzZXIgc3BlY2lmaWMgdHlwZXMuCkBAIC00ODQsNiArNTAx
LDcgQEAgdHlwZV90cmFuc2l0aW9uIHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX2FkbWluX3R5
cGU6ZGJfZGF0YWJhc2Ugc2VwZ3NxbF9kYl90OwogCiBhbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUg
c2VwZ3NxbF9zY2hlbWFfdHlwZTpkYl9zY2hlbWEgeyBjcmVhdGUgZHJvcCBnZXRhdHRyIHNldGF0
dHIgcmVsYWJlbGZyb20gcmVsYWJlbHRvIHNlYXJjaCBhZGRfbmFtZSByZW1vdmVfbmFtZSB9Owog
dHlwZV90cmFuc2l0aW9uIHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6
ZGJfc2NoZW1hIHNlcGdzcWxfc2NoZW1hX3Q7Cit0eXBlX3RyYW5zaXRpb24gc2VwZ3NxbF9hZG1p
bl90eXBlIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgc2VwZ3NxbF90ZW1wX29iamVj
dF90ICJwZ190ZW1wIjsKIAogYWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfdGFibGVf
dHlwZTpkYl90YWJsZSB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVsZnJvbSBy
ZWxhYmVsdG8gbG9jayB9OwogYWxsb3cgc2VwZ3NxbF9hZG1pbl90eXBlIHNlcGdzcWxfdGFibGVf
dHlwZTpkYl9jb2x1bW4geyBjcmVhdGUgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVsYWJlbGZyb20g
cmVsYWJlbHRvIH07CkBAIC01MzYsNiArNTU0LDggQEAgdHVuYWJsZV9wb2xpY3koYHNlcGdzcWxf
dW5jb25maW5lZF9kYmFkbScsYAogCWFsbG93IHNlcGdzcWxfYWRtaW5fdHlwZSBzZXBnc3FsX2Js
b2JfdHlwZTpkYl9ibG9iICo7CiAnKQogCithbGxvdyBzZXBnc3FsX2FkbWluX3R5cGUgc2VwZ3Nx
bF90ZW1wX29iamVjdF90OntkYl9zY2hlbWEgZGJfdGFibGUgZGJfY29sdW1uIGRiX3R1cGxlIGRi
X3NlcXVlbmNlIGRiX3ZpZXcgZGJfcHJvY2VkdXJlfSB+eyByZWxhYmVsdG8gcmVsYWJlbGZyb20g
fTsKKwogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwogIwogIyBVbmNv
bmZpbmVkIGFjY2VzcyB0byB0aGlzIG1vZHVsZQpAQCAtNTQ0LDggKzU2NCw5IEBAIHR1bmFibGVf
cG9saWN5KGBzZXBnc3FsX3VuY29uZmluZWRfZGJhZG0nLGAKIGFsbG93IHNlcGdzcWxfdW5jb25m
aW5lZF90eXBlIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9kYXRhYmFzZSAqOwogdHlwZV90cmFu
c2l0aW9uIHNlcGdzcWxfdW5jb25maW5lZF90eXBlIHNlcGdzcWxfdW5jb25maW5lZF90eXBlOmRi
X2RhdGFiYXNlIHNlcGdzcWxfZGJfdDsJIyBkZXByZWNhdGVkCiAKLWFsbG93IHNlcGdzcWxfdW5j
b25maW5lZF90eXBlIHNlcGdzcWxfc2NoZW1hX3R5cGU6ZGJfc2NoZW1hICo7CithbGxvdyBzZXBn
c3FsX3VuY29uZmluZWRfdHlwZSB7c2VwZ3NxbF9zY2hlbWFfdHlwZSBzZXBnc3FsX3RlbXBfb2Jq
ZWN0X3R9OmRiX3NjaGVtYSAqOwogdHlwZV90cmFuc2l0aW9uIHNlcGdzcWxfdW5jb25maW5lZF90
eXBlIHNlcGdzcWxfZGF0YWJhc2VfdHlwZTpkYl9zY2hlbWEgc2VwZ3NxbF9zY2hlbWFfdDsKK3R5
cGVfdHJhbnNpdGlvbiBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX2RhdGFiYXNlX3R5
cGU6ZGJfc2NoZW1hIHNlcGdzcWxfdGVtcF9vYmplY3RfdCAicGdfdGVtcCI7CiAKIHR5cGVfdHJh
bnNpdGlvbiBzZXBnc3FsX3VuY29uZmluZWRfdHlwZSBzZXBnc3FsX2RhdGFiYXNlX3R5cGU6ZGJf
dGFibGUgc2VwZ3NxbF90YWJsZV90OwkJIyBkZXByZWNhdGVkCiB0eXBlX3RyYW5zaXRpb24gc2Vw
Z3NxbF91bmNvbmZpbmVkX3R5cGUgc2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX3Byb2NlZHVyZSBz
ZXBnc3FsX3Byb2NfZXhlY190OwkjIGRlcHJlY2F0ZWQK
--f46d0401730bedaaca04bfc28da6
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-2of4-foreign-data-wrapper.20120511.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-2of4-foreign-data-wrapper.20120511.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h23992802

IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3RncmVzcWwudGUgfCAgIDEwICsrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvcG9saWN5L21v
ZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZSBiL3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bv
c3RncmVzcWwudGUKaW5kZXggNmQ3M2RmMi4uYjQ4YWNhMSAxMDA2NDQKLS0tIGEvcG9saWN5L21v
ZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZQorKysgYi9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNl
cy9wb3N0Z3Jlc3FsLnRlCkBAIC0zMiw2ICszMiwxMyBAQCBnZW5fdHVuYWJsZShzZXBnc3FsX2Vu
YWJsZV91c2Vyc19kZGwsIHRydWUpCiAjIyA8L2Rlc2M+CiBnZW5fdHVuYWJsZShzZXBnc3FsX3Vu
Y29uZmluZWRfZGJhZG0sIHRydWUpCiAKKyMjIDxkZXNjPgorIyMgPHA+CisjIyBBbGxvdyB0cmFu
c21pdCBjbGllbnQgbGFiZWwgdG8gZm9yZWlnbiBkYXRhYmFzZQorIyMgPC9wPgorIyMgPC9kZXNj
PgorZ2VuX3R1bmFibGUoc2VwZ3NxbF90cmFuc21pdF9jbGllbnRfbGFiZWwsIGZhbHNlKQorCiB0
eXBlIHBvc3RncmVzcWxfdDsKIHR5cGUgcG9zdGdyZXNxbF9leGVjX3Q7CiBpbml0X2RhZW1vbl9k
b21haW4ocG9zdGdyZXNxbF90LCBwb3N0Z3Jlc3FsX2V4ZWNfdCkKQEAgLTIzMiw2ICsyMzksOSBA
QCBhbGxvdyBwb3N0Z3Jlc3FsX3Qgc2VsZjp1ZHBfc29ja2V0IGNyZWF0ZV9zdHJlYW1fc29ja2V0
X3Blcm1zOwogYWxsb3cgcG9zdGdyZXNxbF90IHNlbGY6dW5peF9kZ3JhbV9zb2NrZXQgY3JlYXRl
X3NvY2tldF9wZXJtczsKIGFsbG93IHBvc3RncmVzcWxfdCBzZWxmOnVuaXhfc3RyZWFtX3NvY2tl
dCBjcmVhdGVfc3RyZWFtX3NvY2tldF9wZXJtczsKIGFsbG93IHBvc3RncmVzcWxfdCBzZWxmOm5l
dGxpbmtfc2VsaW51eF9zb2NrZXQgY3JlYXRlX3NvY2tldF9wZXJtczsKK3R1bmFibGVfcG9saWN5
KGBzZXBnc3FsX3RyYW5zbWl0X2NsaWVudF9sYWJlbCcsYAorCWFsbG93IHBvc3RncmVzcWxfdCBz
ZWxmOnByb2Nlc3MgeyBzZXRzb2NrY3JlYXRlIH07CisnKQogCiBhbGxvdyBwb3N0Z3Jlc3FsX3Qg
c2VwZ3NxbF9kYXRhYmFzZV90eXBlOmRiX2RhdGFiYXNlICo7CiB0eXBlX3RyYW5zaXRpb24gcG9z
dGdyZXNxbF90IHBvc3RncmVzcWxfdDpkYl9kYXRhYmFzZSBzZXBnc3FsX2RiX3Q7CQkjIGRlcHJl
Y2F0ZWQK
--f46d0401730bedaaca04bfc28da6
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-1of4-connection-pooling-support.20120511.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-1of4-connection-pooling-support.20120511.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h23992813

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
aWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGdyZXNxbC50ZQppbmRleCBmN2I3MmQ0Li42ZDczZGYy
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
--f46d0401730bedaaca04bfc28da6
Content-Type: application/octet-stream;
	name="refpolicy-sepgsql-0of4-fixbug-mcs-mls.20120511.patch"
Content-Disposition: attachment;
	filename="refpolicy-sepgsql-0of4-fixbug-mcs-mls.20120511.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h23992814

IHBvbGljeS9tY3MgfCAgICA0ICsrLS0KIHBvbGljeS9tbHMgfCAgICAyICstCiAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wb2xp
Y3kvbWNzIGIvcG9saWN5L21jcwppbmRleCBkZjhlMGZhLi4yMTc1NTcyIDEwMDY0NAotLS0gYS9w
b2xpY3kvbWNzCisrKyBiL3BvbGljeS9tY3MKQEAgLTExNyw3ICsxMTcsNyBAQCBtbHNjb25zdHJh
aW4geyBkYl90dXBsZSB9IHsgaW5zZXJ0IHJlbGFiZWx0byB9CiBtbHNjb25zdHJhaW4gZGJfZGF0
YWJhc2UgeyBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVsZnJvbSBhY2Nlc3MgaW5zdGFsbF9t
b2R1bGUgbG9hZF9tb2R1bGUgZ2V0X3BhcmFtIHNldF9wYXJhbSB9CiAJKCBoMSBkb20gaDIgKTsK
IAotbWxzY29uc3RyYWluIGRiX2xhbmd1YWdlIHsgZHJvcCBnZXRhdHRyIHNldGF0dHIgcmVsYWJl
bGZyb20gZXhlY3V0ZSB9CittbHNjb25zdHJhaW4gZGJfc2NoZW1hIHsgZHJvcCBnZXRhdHRyIHNl
dGF0dHIgcmVsYWJlbGZyb20gc2VhcmNoIH0KIAkoIGgxIGRvbSBoMiApOwogCiBtbHNjb25zdHJh
aW4gZGJfdGFibGUgeyBkcm9wIGdldGF0dHIgc2V0YXR0ciByZWxhYmVsZnJvbSBzZWxlY3QgdXBk
YXRlIGluc2VydCBkZWxldGUgdXNlIGxvY2sgfQpAQCAtMTM1LDcgKzEzNSw3IEBAIG1sc2NvbnN0
cmFpbiBkYl9zZXF1ZW5jZSB7IGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9tIGdldF92
YWx1ZSBuZXh0X3ZhbHVlCiBtbHNjb25zdHJhaW4gZGJfdmlldyB7IGRyb3AgZ2V0YXR0ciBzZXRh
dHRyIHJlbGFiZWxmcm9tIGV4cGFuZCB9CiAJKCBoMSBkb20gaDIgKTsKIAotbWxzY29uc3RyYWlu
IGRiX3Byb2NlZHVyZSB7IGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9tIGV4ZWN1dGUg
aW5zdGFsbCB9CittbHNjb25zdHJhaW4gZGJfcHJvY2VkdXJlIHsgZHJvcCBnZXRhdHRyIHNldGF0
dHIgcmVsYWJlbGZyb20gZXhlY3V0ZSBpbnN0YWxsIGVudHJ5cG9pbnQgfQogCSggaDEgZG9tIGgy
ICk7CiAKIG1sc2NvbnN0cmFpbiBkYl9sYW5ndWFnZSB7IGRyb3AgZ2V0YXR0ciBzZXRhdHRyIHJl
bGFiZWxmcm9tIGV4ZWN1dGUgfQpkaWZmIC0tZ2l0IGEvcG9saWN5L21scyBiL3BvbGljeS9tbHMK
aW5kZXggMGU4NDc0Yi4uN2MwYmVjYyAxMDA2NDQKLS0tIGEvcG9saWN5L21scworKysgYi9wb2xp
Y3kvbWxzCkBAIC03NzMsNyArNzczLDcgQEAgbWxzY29uc3RyYWluIHsgZGJfdmlldyB9IHsgZ2V0
YXR0ciBleHBhbmQgfQogCSAoIHQxID09IG1sc2RicmVhZCApIG9yCiAJICggdDIgPT0gbWxzdHJ1
c3RlZG9iamVjdCApKTsKIAotbWxzY29uc3RyYWluIHsgZGJfcHJvY2VkdXJlIH0geyBnZXRhdHRy
IGV4ZWN1dGUgaW5zdGFsbCB9CittbHNjb25zdHJhaW4geyBkYl9wcm9jZWR1cmUgfSB7IGdldGF0
dHIgZXhlY3V0ZSBlbnRyeXBvaW50IGluc3RhbGwgfQogCSgoIGwxIGRvbSBsMiApIG9yCiAJICgo
IHQxID09IG1sc2RicmVhZHRvY2xyICkgYW5kICggaDEgZG9tIGwyICkpIG9yCiAJICggdDEgPT0g
bWxzZGJyZWFkICkgb3IK
--f46d0401730bedaaca04bfc28da6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
