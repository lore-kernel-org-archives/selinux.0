Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q41Ir1S4020792
	for <selinux@tycho.nsa.gov>; Tue, 1 May 2012 14:53:01 -0400
Message-ID: <4FA0310D.4090004@tresys.com>
Date: Tue, 1 May 2012 14:53:01 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: <refpolicy@oss1.tresys.com>, SELinux-NSA <selinux@tycho.nsa.gov>
Subject: Re: [3/4] sepgsql - Add temporary objects support
References: <CADyhKSWqX5t1UK-zGFYLbqoCjP+9Bf9H3dOM8VHSNwsybg15AA@mail.gmail.com>
In-Reply-To: <CADyhKSWqX5t1UK-zGFYLbqoCjP+9Bf9H3dOM8VHSNwsybg15AA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

On 03/25/12 17:15, Kohei KaiGai wrote:
> This patch adds a special case handling on creation of temporary
> schema; "pg_temp". The temporary schema shall be labeled as
> "sepgsql_temp_schema" in the default, then underlying objects
> also labeled as temporary objects; that allows confined users
> to create, drop and so on, even if sepgsql_enable_users_ddl is off.
> 
> In PostgreSQL, all the temporary objects are deployed on "pg_temp"
> schema, then they shall be removed at the session end.
> Thus, it has no possibility to leak any other entities via references to
> the shared database objects, and no need to prevent creation or
> deletion of temporary objects by confined domains.
[...]

> diff --git a/policy/modules/services/postgresql.te
> b/policy/modules/services/postgresql.te
> index add0cd6..8a3c2bd 100644
> --- a/policy/modules/services/postgresql.te
> +++ b/policy/modules/services/postgresql.te
> @@ -164,6 +164,22 @@ optional_policy(`
>  	mls_process_set_level(sepgsql_ranged_proc_t)
>  ')
> 
> +# Types for temporary objects
> +type sepgsql_temp_schema_t;
> +postgresql_schema_object(sepgsql_temp_schema_t)
> +
> +type sepgsql_temp_table_t;
> +postgresql_table_object(sepgsql_temp_table_t)
> +
> +type sepgsql_temp_seq_t;
> +postgresql_table_object(sepgsql_temp_seq_t)
> +
> +type sepgsql_temp_view_t;
> +postgresql_view_object(sepgsql_temp_view_t)
> +
> +type sepgsql_temp_proc_exec_t;
> +postgresql_procedure_object(sepgsql_temp_proc_exec_t)

Why do you have a temp type for each of the object classes?  I don't see it gaining anything in the policy and it would be simpler to have a single type.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
