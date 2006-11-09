Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA9726jV008875
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 02:02:06 -0500
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA971NB5027562
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 07:01:23 GMT
Date: Thu, 9 Nov 2006 02:02:14 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: vyekkirala@TrustedCS.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: [PATCH 2/3] mlsxfrm: Various fixes
In-Reply-To: <4552CD3B.40809@hp.com>
Message-ID: <XMMS.LNX.4.64.0611090158550.11301@d.namei>
References: <000501c70342$83b9df70$cc0a010a@tcssec.com> <4552A9AC.3060708@hp.com>
 <Pine.LNX.4.64.0611082337520.5916@d.namei> <4552B5C1.8040007@hp.com>
 <Pine.LNX.4.64.0611090109120.10907@d.namei> <4552CD3B.40809@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Nov 2006, Paul Moore wrote:

> It sounds like you have an idea of how you would like to see this implemented,
> can you give me a rough outline?  Is this the partitioned SECMARK field you
> talked about earlier?

No, just the fact that you are in the same kernel address space and can 
readily access the security context of the peer.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
