From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: SUDO package
Date: Wed, 23 Apr 2003 17:10:34 +1000
Cc: SELinux@tycho.nsa.gov
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com> <3EA021A5.4020603@redhat.com> <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304231710.34773.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Apr 2003 00:19, Stephen Smalley wrote:
> >allow sudo_t user_home_dir_type:dir search;
>
> Does sudo need to search the user's home directory in order to function,
> or is this just an unnecessary probe during initialization?  It might be
> sufficient to use dontaudit to suppress the audit message without
> granting the permission.

/bin/login, /bin/su, and sshd all require search access to the user home 
directory.  I recall that last time I tried removing such access it would 
result in $HOME environment variable being set incorrectly and other things 
not working as expected.

> ># Allow sudo_t to transition to user domains.
> ># domain_trans(sudo_t, shell_exec_t, userdomain)
> >domain_trans(sudo_t,{ bin_t sbin_t exec_type }, userdomain)
> >domain_trans(sudo_t, ls_exec_t, userdomain)
>
> The exec_type attribute includes shell_exec_t and ls_exec_t, so you
> don't need separate rules for them.  Ultimately, we should define a
> separate attribute specifically for programs that should be executable
> via sudo, and only apply it to those programs, rather than using the
> more pervasive exec_type.

This is difficult as we often want to allow existing programs that have their 
own type (such as ls) to be run (requiring lots of policy for su) and also we 
require relabelling bin_t and sbin_t programs for this (which requires a new 
attribute for these types so that all the other domains can continue 
executing them).

> I should probably drop '*' support out of the language except for
> permission sets.

Good idea.  If I knew about it when I first started writing policy I'm sure I 
would have misused it horribly.  ;)

> ># Allow sysadm_t to reap a user_t process
> ># created via sudo.
> >#
> >allow userdomain userdomain:process { sigchld };
>
> This doesn't truly belong in sudo.te (or in newrole.te), and should be
> reduced down to only grant this permission for pairs of domains that can
> be legitimately transitioned via sudo or newrole.

However if sudo is to relabel the tty device back to it's original type then 
it has to keep running for the duration of the child process it spawns.  
Therefire the child domain should only be sending sigchld to sudo not to the 
shell which launched sudo.

> ># Additional type_change rules to deal with ttys that
> ># were left in an old type due to an expected termination of sudo.
> >type_change sysadm_t user_tty_device_t:chr_file sysadm_tty_device_t;
> >type_change user_t sysadm_tty_device_t:chr_file user_tty_device_t;
> >type_change sysadm_t user_devpts_t:chr_file sysadm_devpts_t;
> >type_change user_t sysadm_devpts_t:chr_file user_devpts_t;
>
> These rules (and the corresponding ones in newrole.te) should be moved
> somewhere common to avoid duplication.

The role_tty_type_change() macro that is defined and used in domains/user.te 
already does this.  The above is a result of copying from the old newrole.te 
policy.

> ># create run file
> >allow sudo_t var_run_t:file create_file_perms;
> >allow sudo_t var_run_t:dir create_dir_perms;
>
> I would recommend defining a separate type for sudo's /var/run files,
> e.g.:
> type sudo_var_run_t, file_type, sysadmfile;
> file_type_auto_trans(sudo_t, var_run_t, sudo_var_run_t)

In the daemon_domain() macro defined in macros/global_macros.te the naming 
scheme var_run_$1_t is used.  It might make things easier in future to use 
that.

We probably should have a macro var_run_domain() which is used by 
daemon_domain() and by other policy such as the sudo policy.

How about something like the following:
define(`var_run_domain', `
type var_run_$1_t, file_type, sysadmfile, lockfile;
file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
')

Or we could change the naming scheme to something else.  Log files etc have 
the _log_t part appended to the base name of the program domain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
