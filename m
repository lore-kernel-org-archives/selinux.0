Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RIJ5rT004529
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 14:19:05 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6RIIZmJ002670
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 18:18:35 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 27 Jul 2004 18:19:03 -0000
Date: Tue, 27 Jul 2004 19:30:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Wolfgang Pfeiffer <roto@gmx.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Selinux possible on Debian-Linux/ppc?
Message-ID: <20040727183008.GX3392@lkcl.net>
References: <1090769556.7265.32.camel@debby> <200407261340.04981.russell@coker.com.au> <1090934318.4988.4.camel@selinux> <1090943490.7271.1422.camel@debby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090943490.7271.1422.camel@debby>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 27, 2004 at 05:51:30PM +0200, Wolfgang Pfeiffer wrote:
> On Tue, 2004-07-27 at 15:18, Christopher J. PeBenito wrote:
> > On Sun, 2004-07-25 at 23:40, Russell Coker wrote:
> > > On Mon, 26 Jul 2004 01:32, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> > > > But I'm not quite sure whether SElinux will run on that machine, and on
> > > > Debian-ppc ...
> > > 
> > > It is expected to work, I think that the Gentoo people have been getting PPC 
> > > machines to run SE Linux.
> > 
> > Yes, it works fine on PPC.  Gentoo has some support for SELinux/PPC;
> > I've been running it on my Mac since 2.6.0-test3.  SPARC64 also works.
> 
> I'm hopeful it will work here. And after all: I do not, and cannot,
> expect 100% guaranteed success, especially as I run Debian unstable
> here. So if anything goes wrong it's not necessarily SElinux's fault. 
> 
> And I became more and more curios on SE-linux , so I think if things are
> new one has to bear some risk that things can break. 
> 
> The only risk I see is my ignorance (I'm relatively new to Debian -
> before I had a RedHat Linux system ... but let's see ... :)

 gosh.  brave, stupid or curious, it's all the same to me: admiration
 at your endeavours, or entertainment for all as your system
 crashes-and-burns...

> At any rate I'll keep another (non-SE, AFAIKS) 2.4 kernel handy, just in
> case ...
 
 remember that if you _do_ run a non-selinux kernel, and you ever get
 to write files with that kernel onto your drives, those files will
 have their SE/Linux permissions set to (none) - which means "No Access"
 if you reboot into an selinux kernel :)

 if you're using 2.6.6, grab the config file off of:

	 http://www.hands.com/~lkcl/selinux/

 and, duh, obviously, change the processor type to PPC
 and anything else you know of that you know you should do.
 if you're not sure, take a diff -u of the standard PPC and
 standard 686 2.6.6 configs and then patch my one with that
 diff.

 if all else fails, ask.

 remember to follow the instructions at
 http://selinux.lemuria.org/install-2.6.html

 for the right kernel options (inc ext2/3 security)

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
