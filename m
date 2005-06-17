Subject: Re: [RFC]Kernel Built-in IDS extension
From: Stephen Smalley <sds@tycho.nsa.gov>
To: horietk@nttdata.co.jp
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6ACF5196CB5AA4FB50C32559083A36901633F01@MAILSV12.msg.nttdata.co.jp>
References: 
	 <E6ACF5196CB5AA4FB50C32559083A36901633F01@MAILSV12.msg.nttdata.co.jp>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 10:00:58 -0400
Message-Id: <1119016858.12524.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-17 at 18:16 +0900, horietk@nttdata.co.jp wrote:
> example) buffer overflow detection and system protection.
>   bool etc_locked false ;
>   bool bool_locked false ;
>   trap ftpd_t shell_exec_t:file { execute } { etc_locked bool_locked } ;
>   if (etc_locked) {
>      /* read only, no one can change /etc files  */
>      allow sysadm_t etc_t:file { r_file_perms }; 
>   } else {
>      /* sysadm can edit /etc files */
>      allow sysadm_t etc_t:file { rw_file_perms }; 
>   }
>   if (!bool_locked) {
>      /* sysadm can operate booleans */
>      allow sysadm_t security_t:security setbool;
>   }

This particular example is not particularly motivating, since:
a) you aren't doing anything to lock down ftpd_t itself upon this trap,
and
b) you are instead locking down sysadm_t, so this presents an obvious
denial-of-service attack against legitimate admins.

Note that self:process execmem makes a good candidate for a trap, as
that reflects an attempt to make anonymous memory executable, e.g. an
attempt to make the stack executable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
