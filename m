Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i349K3Rb017655
	for <selinux@tycho.nsa.gov>; Sun, 4 Apr 2004 05:20:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i349I6UZ029140
	for <selinux@tycho.nsa.gov>; Sun, 4 Apr 2004 09:18:06 GMT
Received: from ore.jhcloos.com (ore.jhcloos.com [64.240.156.239])
	by jazzswing.ncsc.mil  with ESMTP id i349I5mT029135
	for <selinux@tycho.nsa.gov>; Sun, 4 Apr 2004 09:18:06 GMT
To: James Morris <jmorris@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
   <selinux@tycho.nsa.gov>, <lksctp-developers@lists.sourceforge.net>
Subject: Re: [SELINUX] Add IPv6 support
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Xine.LNX.4.44.0404040107120.7220-100000@thoron.boston.redhat.com> (James
 Morris's message of "Sun, 4 Apr 2004 01:33:09 -0500 (EST)")
References: <Xine.LNX.4.44.0404040107120.7220-100000@thoron.boston.redhat.com>
Date: Sun, 04 Apr 2004 05:19:42 -0400
Message-ID: <m31xn42j81.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> JM == James Morris <jmorris@redhat.com> writes:

JM> send & receive TCP/UDP and raw IP packets

>From a scan through the patch, it looks like it does in fact only
handle those tcp, udp and raw.  

Sctp also should be supported by these mechanisms, given that 2.6
has both in the main tree.

I'd expect many systems which will be installed in the next few
quarters and which could make good use of the selinux controls 
will require sctp support.

-JimC


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
