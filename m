Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PDqJrT005585
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 09:52:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PDqHuQ008921
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 13:52:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: prelink on debian
Date: Wed, 25 Aug 2004 23:52:14 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823232135.GA12720@lkcl.net> <200408252143.25077.russell@coker.com.au> <20040825131653.GA4241@lkcl.net>
In-Reply-To: <20040825131653.GA4241@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408252352.14465.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Aug 2004 23:16, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Wed, Aug 25, 2004 at 09:43:25PM +1000, Russell Coker wrote:
> > On Tue, 24 Aug 2004 09:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> > > prelink is a script on debian: i had to add this because prelink checks
> > > that there's > 50mb of disk space and then exec's prelink.bin.
> >
> > OK, this needs a ifdef(`distro_debian', around it.
>
>  oh yeh :)
>
> > Do you think we should have the shell script labelled as sbin_t on
> > Debian?
>
>  i don't know enough about FHS to be able to advise you: perhaps someone
>  else here could answer that better.

It's not a FHS issue.

Do we need the shell script to transition to prelink_t or can it run in the 
calling domain (maybe system_crond_t)?  If it can run in the calling domain 
then it may be best not to have it labeled due to the transition on shell 
script issues.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
