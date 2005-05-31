Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VKS7gA009001
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 16:28:07 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VKLmpZ003679
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 20:21:49 GMT
Date: Tue, 31 May 2005 21:30:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: smaller memory footprint for 'strict' policy - helping gentoo as well
Message-ID: <20050531203033.GB11815@lkcl.net>
References: <20050531012824.GI28006@lkcl.net> <200505311353.j4VDrD4l027704@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505311353.j4VDrD4l027704@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 31, 2005 at 09:53:12AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 31 May 2005 02:28:24 BST, Luke Kenneth Casson Leighton said:
> 
> > ... would the concept of a macros/unused directory help out, here?
> > along with a list of the macros you removed (and the files
> > they're in), valdis - and why.  and chris, also?
> 
> Almost all the gains I got were basically from moving stuff from
> domains/programs/foo.te to domains/programs/unused/foo.te
> 
> > ... surely... there's some analysis done by the m4 macro
> > compiler that automatically removes "unwanted" / "unused"
> > macros?
> 
> The remaining gotcha is that some of the stuff in macros/program/foo_macros.te
> could use some better ifdef wrapping, which I haven't looked into yet.
 
 someone (stephen?) mentioned that policy.conf doesn't end up with stuff
 that isn't actually required.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
