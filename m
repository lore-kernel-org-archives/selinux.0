Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PGtsrT006919
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 12:55:56 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PGt8LV016319
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 16:55:08 GMT
Date: Wed, 25 Aug 2004 17:53:54 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: prelink on debian
Message-ID: <20040825165354.GB7260@lkcl.net>
References: <20040823232135.GA12720@lkcl.net> <200408252143.25077.russell@coker.com.au> <20040825131653.GA4241@lkcl.net> <200408252352.14465.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408252352.14465.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 25, 2004 at 11:52:14PM +1000, Russell Coker wrote:
> On Wed, 25 Aug 2004 23:16, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > On Wed, Aug 25, 2004 at 09:43:25PM +1000, Russell Coker wrote:
> > > On Tue, 24 Aug 2004 09:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
> wrote:
> > > > prelink is a script on debian: i had to add this because prelink checks
> > > > that there's > 50mb of disk space and then exec's prelink.bin.
> > >
> > > OK, this needs a ifdef(`distro_debian', around it.
> >
> >  oh yeh :)
> >
> > > Do you think we should have the shell script labelled as sbin_t on
> > > Debian?
> >
> >  i don't know enough about FHS to be able to advise you: perhaps someone
> >  else here could answer that better.
> 
> It's not a FHS issue.
 
 oh, right.

> Do we need the shell script to transition to prelink_t or can it run in the 
> calling domain (maybe system_crond_t)?  

 well, that's where it's run from (as a cron job),
 also it's run as a sysadm_r on the first initial setup of prelink.

 i'm not even going to pretend to say i know enough to help
 make a decision on this one!

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
