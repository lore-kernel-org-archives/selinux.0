Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59A6erT018439
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 06:06:41 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i59A6aIl004795
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 06:06:37 -0400 (EDT)
Date: Wed, 9 Jun 2004 10:03:45 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>, samba-technical@samba.org,
   tng-technical@lists.samba-tng.org
Subject: se-samba - a possible way to get round no seteuid
Message-ID: <20040609100345.GA5727@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i'm just investigating exim4 to put in some hacks to make it
possible to transition between different executables.

exim4 does a lot of execve'ing about, but it's always to the
same executable name (i.e. /usr/sbin/exim4).

russell's idea is to make exim4 execve to different executable
names, and then a different context can be associated with each
purpose.

then, a set of capabilities can be associated with each executable,
which will of course do a straight execve to /usr/sbin/exim4 -
taking the new context with it.

it occurred to me that a similar approach could be taken with samba.

instead of doing a seteuid back to root, you do an execve to
an executable named samba-root.

or, in the main loop, you do an execve() to an executable named
smbd-child, and then do a setuid, and when you're done, you do
an execve back to smbd.

it's a hell of a lot simpler approach than messing about with
proxying and a darn site simpler than doing a rewrite of samba
to do user-space checking.

and you could potentially just leave this approach compiled in
by default, and, like with exim4, just symbolic link 
/usr/sbin/smbd-child to /usr/sbin/smbd for non-selinux systems.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
