Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PD5grT005166
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 09:05:42 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PD4uLV000437
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 13:04:57 GMT
Date: Wed, 25 Aug 2004 14:16:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: prelink on debian
Message-ID: <20040825131653.GA4241@lkcl.net>
References: <20040823232135.GA12720@lkcl.net> <200408252143.25077.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408252143.25077.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, Aug 25, 2004 at 09:43:25PM +1000, Russell Coker wrote:
> On Tue, 24 Aug 2004 09:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > prelink is a script on debian: i had to add this because prelink checks
> > that there's > 50mb of disk space and then exec's prelink.bin.
> 
> OK, this needs a ifdef(`distro_debian', around it.
 
 oh yeh :)

> Do you think we should have the shell script labelled as sbin_t on Debian?

 i don't know enough about FHS to be able to advise you: perhaps someone
 else here could answer that better.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
