Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1SAPkln007364
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 05:25:46 -0500
Received: from a.mx.secunet.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1SAPiEQ020907
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 10:25:45 GMT
Date: Mon, 28 Feb 2011 11:25:42 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Joy Latten <latten@austin.ibm.com>
Cc: Paul Moore <paul.moore@hp.com>, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 05/10] selinux: selinux_xfrm_decode_session check for
 socket sid
Message-ID: <20110228102542.GD26510@secunet.com>
References: <20110214131651.GA15640@secunet.com>
 <1297887085.25079.24.camel@sifl>
 <20110222121143.GC20852@secunet.com>
 <201102231616.39183.paul.moore@hp.com>
 <1298661665.2715.136.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298661665.2715.136.camel@faith.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 25, 2011 at 01:21:05PM -0600, Joy Latten wrote:
> > > 
> > > I think that's not possible too. The security_xfrm_decode_session()
> > > hook is used from within xfrm_decode_session(). This function
> > > is used in codepaths that are used for both, inbound and outbound
> > > processing (xfrm_lookup, xfrm_policy_check etc.).
> > 
> > This makes me wonder if the LSM hook is even in the right place.
> 
> I am unable to find the original email to get a full understanding of
> the context of this particular patch so am responding via Paul's email.
> If my comments seem incorrect due to lack of context... please let me
> know.
> 
> I believe xfrm_decode_session is for inbound processing.
> I could not readily find anything suggesting that xfrm_lookup()
> results in __xfrm_decode_session() getting called. If I have missed
> it, please let me know. I was looking at kernel code for 2.6.35.7.

Well, xfrm_decode_session() called in the forwarding path from
__xfrm_route_forward() to construct the flow that is passed to
xfrm_lookup().

Also it is called from the netfilter functions ip_route_me_harder()
on output, and ip_xfrm_me_harder() from the local out and the
postrouting hook.

Further, security_xfrm_decode_session() is called via selinux_skb_xfrm_sid()
from selinux_skb_peerlbl_sid() which is called from input, output and
forwaring codepaths.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
