Message-ID: <455364C9.6000701@hp.com>
Date: Thu, 09 Nov 2006 12:26:33 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: vyekkirala@TrustedCS.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: [PATCH 2/3] mlsxfrm: Various fixes
References: <000501c70342$83b9df70$cc0a010a@tcssec.com> <4552A9AC.3060708@hp.com> <Pine.LNX.4.64.0611082337520.5916@d.namei> <4552B5C1.8040007@hp.com> <Pine.LNX.4.64.0611090109120.10907@d.namei> <4552CD3B.40809@hp.com> <XMMS.LNX.4.64.0611090158550.11301@d.namei>
In-Reply-To: <XMMS.LNX.4.64.0611090158550.11301@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 9 Nov 2006, Paul Moore wrote:
> 
>>It sounds like you have an idea of how you would like to see this implemented,
>>can you give me a rough outline?  Is this the partitioned SECMARK field you
>>talked about earlier?
> 
> No, just the fact that you are in the same kernel address space and can 
> readily access the security context of the peer.

For a minute I got all excited thinking that you had found a solution to this :)

The problem I keep running into is that it is not obvious to me how we can
determine the security context of the sending socket on the receive side by
looking at the skb.  I'm really hoping that it is just because I haven't looked
at the code long enough, or thought about it hard enough.  It is just so
frustrating because you are right - all the information is there, I just don't
know how to get to it when we need it without using external labeling.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
