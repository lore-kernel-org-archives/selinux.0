Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p21If9xH030300
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2011 13:41:14 -0500
Received: from g1t0028.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p21IfClH000113
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2011 18:41:13 GMT
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 08/10] selinux: Fix handling of kernel generated packets on labeled IPsec
Date: Tue, 1 Mar 2011 13:41:08 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <20110214131651.GA15640@secunet.com> <201102231645.58047.paul.moore@hp.com> <20110228103341.GE26510@secunet.com>
In-Reply-To: <20110228103341.GE26510@secunet.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201103011341.09041.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, February 28, 2011 5:33:41 AM Steffen Klassert wrote:
> On Wed, Feb 23, 2011 at 04:45:57PM -0500, Paul Moore wrote:
> > > Hm, I think we need to get this to work. Echo reply packets are just
> > > one thing. Also other icmp messages can't be send. For example path mtu
> > > discovery can't work with labeled IPsec. And have you tried to use
> > > labeled IPsec on IPv6 networks? Kernel generated icmp messages are
> > > quite important here.
> > 
> > Yes, several years ago I worked on the IPsec stack for a commercial UNIX
> > OS and we had to basically allow all IPv6/ICMP in the SPD so that
> > router/neighbor discovery would work correctly.  I believe that the
> > specifications have now evolved to allow type/code which would make this
> > a bit easier now.
> > 
> > Why not just create a SPD rule that would send these ICMP packets over a
> > traditional, unlabeled SA?  Am I missing something that would require
> > them to be sent over a labeled SA?
> 
> Might be possible. But I thought about this from a multi level security
> point of view. Such packets should be send back over an SA with the same
> confidential level as the receiving SA. Different confidential levels might
> require different crypto algorithems etc.

I think you missed the point, send both the request and the response over an 
unlabeled SA.  This shouldn't cause a security issue around data import/export 
into and out of the system as there shouldn't be any user data in these ICMP 
messages, just system management data.

Also, by default, SELinux treats packets arriving over unlabeled SAs as 
unlabeled_t:SystemHigh so assuming you aren't normally running user processes 
at SystemHigh you should be protected in the case that something goes wrong 
with your IPsec configuration.

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
