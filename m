Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ALmnrT001933
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:48:49 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5ALmiP2029597
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:48:44 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 21:48:47 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BYWmS-0001mr-C6
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 21:08:12 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BYXN9-0000yv-9D
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 21:46:07 +0000
Date: Thu, 10 Jun 2004 21:46:07 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040610214607.GQ2861@lkcl.net>
References: <20040609144404.GJ5477@philips.com> <20040609175001.GC5727@lkcl.net> <20040610120908.GN5477@philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040610120908.GN5477@philips.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 02:09:08PM +0200, Magnus Therning wrote:

> On Wed, Jun 09, 2004 at 05:50:01PM +0000, Luke Kenneth Casson Leighton wrote:
> >ha ha, another debian victiiim .
> >
> >0) make sure you're really a debian/unstable (apt-get dist-upgrade?)
> 
> Done!
 
 :)

> >1) install, at your own risk of course, the 2.6.6-selinux1 kernel
> >from http://hands.com/~lkcl/selinux.
> 
> I compiled one myself. Didn't manage to google my way to any pre-built
> (also checked apt-get.org, why isn't it mentioned there?).
 
 *shrug* - never'eard'of'it is probably why!

> I seem to have succeeded in compiling the kernel properly, but I'll give
> this one a shot anyway.

 it has CONFIG_NETWORK_SECURITY and all that stuff switch on in it.
 i've uploaded the config-2.6.6-selinux1 to open.hands.com/~lkcl/selinux
 in case you want to double-check (let me know if you find any
 discrepancies - either way!)


> >2) DO NOT add selinux.lemuria.org/newselinux to your /etc/apt/sources.list
> >
> >3) DO add selinux.lemuria.org/walters to your /etc/apt/sources.list
> 
> I followed the instructions in the HOWTO I found on the SF project. It
> mentions Russel Coker's repository.
 
 you got russell's message describing the status of the /newselinux
 and /walters packages, yes?

> >i ALSO recommend that you DO NOT install SE/Linux on an ext2 filesystem.
> 
> Ah, this I did do... Not too much of a problem to fix though.

 yes, you can always run tune2fs -j afterwards - that's what i did.


> >make sure you use ext3 for all partitions (well, i get away with /boot
> >as an ext2) how do i put this this is REALLY IMPORTANT there is a bug
> >somewhere in the extended attributes stuff and i got a repeatable and
> >quite seriously corrupted filesystem.
> >
> >if you really really can't get it to work let me know and i can upload
> >a set of pre-installed tar.gz'd partitions which only come to 124
> >mbytes total, there are only about 160 packages preinstalled.
> 
> Thanks!
> 
> I'll be in touch with updates :-)
 
 ack.

 btw _do_ ask because i had an incredibly frustrating couple of
 weeks before finally managing to get a working system.
 
 l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
