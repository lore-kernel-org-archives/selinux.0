Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88LoqrT007712
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 17:50:52 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88Lopfe005904
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 21:50:51 GMT
Date: Wed, 8 Sep 2004 23:02:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: debian-devel@lists.debian.org, Scott James Remnant <scott@netsplit.com>,
   SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>
Subject: Re: dpkg and selinux
Message-ID: <20040908220208.GD7717@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net> <200409072220.53751.russell@coker.com.au> <20040907123930.GD17760@lkcl.net> <200409082332.36104.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409082332.36104.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 08, 2004 at 11:32:36PM +1000, Russell Coker wrote:

> > > >  well, under most circumstances, i believe that can be catered for
> > > >  (with /etc/init.d/xfs creating /tmp/.font-unix being a notable
> > > >   exception).
> > >
> > > test -s /sbin/restorecon && /sbin/restorecon /tmp/.font-unix
> >
> >  (in /etc/init.d/xfs i've used if [ -x /sbin/restorecon ]; then /sbin....
> >   but hey it's all the same)
> 
> Yes.  Now we just need to get that into the init script.  Please file an 
> appropriate bug report requesting that either method be used.

 done.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
