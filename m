Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BHnNrT025328
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 13:49:23 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BHnM6V006335
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 17:49:22 GMT
Date: Sat, 11 Sep 2004 19:00:28 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: initscripts sysv se2
Message-ID: <20040911180028.GE12835@lkcl.net>
References: <20040910181322.GS14060@lkcl.net> <200409120253.02597.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409120253.02597.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 12, 2004 at 02:53:02AM +1000, Russell Coker wrote:
> On Sat, 11 Sep 2004 04:13, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i raised the bug about /etc/mtab on debian, they said it's not
> > critical to debian because i'm using patched versions of initscripts.
> 
> What patches are you using on the init scripts?  My patch to sysvinit only 
> changes /sbin/init itself, the scripts remain the same.
> 
> Who said that it's not critical to Debian?  

 non-critical to non-selinux systems.

> Where did they say it?
 
 Miquel van Smoorenburg 

 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=270919

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
