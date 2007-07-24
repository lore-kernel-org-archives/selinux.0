Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6OKifPh010101
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 16:44:41 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6OKieXQ006068
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 20:44:40 GMT
Date: Tue, 24 Jul 2007 16:44:37 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        latten@austin.ibm.com
Subject: Re: [PATCH] selinux_xfrm_sec_ctx_alloc: null-terminate context string
In-Reply-To: <1185304859.16598.90.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0707241644170.7515@d.namei>
References: <46A61263.2050404@trustedcs.com> <1185304859.16598.90.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Jul 2007, Stephen Smalley wrote:

> On Tue, 2007-07-24 at 09:53 -0500, Venkat Yekkirala wrote:
> > xfrm_audit_log() expects the context string to be null-terminated
> > which currently doesn't happen with user-supplied contexts.
> > 
> > Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>


Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-linus


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
