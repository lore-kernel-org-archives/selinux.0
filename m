Date: Thu, 10 Jan 2008 01:04:43 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, cpebenito@tresys.com,
        vyekkirala@TrustedCS.com
Subject: Re: Q: SECMARK controls on forwarded packets
In-Reply-To: <200801082330.58907.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0801100100590.9291@us.intercode.com.au>
References: <200801082330.58907.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Jan 2008, Paul Moore wrote:

> (quick refresher, the packet's peer label is taken/derived from the original 
> sending socket and "attached" to the packet via NetLabel or labeled IPsec).  
> Since the packet's peer label conveys the same label as the sending socket, 
> using the packet's peer label in place of the sending socket seems to be a 
> natural fit.
> 
> Agree?  Disagree?  Other ideas?

Agree.

I think the forward_in/out thing works.

It'd be interesting to see what some fully worked network policy would 
look like for a couple of cases (e.g. secmark only, or secmark + ipsec).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
