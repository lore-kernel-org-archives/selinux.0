Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i78LwwrT021614
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 17:58:58 -0400 (EDT)
Received: from smtp812.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i78LwMDs001682
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 21:58:22 GMT
Date: Sat, 7 Aug 2004 13:23:10 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040807122310.GA3959@lkcl.net>
References: <20040801172751.GD20103@lkcl.net> <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil> <20040802211212.GB6260@lkcl.net> <200408062205.08533.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408062205.08533.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 06, 2004 at 10:05:08PM +1000, Russell Coker wrote:
> On Tue, 3 Aug 2004 07:12, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> >  p.s. first cut at mods attached for general review NO I HAVEN'T
> >  COMPILED IT.
> 
> One thing to note is that is_selinux_enabled() reads /proc/filesystems and 
> then reads /proc/self/attr/current.  This is more work than you want to do 
> for every device node.  So you want to cache the result of 
> is_selinux_enabled() to some degree.  You certainly don't want to call it 
> twice in the same code path.
 
 ee!  okay.

> udev is tricky in this regard because there is the possibility that udev may 
> be started before SE Linux is enabled.

 ... for my purposes i am happy to assume that this not be the case.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
