Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6T91WgA028520
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 05:01:32 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6T8sjhF028424
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 08:54:45 GMT
Date: Fri, 29 Jul 2005 09:55:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>
Cc: "Sriram, Kannan" <ksriram@ti.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: SELinux for embedded devices...
Message-ID: <20050729085540.GF11752@lkcl.net>
References: <45F366B1BC4F7C4A895F0F34C41E61A5511366@dbde01.ent.ti.com> <1122610349.14844.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1122610349.14844.21.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 29, 2005 at 06:12:29AM +0200, Lorenzo Hern?ndez Garc?a-Hierro wrote:

> El vie, 29-07-2005 a las 07:50 +0530, Sriram, Kannan escribi?:
> > Hello all,
> > 
> >  I'm a newbie to SELinux, trying to figure out if SELinux is applicable/
> > suitable to embedded system security, especially mobile terminals/
> > smartphones. I have the following very basic questions... Pls help me
> > out, or redirect me to the appropriate forum.
> > 
> > 1. Is SELinux applicable and suitable for mobile equipment, where the
> > end user always has root privileges? Has SELinux been ported to any
> > embedded device yet (some ARM platform??).

> I was working on the design of extended attributes for JFFS2 (in which
> SELinux relies for labeling file-system objects), even got help from an
> Intel guy, but I got stuck at it, without any resources for testing, and
> the Intel guy who was willing to work together with me was requested for
> legal approbation before doing anything. Thus, time passed and I
> couldn't go a step further on doing anything serious about it.

 i have a complete test environment for doing this sort of
 thing, it's been sitting unused for several months because
 the project has been shut down.

 the device is a skyminder - a 90Mhz Cirrus Logic "Maverick"
 ARM 720T and it contains a GSM radio module and a GPS module.
 the company ran out of money to do things like, oh i dunno,
 correct the radio interference from the GSM radio module
 to the audio codec and the microphone for example, which
 was only discovered recently when i developed enough of the
 drivers and test procedures to notice it was a problem.

 ... but _other_ than that, the device is perfectly serviceable,
 runs a 2.6.11 kernel, uses JFFS2 on its 16Mbyte flash RAM,
 i have all the source code blah blah full development
 environment blah blah.

 yes i briefly considered adding selinux in to the mix, but
 not on the budget they were paying me.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
