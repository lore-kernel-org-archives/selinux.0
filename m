Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92GhhLC016381
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 12:43:43 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k92GgW7Y003199
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 16:42:33 GMT
Date: Mon, 2 Oct 2006 12:43:36 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, eparis@redhat.com
Subject: Re: [PATCH 7/9] secid reconciliation-v04: Enforcement for SELinux
In-Reply-To: <1159806908.6855.58.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0610021242330.11172@d.namei>
References: <452032A6.1080306@trustedcs.com>  <45213A55.8070205@hp.com>
 <1159806908.6855.58.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Oct 2006, Stephen Smalley wrote:

> It appears that selinux_xfrm_decode_session() can only legitimately
> return an error if the last argument (ckall) is non-zero.
> security_skb_classify_flow() was doing the same thing prior to this
> patch series.  It would be clearer if there were two separate interfaces
> that internally use the same helper, with one of the functions returning
> void.

Ok, this can be a followup patch request (and not block merging).

- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
