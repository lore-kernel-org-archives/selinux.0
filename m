Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T9hnrT029245
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 05:43:49 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T9hlis026966
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 09:43:48 GMT
Date: Sun, 29 Aug 2004 10:54:58 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: fedora-selinux-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>,
   Tom London <selinux@comcast.net>, James Morris <jmorris@redhat.com>,
   laforge@gnumonks.org
Subject: Re: rpc.mountd failure...
Message-ID: <20040829095458.GF7610@lkcl.net>
References: <412A0E73.5020001@comcast.net> <200408291747.47554.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408291747.47554.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 29, 2004 at 05:47:47PM +1000, Russell Coker wrote:

> On Tue, 24 Aug 2004 01:34, Tom London <selinux@comcast.net> wrote:

> When the kernel code selects an arbitary port to bind to it should only select 
> from the set of ports that the application in question is permitted to bind 
> to.  

 oo. 

 that'd be _great_ because i could restrict skype to a range of ports
 in the firewall rules.

 and giftd (file sharing server).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
