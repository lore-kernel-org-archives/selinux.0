Subject: Re: SUDO package
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <3EA021A5.4020603@redhat.com>
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
	 <200304181408.55003.russell@coker.com.au>  <3EA021A5.4020603@redhat.com>
Content-Type: text/plain
Message-Id: <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Apr 2003 10:19:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-04-18 at 12:02, Daniel J Walsh wrote:
> I have placed the latest sudo code in
> 
> ftp://people.redhat.com/dwalsh/SELinux/sudo
> 
> This code seems to work with the provided policy.  I have provided a src 
> rpm,
> and binary i386.rpm (for 8.0) and the two policy files.  
> 
> The binary i386 will install the policy files and reload the updated 
> policy.  It
> also does a chsid on the /usr/bin/sudo.  
> 
> This is my first try at writing Policy so please send me comments.

Thanks for working on this task.  A few comments on your policy below:

># Read the /dir/*
>allow sudo_t var_t:dir search;

The comment doesn't seem to match the rule.  There is a rule later in
your sudo.te file that does grant read access to all types for the
directory class, but that isn't desirable.  You should explicitly
enumerate the types to which sudo needs access.

># Read the /etc/*
>allow sudo_t etc_t:file r_file_perms;

You should also grant search access to etc_t directories here.

># Read /dev directories and any symbolic links.
>allow sudo_t device_t:dir r_dir_perms;

The comment suggests that you also wanted 'allow sudo_t
device_t:lnk_file r_file_perms;'.

>type sudo_exec_t, file_type, exec_type, sysadmfile;
>domain_auto_trans(userdomain, sudo_exec_t, sudo_t)

The comment from the top of sudo.te about sudo_exec_t would seem to
belong with these rules.

>allow sudo_t user_home_dir_type:dir search;

Does sudo need to search the user's home directory in order to function,
or is this just an unnecessary probe during initialization?  It might be
sufficient to use dontaudit to suppress the audit message without
granting the permission.

># Allow sudo_t to transition to user domains.
># domain_trans(sudo_t, shell_exec_t, userdomain)
>domain_trans(sudo_t,{ bin_t sbin_t exec_type }, userdomain)
>domain_trans(sudo_t, ls_exec_t, userdomain)

The exec_type attribute includes shell_exec_t and ls_exec_t, so you
don't need separate rules for them.  Ultimately, we should define a
separate attribute specifically for programs that should be executable
via sudo, and only apply it to those programs, rather than using the
more pervasive exec_type.

>allow sudo_t self:udp_socket { create ioctl };
>allow sudo_t self:file { read write };
>allow sudo_t self:lnk_file { read };

The first rule above appears to be to support the load_interfaces() call
by sudo, so you might annotate it with a comment to that effect.
general_domain_access grants read access to the /proc/pid entries for
the domain, so I don't think you need the latter two rules (and I'm not
clear as to why you would need to grant write permission to self:file). 
># Use capabilities.
>allow sudo_t self:capability { setuid setgid net_bind_service
>dac_override sys_resource};

Does sudo truly require all of these capabilities?  Also, this rule is
duplicated a second time further down in the sudo.te file.

>allow sudo_t *:dir r_dir_perms;
>#allow sudo_t *:file read;

Using '*' considered harmful, except for permission sets.  In addition
to being excessively permissive (does sudo truly need to be able to read
every directory in the system), it yields a large number of meaningless
rules, because '*' expands to the full set of types, many of which can
never be associated with a directory anyway.  If you truly needed to
grant access to all files, you would use something like 'allow sudo_t
file_type:dir r_dir_perms;', but I don't think that this is justified.
I should probably drop '*' support out of the language except for
permission sets.

># Relabel terminals.
>#allow sudo_t ttyfile:chr_file { getattr relabelfrom relabelto };
>#allow sudo_t ptyfile:chr_file { getattr relabelfrom relabelto };

It doesn't appear that this functionality is implemented in your sudo
patch yet; newrole relabels the tty or pty to a type derived from the
new domain so that the terminal is protected properly.

># Access terminals.
>allow sudo_t tty_device_t:chr_file { getattr relabelfrom relabelto
rw_file_perms ioctl};
>allow sudo_t devtty_t:chr_file { getattr relabelfrom relabelto
rw_file_perms ioctl};

I don't believe that these two rules are necessary.  sudo should only
need to relabel and access the derived tty and pty types covered by the
ttyfile and ptyfile type attributes.

>allow sudo_t ttyfile:chr_file { getattr relabelfrom relabelto
rw_file_perms};
>allow sudo_t ptyfile:chr_file { getattr relabelfrom relabelto
rw_file_perms};
>ifdef(`gnome-pty-helper.te', `allow sudo_t gphdomain:fd use;')

Here you have mixed rules for relabeling with rules for access, which is
ok, but the comment doesn't reflect it, and you still have the earlier
rules for relabeling in sudo.te (but commented out).

>#
># Allow sysadm_t to reap a user_t process 
># created via sudo.
>#
>allow userdomain userdomain:process { sigchld };

This doesn't truly belong in sudo.te (or in newrole.te), and should be
reduced down to only grant this permission for pairs of domains that can
be legitimately transitioned via sudo or newrole.

># Additional type_change rules to deal with ttys that
># were left in an old type due to an expected termination of sudo.
>type_change sysadm_t user_tty_device_t:chr_file sysadm_tty_device_t;
>type_change user_t sysadm_tty_device_t:chr_file user_tty_device_t;
>type_change sysadm_t user_devpts_t:chr_file sysadm_devpts_t;
>type_change user_t sysadm_devpts_t:chr_file user_devpts_t;

These rules (and the corresponding ones in newrole.te) should be moved
somewhere common to avoid duplication.

># create run file 
>allow sudo_t var_run_t:file create_file_perms;
>allow sudo_t var_run_t:dir create_dir_perms;

I would recommend defining a separate type for sudo's /var/run files,
e.g.:
type sudo_var_run_t, file_type, sysadmfile;
file_type_auto_trans(sudo_t, var_run_t, sudo_var_run_t)

And you will need to define an entry in sudo.fc to initially assign
sudo_var_run_t to /var/run/sudo.

># Everything else is in the sudo_domain macro in
># macros/program/sudo_macros.te.

I think that this comment is obsolete (unless there is a macro that you
haven't shown to us).

># Failed reads to /proc cause no harm, so don't audit them
>dontaudit sudo_t proc_t:dir search;
>dontaudit sudo_t proc_t:lnk_file read;

You could grant these permissions so that sudo can access its /proc/self
entries if you wanted to do so.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
