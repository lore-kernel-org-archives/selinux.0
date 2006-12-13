Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBD39x4L018305
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 22:09:59 -0500
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBD3AVI7028915
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 03:10:31 GMT
Date: Tue, 12 Dec 2006 22:10:26 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH 1/1] selinux: Delete mls_copy_context - V.02
In-Reply-To: <457EFCD1.2070405@trustedcs.com>
Message-ID: <XMMS.LNX.4.64.0612122210030.26899@d.namei>
References: <457EFCD1.2070405@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Dec 2006, Venkat Yekkirala wrote:

> This deletes mls_copy_context() in favor of mls_context_cpy() and
> replaces mls_scopy_context() with mls_context_cpy_low().
> 
> Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

Applied to

 git://git.infradead.org/~jmorris/selinux-2.6#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
