Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CEkc7j031131
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 10:46:38 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8CEka0x026178
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 14:46:36 GMT
Subject: Re: [PATCH] refpolicy: system_logging changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021904.l72J4uKD024298@redsox.boston.devel.redhat.com>
References: <200708021904.l72J4uKD024298@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 14:45:06 +0000
Message-Id: <1189608306.7512.32.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:04 -0400, dwalsh@redhat.com wrote:
> Added policy for new rsyslogd
> Resubmitting logging interfaces for auditing. 
> Added interfaces to be used by new SELinux user logadm_t for managing
> logging environment
> Fix some mistakes in var_log_t should be logfile
> auditctl needs privs to be able to look at non root files

comments inline

> --- nsaserefpolicy/policy/modules/system/logging.fc     2007-05-29 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/logging.fc  2007-08-02 11:02:02.000000000 -0400
> @@ -1,12 +1,15 @@
> -
>  /dev/log               -s      gen_context(system_u:object_r:devlog_t,s0)
> 
> +/etc/rsyslog.conf              gen_context(system_u:object_r:syslog_conf_t,s0)
> +/etc/syslog.conf               gen_context(system_u:object_r:syslog_conf_t,s0)

I'm holding off on this since its not clear why its needed.  I can't
find callers of the interfaces you added.

> +/var/log/syslog-ng(/.*)?       --      gen_context(system_u:object_r:syslogd_var_run_t,s0)

syslogd_var_run_t in /var/log?

> @@ -495,6 +576,8 @@
>         files_search_var($1)
>         manage_files_pattern($1,logfile,logfile)
>         read_lnk_files_pattern($1,logfile,logfile)
> +       allow $1 logfile:dir  { relabelfrom relabelto };
> +       allow $1 logfile:file  { relabelfrom relabelto };
>  ')
> 
Can't add relabeling rules to manage interfaces.

> +interface(`logging_set_loginuid',`
> +       gen_require(`
> +               attribute can_set_loginuid;
> +               attribute can_send_audit_msgs;
> +       ')
> +
> +       typeattribute $1 can_set_loginuid, can_send_audit_msgs;
> +
> +       allow $1 self:capability audit_control;
> +       allow $1 self:netlink_audit_socket { r_netlink_socket_perms nlmsg_relay };
> +')

Was the intention to also send audit messages?  Its incomplete, if so.

> +########################################
> +## <summary>
> +##     Set up audit
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`logging_set_audit',`
> +       gen_require(`
> +               attribute can_set_audit;
> +               attribute can_send_audit_msgs;
> +       ')
> +
> +       typeattribute $1  can_set_audit, can_send_audit_msgs;
> +       allow $1 self:capability { audit_write audit_control };
> +       allow $1 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
> +')
> +
> +########################################
> +## <summary>
> +##     Set audit control rules
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`logging_set_auditctl',`
> +       gen_require(`
> +               attribute can_set_auditctl;
> +       ')
> +
> +       typeattribute $1  can_set_auditctl;
> +       logging_set_audit($1)
> +       allow $1 self:netlink_audit_socket nlmsg_readpriv;
> +')

I don't understand the difference between this interface and the previous one (other than the obvious rule difference).

> +type syslogd_var_lib_t;
> +files_type(syslogd_var_lib_t)

No files labeled with this.

>  # create/append log files.
>  manage_files_pattern(syslogd_t,var_log_t,var_log_t)
> +allow syslogd_t var_run_t:fifo_file { ioctl read write };

removed this line because its a subset of:

> +# r/w log fifo_files files.
> +rw_fifo_files_pattern(syslogd_t,var_log_t,var_log_t)
> +
>  # Allow access for syslog-ng
>  allow syslogd_t var_log_t:dir { create setattr };
> 
Merged the remainder.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
