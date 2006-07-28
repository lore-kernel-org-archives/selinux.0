Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6S4rXxV012636
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 00:53:33 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6S4rTU8016720
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 04:53:30 GMT
Date: Fri, 28 Jul 2006 00:53:30 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        tjaeger@cse.psu.edu
Subject: Re: [PATCH 10/10] MLSXFRM-v02: Auto-labeling of child sockets
In-Reply-To: <44C8EF98.3020507@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0607280050590.13981@d.namei>
References: <44BD196C.6000307@trustedcs.com> <44C8EF98.3020507@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jul 2006, Venkat Yekkirala wrote:

> The following patch will fix the build problem (encountered by Andrew Morton)
> when SECURITY_NETWORK_XFRM is not enabled.
> 
> As compared to git-net-selinux_xfrm_decode_session-build-fix.patch in -mm,
> this patch sets the return parameter sid to SECSID_NULL in
> selinux_xfrm_decode_session()
> and handles this value in the caller selinux_inet_conn_request()
> appropriately.
> 
> Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

Acked-by: James Morris <jmorris@namei.org>

> --- NOTE: Not sure what the ideal thing to do is here. The following is 
> incremental to the original patch. I can send a revision of the entire 
> patch with these changes if desired.

Send it to Andrew Morton saying it replaces

  git-net-selinux_xfrm_decode_session-build-fix.patch

and with any luck, he'll drop the old fix and add this one.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
