Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QKq2rT028642
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 16:52:02 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QKq1hU011109
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 20:52:01 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 901C7BFCB
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 21:51:57 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CBgAm-000801-Ia
	for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 22:03:08 +0100
Date: Sun, 26 Sep 2004 22:03:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: postfix, spamd, cupsd all attempting name_bind to 25, 893 etc. as "reserved_port_t"
Message-ID: <20040926210308.GJ28076@lkcl.net>
References: <20040926171824.GD28076@lkcl.net> <20040926190736.GA2529@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040926190736.GA2529@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 26, 2004 at 09:07:37PM +0200, Thomas Bleher wrote:
> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-09-26 20:31]:
> > hi, i'm using the latest cvs from sf as policy.
> > 
> > kernel 2.6.8.1-selinux1 also from cvs (last week).
> > 
> > i get cups attempting to bind to port 631 as a "reserved_port_t",
> > also postfix to 25 likewise
> > and spamd_t to port 783 - again to reserved_port_t.
> > 
> > i've made absolutely no changes to the strict policy.
> 
> You need to use checkpolicy from cvs if you want to use the cvs policy.

 yes i ended up with those programs.  and libsepol which doesn't have a
 dpkg thing for it so i tarred it up to put onto the test machine.

 etc.

 but thanks for mentioning it.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
