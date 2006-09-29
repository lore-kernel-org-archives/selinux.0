Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TK4GwZ002012
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 16:04:16 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TK397b014974
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 20:03:09 GMT
Date: Fri, 29 Sep 2006 16:04:13 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@gentoo.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
In-Reply-To: <451D793A.4040007@hp.com>
Message-ID: <Pine.LNX.4.64.0609291557520.8199@d.namei>
References: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com>
 <451D4A51.4000603@hp.com> <Pine.LNX.4.64.0609291247170.6007@d.namei>
 <451D5B3F.70206@hp.com> <Pine.LNX.4.64.0609291430130.7553@d.namei>
 <451D6EB1.3040006@hp.com> <Pine.LNX.4.64.0609291517170.7975@d.namei>
 <451D793A.4040007@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Sep 2006, Paul Moore wrote:

> > ... or related packet doesn't match ...
> 
> Not sure what you mean by "related packet",

A related packet with conntrack would be an FTP data packet related to a 
specific FTP control session (where the conntrack is initialized, and has 
a secmark saved to it).

> but if the check in step #2
> fails then the packet would be dropped. 

Ok.

> The only case where I can see
> this happening is that if the MLS/MCS constraints did not allow the
> flow_in permission.  This allows administrators to set specific MLS
> labels for any iptables "object".

Yep, one thing to watch for here is packets arriving on a different 
interface for valid reasons (e.g. routing changes), but that's a policy 
issue.

> > ... or you get no CIPSO label (e.g. ICMP from intermediate router) ...
> 
> If there is no packet label that NetLabel recognizes and NetLabel is
> configured to allow unlabeled traffic then the NetLabel SID generated in
> step #1 above would be 0.

Well, conntrack will say that this packet is related to the connection 
and CONNSECMARK will restore the secmark label to it (i.e. it'll have the 
same secmark as the initial syn packet).  But, no CIPSO label.  I guess 
this needs to be considered in any case, secmark or not.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
