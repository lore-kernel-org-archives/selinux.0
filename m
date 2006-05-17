Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4HEuAdW014742
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 10:56:10 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4HEu7ju015846
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 14:56:08 GMT
Date: Wed, 17 May 2006 10:56:04 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        netfilter-devel@lists.netfilter.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        Patrick McHardy <kaber@trash.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] SECMARK 1.1
In-Reply-To: <20060517133653.GA7327@thorium.jmh.mhn.de>
Message-ID: <Pine.LNX.4.64.0605171053120.25450@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
 <Pine.LNX.4.64.0605140133560.5506@d.namei> <20060517133653.GA7327@thorium.jmh.mhn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 May 2006, Thomas Bleher wrote:

> This all looks very nice - Thank You!
> Just one question: does the code canonicalize the security label? It
> would be nice if the same rules could be used on MLS and non-MLS
> systems.

No, it shouldn't be necessary, as there's no legacy installed base of 
rulesets (as there was with disk files), and MLS is now generally enabled 
by default.  Also, these rules are never exposed to general users, and 
even sysadmins should generate the rules via some kind of tool.

It would also add some complexity.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
