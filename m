Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JE5NRb010374
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 10:05:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JE5KAR009868
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:05:20 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
        by jazzband.ncsc.mil  with SMTP id i4JE5JHn009861 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:05:19 GMT
Date: Wed, 19 May 2004 14:02:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org
Subject: Re: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040519140239.GF4221@lkcl.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 09:30:53AM -0400, Stephen Smalley wrote:

> > i take it that this is a more "informative" string
> > than "*system*" but it is equally as non-username-ish
> > as "*system*" is.
> 
> It conveys to the SELinux code that we want a security context
> appropriate for system cron jobs transparently, as system_u is already
> the SELinux user identity for system processes.  And it doesn't hurt
> anything, as neither "*system*" nor "system_u" should exist in
> /etc/passwd.
 
  then the maintainer of debian crond needs to be authoritatively
  informed of this, as it will help reassure him that no damage is
  done by the change.

  in other words, what you are saying is that by putting system_u
  there instead, on the basis that no one is expected to add a
  user named "system_u" on a non-SELinux system, the change from
  "*system*" to "system_u" will have zero impact on a system
  that does not have an SELinux kernel.



> > the "fake" name created therefore contains information useful
> > to SELinux users whilst at the same time maintaining compatibility
> > with the purpose behind "*system*".
> > 
> > the original patch accidentally changed the behaviour of cron because
> > of the detection strcmp("*system",..) further on.
> 
> The SELinux patch for cron changes all instances of "*system*" to
> SYSUSERNAME, at least in Fedora.  I don't know about the Debian port of
> the patch.  Please sync with the Fedora patch before merging, see
> http://www.nsa.gov/selinux/patches/vixie-cron-selinux.patch.gz.
 

 okay.

 in the debian version of cron (3.0, at line 136 of database.c, the
 second argument to process_crontab is fname, which is a concatenation
 of "*system*" and some other information.

 this concatenation will of course make the strcmp against "*system*",
 at line 245, FAIL in the case where the 2nd arg to process_crontab
 is "*system*someotherinformation"

 this MAY just be a bug in the debian version of cron: i cannot tell
 because i do not know enough about it.


 however, i note with interest that the Fedora patch you mention above
 is against a vixie-cron where the 2nd argument to process_crontab
 is "*system" in BOTH calls to process_crontab, at lines 94 and 136
 of database.c.

 i can only point out the discrepancy between the Fedora vixie-cron
 and the Debian 3.0 cron (based on vixie-cron): i cannot make an informed
 statement about what is right.


 however, in the instance where the Fedora vixie cron happens to be
 correct, then the SELinux cron patch is fixing a bug.

 in the instance where the debian maintained version of cron 3.0
 is correct, then there is a bug in vixie cron which is being
 re-introduced by the Debian/SElinux cron patch.

 ... which is it?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
