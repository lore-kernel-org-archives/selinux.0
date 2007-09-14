Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8EDbq1w024605
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2007 09:37:52 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8EDbpIt014685
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2007 13:37:51 GMT
Subject: Re: [refpolicy] apt and dpkg changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <415EF526-2C14-4AF6-91A2-7AEC4692823C@sf-net.com>
References: <415EF526-2C14-4AF6-91A2-7AEC4692823C@sf-net.com>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 09:36:19 -0400
Message-Id: <1189776979.11871.6.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-08-18 at 02:28 -0400, Stefan Schulze Frielinghaus wrote:
> +template(`apt_per_role_template',`
[...]
> +        type $1_apt_t;
> +        domain_type($1_apt_t)
> +        domain_entry_file($1_apt_t,apt_exec_t)
> +       role $3 types $1_apt_t;
> +
> +       type $1_home_apt_t;
> +       files_type($1_home_apt_t)
[...]
> +       manage_dirs_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
> +       manage_files_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
> +
> +       allow apt_t $1_home_dir_t:dir search;
> +')

Why is this needed?

> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (apt.te.patch),
> "apt.te.patch"
> 
> --- /usr/src/refpolicy-20070629/policy/modules/admin/apt.te     2007-06-29 16:48:13.000000000 +0200
> +++ policy/modules/admin/apt.te 2007-08-16 17:46:35.000000000 +0200
> @@ -1,6 +1,10 @@
>  
>  policy_module(apt,1.2.0)
>  
> +gen_require(`
> +       type var_log_t;
> +')
[...]
> +# append to logfile
> +allow apt_t var_log_t:dir search;
> +append_files_pattern(apt_t,apt_log_t,apt_log_t)

Requiring and using an external type like this is not allowed.

> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (domain.if.patch), "domain.if.patch"
> 
> --- /usr/src/refpolicy-20070629/policy/modules/kernel/domain.if 2007-06-19 15:02:26.000000000 +0200
> +++ /etc/selinux/my-refpolicy-strict/src/policy/policy/modules/kernel/domain.if 2007-08-14 17:13:09.000000000 +0200
> @@ -61,6 +61,12 @@
>         optional_policy(`
>                 rpm_use_fds($1)
>                 rpm_read_pipes($1)
> +
> +               apt_use_fds($1)
> +               apt_read_pipes($1)
> +
> +               dpkg_use_fds($1)
> +               dpkg_read_pipes($1)
>         ')

I find these questionable (as evidenced by the existing comment right
above the optional_policy line.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
