Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8BJHngf019520
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 15:17:49 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8BJHibe009966
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 19:17:47 GMT
Subject: Re: [PATCH] refpolicy: system_locallogin changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022027.l72KRTWh032129@redsox.boston.devel.redhat.com>
References: <200708022027.l72KRTWh032129@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 11 Sep 2007 15:16:15 -0400
Message-Id: <1189538175.7512.16.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:27 -0400, dwalsh@redhat.com wrote:
> Change local_login to no longer be unconfined
> Now talks dbus

Merged.

> --- nsaserefpolicy/policy/modules/system/locallogin.te  2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/locallogin.te
> 2007-08-02 11:02:02.000000000 -0400
> @@ -25,6 +25,7 @@
>  domain_role_change_exemption(sulogin_t)
>  domain_interactive_fd(sulogin_t)
>  init_domain(sulogin_t,sulogin_exec_t)
> +init_system_domain(sulogin_t,sulogin_exec_t)
>  role system_r types sulogin_t;
> 
>  ########################################
> @@ -97,6 +98,11 @@
>  term_setattr_all_user_ttys(local_login_t)
>  term_setattr_unallocated_ttys(local_login_t)
> 
> +tunable_policy(`allow_console_login', `
> +     term_relabel_console(local_login_t)
> +     term_setattr_console(local_login_t)
> +')
> +
>  auth_rw_login_records(local_login_t)
>  auth_rw_faillog(local_login_t)
>  auth_manage_pam_console_data(local_login_t)
> @@ -160,6 +166,15 @@
>  ')
> 
>  optional_policy(`
> +       consolekit_dbus_chat(local_login_t)
> +')
> +
> +optional_policy(`
> +       dbus_system_bus_client_template(local_login,local_login_t)
> +       dbus_send_system_bus(local_login_t)
> +')
> +
> +optional_policy(`
>         gpm_getattr_gpmctl(local_login_t)
>         gpm_setattr_gpmctl(local_login_t)
>  ')
> @@ -178,13 +193,18 @@
>  ')
> 
>  optional_policy(`
> -       unconfined_domain(local_login_t)
> +       unconfined_shell_domtrans(local_login_t)
>  ')
> 
>  optional_policy(`
>         usermanage_read_crack_db(local_login_t)
>  ')
> 
> +optional_policy(`
> +       xserver_read_xdm_tmp_files(local_login_t)
> +       xserver_rw_xdm_tmp_files(local_login_t)
> +')
> +
>  #################################
>  #
>  # Sulogin local policy
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
