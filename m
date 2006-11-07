Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA7KcSrn019930
	for <selinux@tycho.nsa.gov>; Tue, 7 Nov 2006 15:38:28 -0500
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA7Kbgjq022640
	for <selinux@tycho.nsa.gov>; Tue, 7 Nov 2006 20:37:43 GMT
Date: Tue, 7 Nov 2006 15:38:33 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/3] mlsxfrm: Various fixes
In-Reply-To: <4550BF96.6080709@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0611071536300.20855@d.namei>
References: <4550BF96.6080709@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Nov 2006, Venkat Yekkirala wrote:

> Fix SO_PEERSEC for tcp sockets to return the security context of
> the peer (as represented by the SA from the peer) as opposed to the
> SA used by the local/source socket.

What about the case of a localhost TCP connection not using xfrm labeling?

Joe Nall raised this as an important requirement.



(Also, 'mlsxfrm' is MLS-specific).



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
