Date: Mon, 7 Jan 2008 09:18:21 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, vyekkirala@TrustedCS.com
Subject: Re: Fwd: Re: [PATCH 1/2] LSM: Add inet_sys_snd_skb() LSM hook
In-Reply-To: <200801041252.05403.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0801070918020.21625@us.intercode.com.au>
References: <200801040944.01260.paul.moore@hp.com> <200801041252.05403.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Jan 2008, Paul Moore wrote:

> I believe that if we simplify the problem to just IPsec causing multiple 
> hits on the postroute hook we have a simple solution.  The fix is to 
> only apply the new egress access checks when skb->dst->xfrm == NULL.  

Sounds good.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
