Date: Tue, 01 Feb 2005 14:34:01 +0100
From: mailinglist.selinux@ifsaudiovisueel.nl
Subject: slapd_db_t database inaccessable to domain like shadow_t
To: SELinux@tycho.nsa.gov
Message-id: <E1CvyAL-0006Gq-SZ@server.intranet.ifsaudiovisueel.nl>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

policy writing question (newbie).

I tried to make the databases (and /etc/ldap.secret) of slapd just as inaccessable as the shadow-file (except for backup related processes etc).
Ofcourse it would be silly to make the databases more accessable than the shadow file, since one could introduce a user name.
root to the database with a different password if access to it.
Now my problem is that it doesn't seem to allow me to do this, or actually, my brain doesn't allow me yet.

Any ideas on how to do this?.
I tried adding '-slapd_db_t' at the points where is says -shadow_t, but that won't do.
I get m4 compilation errors telling me that different rules are violating this rule.

<snippet.
assertion on line 72498 violated by allow sysadm_t slapd_db_t:file { write create setattr append unlink link rename }.
assertion on line 72498 violated by allow portage_t slapd_db_t:file { write create setattr append unlink link rename }.
assertion on line 72498 violated by allow setfiles_t slapd_db_t:file { relabelfrom relabelto }.
assertion on line 72497 violated by allow sysadm_t slapd_db_t:file { ioctl read write create setattr lock append unlink link rename }.
assertion on line 72497 violated by allow portage_t slapd_db_t:file { ioctl read write create setattr lock append unlink link rename }.
assertion on line 72497 violated by allow portage_sandbox_t slapd_db_t:file { ioctl read lock }.
assertion on line 72497 violated by allow setfiles_t slapd_db_t:file { relabelfrom relabelto }.
</snippet.

I am not able to locate these rules. It must be a macro of a macro of a macro thing, but I don't have the knowledge to trace it back.
Probably you can give me a clue.

Thank.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
