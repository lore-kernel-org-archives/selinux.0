Subject: Re: Access to the postgresql data files
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Igor Borisovsky <_bip_@inbox.ru>
Cc: SELinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   fedora-selinux-list@redhat.com
In-Reply-To: <200406041218.i54CIEh15674@alexru.adsl.kis.ru>
References: <200406041218.i54CIEh15674@alexru.adsl.kis.ru>
Content-Type: text/plain
Message-Id: <1086352933.19959.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 08:42:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-04 at 08:15, Igor Borisovsky wrote:
>   Hi.
> I have a question about selinux policy configuration for FC2.
> I need to forbid access to the postgresql data files from user root.
> I guess i have to create certain type for postgresql. Let's name this type
> pgsql.
> Thus i have something like that:
> [root selinux pgsql]# pwd
> /var/lib/pgsql
> [root selinux pgsql]# ls -aZ
> drwx------+ postgres postgres postgres:object_r:pgsql_home_dir_t .
> drwxr-xr-x  root     root     system_u:object_r:var_lib_t      ..
> drwx------  postgres postgres postgres:object_r:pgsql_home_dir_t backups
> -rw-------  postgres postgres postgres:object_r:pgsql_home_t   .bash_history
> -rw-r--r--  postgres postgres postgres:object_r:pgsql_home_t   .bash_profile
> drwx------  postgres postgres postgres:object_r:pgsql_home_dir_t data
> -rw-r--r--  postgres postgres postgres:object_r:pgsql_home_t   initdb.i18n
> drwxr-xr-x+ postgres postgres postgres:object_r:pgsql_home_t   .mc
> [root selinux pgsql]#
> So far user root within sysadm_r role has access to the postgresql data
> files.
> I guess i need to find and revoke this permission from sysadm_r role.
> After looking at the policy.conf file I can't understand this.
> So how can i prevent access to postgresql data files from user root?
> Thanks.

Russell Coker already responded to your posting on the
fedora-selinux-list.  I would only add a few comments:

1) If you truly want to start reducing the power of sysadm_t, then you
would start by disabling the unrestricted_admin and unlimitedServices
tunables in policy/tunable.te and make load.  Otherwise, sysadm_t is
completely unconfined in the Fedora policy.  Then you can remove direct
access by sysadm_t to your new types just by omitting the sysadmfile
attribute from the type declarations for your new types.  But as Russell
noted, sysadm_t can easily get around such restrictions, so much more
work would be necessary to truly prevent access.

2) If you just want to prevent root from having such access, you could
remove sysadm_r from the authorized roles for root, as Russell noted.  I
think that for SELinux play machines, people have authorized root for
only user_r and then authorized another user identity for staff_r and
sysadm_r.  But in Fedora, I think you would also have to remove
pam_selinux from the /etc/pam.d/su configuration to achieve this goal,
so that your non-root user can su to uid 0 without having his SELinux
user identity changed to root.  Otherwise, su will try to change the
SELinux user identity to root at the same time.

3) Do you really want to prevent someone with the root password from
having access to the database, or do you just want to prevent uid 0
processes from having access?  A uid 0 process does not necessarily have
the SELinux root user identity; the SELinux user identity is only
assigned by particular programs such as login and sshd and is unaffected
by setuid programs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
