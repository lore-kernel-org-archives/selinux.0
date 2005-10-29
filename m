Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9TGsgMA001420
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 12:54:44 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9TGoDBP027169
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 16:50:14 GMT
Date: Sat, 29 Oct 2005 17:50:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: logging question
Message-ID: <20051029165004.GD13490@lkcl.net>
References: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu> <1129567150.26309.154.camel@moss-spartans.epoch.ncsc.mil> <200510180752.34963.russell@coker.com.au> <87ek64z52f.fsf@glaurung.internal.golden-gryphon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ek64z52f.fsf@glaurung.internal.golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya manoj,

was wondering where you got to.  someone on the debian kernel team
contacted me last month, wondering who the debian / selinux point of
contact was.

do you know the people to speak to such that a debian-selinux mailing
list can be set up because that's the "natural" place people would
expect to look for ... and it don't exist.

l.

On Sat, Oct 29, 2005 at 11:00:24AM -0500, Manoj Srivastava wrote:
> On Tue, 18 Oct 2005 07:52:25 +1000, Russell Coker <russell@coker.com.au> said: 
> 
> > The Debian kernel binary packages are built with SE Linux enabled
> > but auditing disabled.  I have sent several messages to the relevant
> > people about this matter and had no positive response.  Several
> > 2.6.x kernels have been released in this state.
> 
>         The latest 2.6.14 kernels have CONFIG_AUDIT=y, as well as
>  CONFIG_AUDITSYSCALL=y
> 
>         Is a new release of libsepol imminent, or should I go fetch
>  the 1.9.X release from CVS and upload that to Debian?
> 
>         manoj
> ps: Sorry for being tardy on the Debian SELinux front, but I am just
> coming out of a health issue, and had been unable to spend time on SELINUX
> -- 
> Time is an illusion perpetrated by the manufacturers of space.
> Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
> 1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
