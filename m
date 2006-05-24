Subject: Re: Fedora Core 5 Tomcat 4 problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Michael K. Smith" <mksmith@adhost.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <C099D5CE.24D51%mksmith@adhost.com>
References: <C099D5CE.24D51%mksmith@adhost.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 13:02:56 -0400
Message-Id: <1148490176.24463.454.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 09:20 -0700, Michael K. Smith wrote:
> Hello All:
> 
> I am attempting to start Tomcat 4 using an rc script that uses the
> unprivileged user "tomcat" to run the application.  The relevant line is:
> 
> su -l tomcat -p -s /bin/bash -c /usr/local/tomcat/bin/startup.sh
> 
> In addition, the tomcat user has /sbin/nologin in the password file.
> 
> Steps to make it work:
> 
> 1) Set SELinux to permissive and reboot
> 2) Take resultant AVC messages and create local policy
> 3) Load policy, set SELinux to enforcing and reboot

Rebooting shouldn't be strictly necessary in the above sequence.

> If I leave SELinux in permissive the tomcat script works just fine and, if I
> allow root to run tomcat that works as well.  I would like to have the
> security of SELinux and an unprivileged user running Tomcat, so any help
> would be greatly appreciated.
> 
> Below is a copy of the local.te file that was generated from the AVC
> messages in /var/log/messages after setting to permissive.  The Tomcat
> directory is /usr/local/tomcat and shows as:
> 
> drwxr-xr-x  tomcat   tomcat   user_u:object_r:usr_t
> jakarta-tomcat-4.1.31
> 
> lrwxrwxrwx  root     root     user_u:object_r:usr_t            tomcat ->
> /usr/local/jakarta-tomcat-4.1.31

This should really be in a different type than just usr_t.

> Thanks in advance,
> 
> Mike
> 
> 
> module local 1.0;
> 
> require {
>         class lnk_file read;
>         class dir { getattr search };
>         class security compute_av;
>         class file { execmod getattr read };
> 
>         type initrc_su_t;
>         type usr_t;
>         type file_t;
>         type hald_t;
>         type initrc_su_t;
>         type initrc_t;
>         type locale_t;
>         type mysqld_db_t;
>         type pam_console_t;
>         type security_t;
>         type semanage_t;
>         type user_home_t;
>         type initrc_t;
>         type locale_t;
>  };
> 
> allow initrc_su_t usr_t:lnk_file read;

su checking for the home directory.

> allow hald_t mysqld_db_t:dir getattr;
> allow initrc_su_t security_t:security compute_av;

pam_rootok permission check from su.

> allow pam_console_t file_t:dir search;
> allow initrc_t user_home_t:file execmod;

Can we see the full avc message for the execmod denial?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
