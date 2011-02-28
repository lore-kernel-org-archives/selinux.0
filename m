Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1SAXim6007945
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 05:33:44 -0500
Received: from a.mx.secunet.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1SAXgEQ022100
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 10:33:43 GMT
Date: Mon, 28 Feb 2011 11:33:41 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Moore <paul.moore@hp.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 08/10] selinux: Fix handling of kernel generated
 packets on labeled IPsec
Message-ID: <20110228103341.GE26510@secunet.com>
References: <20110214131651.GA15640@secunet.com>
 <1297889847.25079.44.camel@sifl>
 <20110222133150.GE20852@secunet.com>
 <201102231645.58047.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102231645.58047.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 23, 2011 at 04:45:57PM -0500, Paul Moore wrote:
> > 
> > Hm, I think we need to get this to work. Echo reply packets are just
> > one thing. Also other icmp messages can't be send. For example path mtu
> > discovery can't work with labeled IPsec. And have you tried to use
> > labeled IPsec on IPv6 networks? Kernel generated icmp messages are
> > quite important here.
> 
> Yes, several years ago I worked on the IPsec stack for a commercial UNIX OS 
> and we had to basically allow all IPv6/ICMP in the SPD so that router/neighbor 
> discovery would work correctly.  I believe that the specifications have now 
> evolved to allow type/code which would make this a bit easier now.
> 
> Why not just create a SPD rule that would send these ICMP packets over a 
> traditional, unlabeled SA?  Am I missing something that would require them to 
> be sent over a labeled SA?
> 

Might be possible. But I thought about this from a multi level security
point of view. Such packets should be send back over an SA with the same
confidential level as the receiving SA. Different confidential levels might
require different crypto algorithems etc.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
