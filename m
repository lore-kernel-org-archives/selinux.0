Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ILbXRb005672
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 17:37:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4ILbVAR029867
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:37:31 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
        by jazzband.ncsc.mil  with SMTP id i4ILbUHn029864 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:37:30 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 18 May 2004 20:39:29 -0000
Received: from highfield ([192.168.0.223]:32790 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQBPr-00082P-8Z
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:42:23 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQBKQ-00025J-81
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 20:36:46 +0000
Date: Tue, 18 May 2004 20:36:46 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: audit2allow successfully got rid of the avc errors
Message-ID: <20040518203646.GD7348@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hooray!  okay, i'm a step closer to being able to switch on selinux=1.

recompiling and installing the selinux patched 2.6.6 kernel
on both the build and target system did the trick.

hm.

that's taken up like about... a week, maybe more, just finding that
out.

... is there any way of adding in version detection, to throw up a
really blatant and repetitive in-yer-face warning, say, on every
single avc message, that says something along the lines of 
"your policy version is 17, this kernel supports version 15;
your userspace tools were built with kernel version 2.6.4, this
is kernel version 2.6.6; you can expect some things to fail.
go away and rebuild".

or at the very least, the versioning rules need to be enforced
in the packaging (yes i realise how much of a pain that'd be).

meta-packages could do the trick.

meta package named selinux-2.6.6 with dependencies on
kernel-image-2.6.6-1-386 | kernel-image-2.6.6-1-686 |
kernel-image-2.6.6-1-k7 etc. and on
policycoreutils-2.6.6 etc.

because that's what's effectively needed, isn't it?

and then the build dependencies specifically need to
be on kernel-image-2.6.6-1-XXX as well.

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
