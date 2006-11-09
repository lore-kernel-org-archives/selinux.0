Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA96TwhW008080
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 01:29:58 -0500
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA96TFB5023791
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 06:29:15 GMT
Date: Thu, 9 Nov 2006 01:30:05 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 0/3] labeled-ipsec: Repost patchset with updates [Originally:
 mlsxfrm: Various Fixes]
In-Reply-To: <45526241.10805@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0611090124570.11016@d.namei>
References: <45526241.10805@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Nov 2006, Venkat Yekkirala wrote:

> This patchset is against davem's net-2.6.git. Please apply to 2.6.19.
> 
> The following are the changes since the previous post of this patchset:
> 
> 1. Separate BUG_ON usage per Eric's suggestion.
> 
> 2. Replace security_sid_compare with a simple sid compare check per
>    a suggestion from Paul/Stephen.

Applied to:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-net-2.6.20.git

I think this should be aimed at 2.6.20, because we are at the last or 
second-last -rc currently, and I don't think these fixes are urgent enough 
to justify the risk at this stage.  Also, I think this code needs more 
testing, and more general progress towards code completion.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
