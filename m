Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JDW3Rb010071
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 09:32:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JDW1AR007223
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 13:32:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4JDW1Hn007220 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 13:32:01 GMT
Subject: Re: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron
	upstream patch)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org
In-Reply-To: <20040519091454.GL7348@lkcl.net>
References: <20040519091454.GL7348@lkcl.net>
Content-Type: text/plain
Message-Id: <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 19 May 2004 09:30:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-05-19 at 05:14, Luke Kenneth Casson Leighton wrote:
> 	See, this is still wrong. I asked Russell about it,
> 	but never got an answer (or I lost it, or never
> 	sent it, or something; it's not in my mail archive,
> 	anyway.). To re-iterate: "*system*" is not a username,
> 	it simply a string used to distinguish user crontabs
> 	(/var/spool/cron/*) from system crontabs (/etc/crontab,
> 	/etc/cron.d/*). The only importance is that not be a
> 	valid user name.

We had an email exchange with Steve Greenland in September 2003 about
this issue, but it wasn't really resolved.  To summarize:

- We want to be able to run /etc/crontab and /etc/cron.d/* entries in a
different security context than user-configurable crontab entries (even
/var/spool/cron/crontabs/root), as the integrity of the former can be
locked down more tightly.  Under SELinux, root (uid 0) can't necessarily
modify the former.  If we use the user id from the /etc/crontab
configuration, then we would lose that distinction.  Using the existing
'*system*' indicator and mapping that to the SELinux system_u user
conveys the notion of system cron jobs transparently to SELinux for
obtaining an appropriate security context.  Unless /etc/crontab and
/etc/cron.d/* is used in some cases for real users (as opposed to root
and pseudo users for system jobs), there seems to be no point in
changing the SELinux patch in this respect.  Doing so would merely
require us to add such pseudo users to the SELinux policy, which isn't
desirable in most cases.

- We want to be able to bind the ability to run in a particular cron job
security context to the file security context on the crontab file, so
that we can prevent execution of commands from crontab files created by
less trustworthy domains in a more privileged domain.  Note that the
crontab program is run in a different domain depending on the caller's
domain, and that the resulting crontab file is created with an
appropriate type, so user_t can't create a crontab that will execute in
sysadm_crond_t.  The crond entrypoint permission check provides this
safeguard; it is emulating the kernel check that would be performed if
crontab files were directly executed.  If we were to change the SELinux
patch to use the user identity from /etc/crontab, then multiple distinct
user contexts would need entrypoint permission to a single crontab file
context.
 
> i take it that this is a more "informative" string
> than "*system*" but it is equally as non-username-ish
> as "*system*" is.

It conveys to the SELinux code that we want a security context
appropriate for system cron jobs transparently, as system_u is already
the SELinux user identity for system processes.  And it doesn't hurt
anything, as neither "*system*" nor "system_u" should exist in
/etc/passwd.

> the "fake" name created therefore contains information useful
> to SELinux users whilst at the same time maintaining compatibility
> with the purpose behind "*system*".
> 
> the original patch accidentally changed the behaviour of cron because
> of the detection strcmp("*system",..) further on.

The SELinux patch for cron changes all instances of "*system*" to
SYSUSERNAME, at least in Fedora.  I don't know about the Debian port of
the patch.  Please sync with the Fedora patch before merging, see
http://www.nsa.gov/selinux/patches/vixie-cron-selinux.patch.gz.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
