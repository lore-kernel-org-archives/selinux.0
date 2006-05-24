Date: Wed, 24 May 2006 09:20:14 -0700
Subject: Fedora Core 5 Tomcat 4 problems
From: "Michael K. Smith" <mksmith@adhost.com>
To: <SELinux@tycho.nsa.gov>
Message-ID: <C099D5CE.24D51%mksmith@adhost.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All:

I am attempting to start Tomcat 4 using an rc script that uses the
unprivileged user "tomcat" to run the application.  The relevant line is:

su -l tomcat -p -s /bin/bash -c /usr/local/tomcat/bin/startup.sh

In addition, the tomcat user has /sbin/nologin in the password file.

Steps to make it work:

1) Set SELinux to permissive and reboot
2) Take resultant AVC messages and create local policy
3) Load policy, set SELinux to enforcing and reboot

If I leave SELinux in permissive the tomcat script works just fine and, if I
allow root to run tomcat that works as well.  I would like to have the
security of SELinux and an unprivileged user running Tomcat, so any help
would be greatly appreciated.

Below is a copy of the local.te file that was generated from the AVC
messages in /var/log/messages after setting to permissive.  The Tomcat
directory is /usr/local/tomcat and shows as:

drwxr-xr-x  tomcat   tomcat   user_u:object_r:usr_t
jakarta-tomcat-4.1.31

lrwxrwxrwx  root     root     user_u:object_r:usr_t            tomcat ->
/usr/local/jakarta-tomcat-4.1.31

Thanks in advance,

Mike


module local 1.0;

require {
        class lnk_file read;
        class dir { getattr search };
        class security compute_av;
        class file { execmod getattr read };

        type initrc_su_t;
        type usr_t;
        type file_t;
        type hald_t;
        type initrc_su_t;
        type initrc_t;
        type locale_t;
        type mysqld_db_t;
        type pam_console_t;
        type security_t;
        type semanage_t;
        type user_home_t;
        type initrc_t;
        type locale_t;
 };

allow initrc_su_t usr_t:lnk_file read;
allow hald_t mysqld_db_t:dir getattr;
allow initrc_su_t security_t:security compute_av;
allow pam_console_t file_t:dir search;
allow initrc_t user_home_t:file execmod;
allow semanage_t locale_t:file { getattr read };


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
