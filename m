Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6BBBarT027244
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 07:11:36 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6BBBFNZ005568
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 11:11:16 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 11 Jul 2004 11:11:35 -0000
Date: Sun, 11 Jul 2004 12:22:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: warning about debian hotplug package 20040329-9!
Message-ID: <20040711112237.GI3390@lkcl.net>
References: <20040709201413.GB3168@lkcl.net> <200407112050.08313.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407112050.08313.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jul 11, 2004 at 08:50:08PM +1000, Russell Coker wrote:
> On Sat, 10 Jul 2004 06:14, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > warning warning warning, do not install hotplug version 20040329-9
> > from debian unstable because /etc/hotplug/net.rc attempts to write
> > to /etc/hotplug/net.enable.
> >
> > hotplug writing to /etc/ even /etc/hotplug is banned by the [present]
> > selinux policy.
> >
> > i'm raising a bugreport about this one if there isn't one already.
> 
> That package is broken in other ways.  

 oh-ah?  oops.

 because it's being depended on in debian for quite a lot of things,
 like loading atmel wireless networking firmware.

> It doesn't work with PC-Card or Cardbus 
> Ethernet devices doing DHCP.  

 hm, it's all scripted (sh, bash) so that should be fixable, oh well.

> Just use -8.
 
 -8.  i'm really sorry but i've not heard of -8, and a search
 with google strips away the "-".

 do you have a url for it?

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
