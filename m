Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q44DXw8j028196
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 09:33:58 -0400
Received: by lbbgk8 with SMTP id gk8so2206864lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 04 May 2012 06:33:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADyhKSXLR1rHgOd8Kfb3spNVWZ3Y5-mM9zYECWaC=ebmYvf-=w@mail.gmail.com>
References: <CADyhKSXLR1rHgOd8Kfb3spNVWZ3Y5-mM9zYECWaC=ebmYvf-=w@mail.gmail.com>
Date: Fri, 4 May 2012 15:33:34 +0200
Message-ID: <CADyhKSUBg4nScZm+CDFX_hcRgbF-OG4y5NSbjk2NOsVK7LHneg@mail.gmail.com>
Subject: Re: [4/4] sepgsql -redefinition of use permission onto system objects
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

The patch 3 of 4 also required the 4 of 4 being refreshed to apply correctly.
In addition, I forgot to allow sepgsql_admin_type to allow to "use" system
objects.

Please check the newer version. Thanks,

2012/3/25 Kohei KaiGai <kaigai@kaigai.gr.jp>:
> This patch might be arguable. It redefines the "use" permission on db_tuple
> class that has marked deprecated for a few years, to control usage of system
> objects but without individual object classes.
>
> We didn't try to port all the supported database object types in PostgreSQL
> into SELinux policy model, because its variation is too large to port and
> less priority in comparison with "major" object classes such as tables.
>
> So, we handle permissions to create, drop and alter these objects as
> permissions to insert, delete or update of system catalogs; labeled as
> sepgsql_sysobj_t, and so on.
>
> On the other hand, some of system objects requires to check permission
> when user "use" these objects, such as data types, tablespaces,
> operators and so on.
> I don't think it is reasonable approach to define individual object classes
> for each object types reflects to PostgreSQL. However, it is preferable
> to have double checks by selinux on strategic points.
>
> So, I try to redefine "use" permission on db_tuple class; that means
> permission to "use" this object when the tuple is an entry of system
> catalog corresponding to a particular database object but don't have
> a particular object class like tables.
>
> The deprecated permissions and rules are not in use for a few years,
> so, it is a time to be utilized or eliminated.
>
> Thanks,
>
>  Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
> --
>  policy/flask/access_vectors           |    4 +---
>  policy/modules/services/postgresql.if |   16 ++++++----------
>  policy/modules/services/postgresql.te |   31 +++++++++++--------------------
>  3 files changed, 18 insertions(+), 33 deletions(-)
>
> diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
> index bf24160..f462e95 100644
> --- a/policy/flask/access_vectors
> +++ b/policy/flask/access_vectors
> @@ -761,7 +761,6 @@ inherits database
>  class db_table
>  inherits database
>  {
> -       use             # deprecated
>        select
>        update
>        insert
> @@ -780,7 +779,6 @@ inherits database
>  class db_column
>  inherits database
>  {
> -       use             # deprecated
>        select
>        update
>        insert
> @@ -790,7 +788,7 @@ class db_tuple
>  {
>        relabelfrom
>        relabelto
> -       use             # deprecated
> +       use
>        select
>        update
>        insert
> diff --git a/policy/modules/services/postgresql.if
> b/policy/modules/services/postgresql.if
> index 56fc5fa..71f2572 100644
> --- a/policy/modules/services/postgresql.if
> +++ b/policy/modules/services/postgresql.if
> @@ -70,10 +70,9 @@ interface(`postgresql_role',`
>        type_transition $2 sepgsql_database_type:db_schema user_sepgsql_schema_t;
>        type_transition $2 sepgsql_database_type:db_schema
> sepgsql_temp_schema_t "pg_temp";
>
> -       allow $2 user_sepgsql_table_t:db_table  { getattr use select update
> insert delete lock };
> -       allow $2 user_sepgsql_table_t:db_column { getattr use select update insert };
> -       allow $2 user_sepgsql_table_t:db_tuple  { use select update insert delete };
> -       type_transition $2 sepgsql_database_type:db_table
> user_sepgsql_table_t;           # deprecated
> +       allow $2 user_sepgsql_table_t:db_table  { getattr select update
> insert delete lock };
> +       allow $2 user_sepgsql_table_t:db_column { getattr select update insert };
> +       allow $2 user_sepgsql_table_t:db_tuple  { select update insert delete };
>        type_transition $2 {sepgsql_schema_type -
> sepgsql_temp_schema_t}:db_table user_sepgsql_table_t;
>        type_transition $2 sepgsql_temp_schema_t:db_table sepgsql_temp_table_t;
>
> @@ -89,7 +88,6 @@ interface(`postgresql_role',`
>        type_transition $2 sepgsql_temp_schema_t:db_view sepgsql_temp_view_t;
>
>        allow $2 user_sepgsql_proc_exec_t:db_procedure { getattr execute };
> -       type_transition $2 sepgsql_database_type:db_procedure
> user_sepgsql_proc_exec_t;       # deprecated
>        type_transition $2 {sepgsql_schema_type -
> sepgsql_temp_schema_t}:db_procedure user_sepgsql_proc_exec_t;
>        type_transition $2 sepgsql_temp_schema_t:db_procedure
> sepgsql_temp_proc_exec_t;
>
> @@ -513,10 +511,9 @@ interface(`postgresql_unpriv_client',`
>        type_transition $1 sepgsql_database_type:db_schema unpriv_sepgsql_schema_t;
>        type_transition $1 sepgsql_database_type:db_schema
> unpriv_sepgsql_schema_t "pg_temp";
>
> -       allow $1 unpriv_sepgsql_table_t:db_table { getattr use select update
> insert delete lock };
> -       allow $1 unpriv_sepgsql_table_t:db_column { getattr use select
> update insert };
> -       allow $1 unpriv_sepgsql_table_t:db_tuple { use select update insert delete };
> -       type_transition $1 sepgsql_database_type:db_table
> unpriv_sepgsql_table_t; # deprecated
> +       allow $1 unpriv_sepgsql_table_t:db_table { getattr select update
> insert delete lock };
> +       allow $1 unpriv_sepgsql_table_t:db_column { getattr select update insert };
> +       allow $1 unpriv_sepgsql_table_t:db_tuple { select update insert delete };
>        type_transition $1 {sepgsql_schema_type -
> sepgsql_temp_schema_t}:db_table unpriv_sepgsql_table_t;
>        type_transition $1 sepgsql_temp_schema_t:db_table sepgsql_temp_table_t;
>
> @@ -532,7 +529,6 @@ interface(`postgresql_unpriv_client',`
>        type_transition $1 sepgsql_sysobj_table_type:db_tuple unpriv_sepgsql_sysobj_t;
>
>        allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { getattr execute };
> -       type_transition $1 sepgsql_database_type:db_procedure
> unpriv_sepgsql_proc_exec_t; # deprecated
>        type_transition $1 {sepgsql_schema_type -
> sepgsql_temp_schema_t}:db_procedure unpriv_sepgsql_proc_exec_t;
>        type_transition $1 sepgsql_temp_schema_t:db_procedure
> sepgsql_temp_proc_exec_t;
>
> diff --git a/policy/modules/services/postgresql.te
> b/policy/modules/services/postgresql.te
> index 8a3c2bd..92d6e66 100644
> --- a/policy/modules/services/postgresql.te
> +++ b/policy/modules/services/postgresql.te
> @@ -259,7 +259,6 @@ tunable_policy(`sepgsql_transmit_client_label',`
>  ')
>
>  allow postgresql_t sepgsql_database_type:db_database *;
> -type_transition postgresql_t postgresql_t:db_database
> sepgsql_db_t;           # deprecated
>
>  allow postgresql_t sepgsql_module_type:db_database install_module;
>  # Database/Loadable module
> @@ -270,7 +269,6 @@ type_transition postgresql_t
> sepgsql_database_type:db_schema sepgsql_schema_t;
>  type_transition postgresql_t sepgsql_database_type:db_schema
> sepgsql_temp_schema_t "pg_temp";
>
>  allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
> -type_transition postgresql_t sepgsql_database_type:db_table
> sepgsql_sysobj_t;       # deprecated
>  type_transition postgresql_t sepgsql_schema_type:db_table sepgsql_sysobj_t;
>
>  allow postgresql_t sepgsql_sequence_type:db_sequence *;
> @@ -280,7 +278,6 @@ allow postgresql_t sepgsql_view_type:db_view *;
>  type_transition postgresql_t sepgsql_schema_type:db_view sepgsql_view_t;
>
>  allow postgresql_t sepgsql_procedure_type:db_procedure *;
> -type_transition postgresql_t sepgsql_database_type:db_procedure
> sepgsql_proc_exec_t;    # deprecated
>  type_transition postgresql_t sepgsql_schema_type:db_procedure
> sepgsql_proc_exec_t;
>
>  allow postgresql_t sepgsql_blob_type:db_blob *;
> @@ -431,23 +428,23 @@ type_transition sepgsql_client_type
> sepgsql_client_type:db_database sepgsql_db_t
>
>  allow sepgsql_client_type sepgsql_schema_t:db_schema { getattr search };
>
> -allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr
> use select insert lock };
> -allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr
> use select insert };
> -allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select insert };
> +allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr
> select insert lock };
> +allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr
> select insert };
> +allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { select insert };
>
> -allow sepgsql_client_type sepgsql_table_t:db_table { getattr use
> select update insert delete lock };
> -allow sepgsql_client_type sepgsql_table_t:db_column { getattr use
> select update insert };
> -allow sepgsql_client_type sepgsql_table_t:db_tuple { use select
> update insert delete };
> +allow sepgsql_client_type sepgsql_table_t:db_table { getattr select
> update insert delete lock };
> +allow sepgsql_client_type sepgsql_table_t:db_column { getattr select
> update insert };
> +allow sepgsql_client_type sepgsql_table_t:db_tuple { select update
> insert delete };
>
> -allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use
> select lock };
> -allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr use select };
> -allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { use select };
> +allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr select lock };
> +allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr select };
> +allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { select };
>
>  allow sepgsql_client_type sepgsql_secret_table_t:db_table getattr;
>  allow sepgsql_client_type sepgsql_secret_table_t:db_column getattr;
>
> -allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use
> select lock };
> -allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use select };
> +allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr select lock };
> +allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr select };
>  allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };
>
>  allow sepgsql_client_type sepgsql_temp_table_t:db_table ~{ relabelto
> relabelfrom };
> @@ -503,7 +500,6 @@ tunable_policy(`sepgsql_enable_users_ddl',`
>  #
>
>  allow sepgsql_admin_type sepgsql_database_type:db_database { create
> drop getattr setattr relabelfrom relabelto access };
> -type_transition sepgsql_admin_type sepgsql_admin_type:db_database
> sepgsql_db_t;           # deprecated
>
>  allow sepgsql_admin_type sepgsql_schema_type:db_schema { create drop
> getattr setattr relabelfrom relabelto search add_name remove_name };
>  type_transition sepgsql_admin_type sepgsql_database_type:db_schema
> sepgsql_schema_t;
> @@ -513,7 +509,6 @@ allow sepgsql_admin_type
> sepgsql_table_type:db_table { create drop getattr setat
>  allow sepgsql_admin_type sepgsql_table_type:db_column { create drop
> getattr setattr relabelfrom relabelto };
>  allow sepgsql_admin_type sepgsql_sysobj_table_type:db_tuple {
> relabelfrom relabelto select update insert delete };
>
> -type_transition sepgsql_admin_type sepgsql_database_type:db_table
> sepgsql_table_t;        # deprecated
>  type_transition sepgsql_admin_type sepgsql_schema_type:db_table
> sepgsql_table_t;
>
>  allow sepgsql_admin_type sepgsql_sequence_type:db_sequence { create
> drop getattr setattr relabelfrom relabelto get_value next_value
> set_value };
> @@ -527,7 +522,6 @@ type_transition sepgsql_admin_type
> sepgsql_schema_type:db_view sepgsql_view_t;
>  allow sepgsql_admin_type sepgsql_procedure_type:db_procedure { create
> drop getattr relabelfrom relabelto };
>  allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure execute;
>
> -type_transition sepgsql_admin_type sepgsql_database_type:db_procedure
> sepgsql_proc_exec_t;    # deprecated
>  type_transition sepgsql_admin_type sepgsql_schema_type:db_procedure
> sepgsql_proc_exec_t;
>
>  allow sepgsql_admin_type sepgsql_language_type:db_language { create
> drop getattr setattr relabelfrom relabelto execute };
> @@ -566,14 +560,11 @@ tunable_policy(`sepgsql_unconfined_dbadm',`
>  #
>
>  allow sepgsql_unconfined_type sepgsql_database_type:db_database *;
> -type_transition sepgsql_unconfined_type
> sepgsql_unconfined_type:db_database sepgsql_db_t;       # deprecated
>
>  allow sepgsql_unconfined_type sepgsql_schema_type:db_schema *;
>  type_transition sepgsql_unconfined_type
> sepgsql_database_type:db_schema sepgsql_schema_t;
>  type_transition sepgsql_unconfined_type
> sepgsql_database_type:db_schema sepgsql_schema_t "pg_temp";
>
> -type_transition sepgsql_unconfined_type
> sepgsql_database_type:db_table sepgsql_table_t;         # deprecated
> -type_transition sepgsql_unconfined_type
> sepgsql_database_type:db_procedure sepgsql_proc_exec_t; # deprecated
>  type_transition sepgsql_unconfined_type sepgsql_schema_type:db_table
> sepgsql_table_t;
>  type_transition sepgsql_unconfined_type
> sepgsql_schema_type:db_sequence sepgsql_seq_t;
>  type_transition sepgsql_unconfined_type sepgsql_schema_type:db_view
> sepgsql_view_t;
>
> --
> KaiGai Kohei <kaigai@kaigai.gr.jp>



-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
