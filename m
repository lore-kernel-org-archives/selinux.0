Subject: Re: slapd_db_t database inaccessable to domain like shadow_t
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: mailinglist.selinux@ifsaudiovisueel.nl
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <E1CvyAL-0006Gq-SZ@server.intranet.ifsaudiovisueel.nl>
References: <E1CvyAL-0006Gq-SZ@server.intranet.ifsaudiovisueel.nl>
Content-Type: text/plain
Message-Id: <1107263962.26936.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 08:19:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 08:34, mailinglist.selinux@ifsaudiovisueel.nl
wrote:
> policy writing question (newbie).
> 
> I tried to make the databases (and /etc/ldap.secret) of slapd just as inaccessable as the shadow-file (except for backup related processes etc).
> Ofcourse it would be silly to make the databases more accessable than the shadow file, since one could introduce a user name.
> root to the database with a different password if access to it.
> Now my problem is that it doesn't seem to allow me to do this, or actually, my brain doesn't allow me yet.
> 
> Any ideas on how to do this?.
> I tried adding '-slapd_db_t' at the points where is says -shadow_t, but that won't do.
> I get m4 compilation errors telling me that different rules are violating this rule.
> 
> <snippet.
> assertion on line 72498 violated by allow sysadm_t slapd_db_t:file { write create setattr append unlink link rename }.
> assertion on line 72498 violated by allow portage_t slapd_db_t:file { write create setattr append unlink link rename }.
> assertion on line 72498 violated by allow setfiles_t slapd_db_t:file { relabelfrom relabelto }.
> assertion on line 72497 violated by allow sysadm_t slapd_db_t:file { ioctl read write create setattr lock append unlink link rename }.
> assertion on line 72497 violated by allow portage_t slapd_db_t:file { ioctl read write create setattr lock append unlink link rename }.
> assertion on line 72497 violated by allow portage_sandbox_t slapd_db_t:file { ioctl read lock }.
> assertion on line 72497 violated by allow setfiles_t slapd_db_t:file { relabelfrom relabelto }.
> </snippet.
> 
> I am not able to locate these rules. It must be a macro of a macro of a macro thing, but I don't have the knowledge to trace it back.
> Probably you can give me a clue.

Use apol (yum install setools setools-gui if you don't have them
already) to search for matching rules, then it will give you the
traceback at least to policy.conf.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
