Message-Id: <200406041218.i54CIEh15674@alexru.adsl.kis.ru>
From: "Igor Borisovsky" <_bip_@inbox.ru>
To: <SELinux@tycho.nsa.gov>
Subject: Access to the postgresql data files
Date: Fri, 4 Jun 2004 16:15:26 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  
Hi.
I have a question about selinux policy configuration for FC2.
I need to forbid access to the postgresql data files from user root.
I guess i have to create certain type for postgresql. Let's name this type
pgsql.
Thus i have something like that:
[root selinux pgsql]# pwd
/var/lib/pgsql
[root selinux pgsql]# ls -aZ
drwx------+ postgres postgres postgres:object_r:pgsql_home_dir_t .
drwxr-xr-x  root     root     system_u:object_r:var_lib_t      ..
drwx------  postgres postgres postgres:object_r:pgsql_home_dir_t backups
-rw-------  postgres postgres postgres:object_r:pgsql_home_t   .bash_history
-rw-r--r--  postgres postgres postgres:object_r:pgsql_home_t   .bash_profile
drwx------  postgres postgres postgres:object_r:pgsql_home_dir_t data
-rw-r--r--  postgres postgres postgres:object_r:pgsql_home_t   initdb.i18n
drwxr-xr-x+ postgres postgres postgres:object_r:pgsql_home_t   .mc
[root selinux pgsql]#
So far user root within sysadm_r role has access to the postgresql data
files.
I guess i need to find and revoke this permission from sysadm_r role.
After looking at the policy.conf file I can't understand this.
So how can i prevent access to postgresql data files from user root?
Thanks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
