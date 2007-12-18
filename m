Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBI8Q9w4021835
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 03:26:09 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBI8Q4xB019526
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 08:26:04 GMT
Date: Tue, 18 Dec 2007 19:25:54 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Subject: Re: [RFC PATCH v8 05/18] LSM: Add secctx_to_secid() LSM hook
In-Reply-To: <20071214215020.10069.51960.stgit@flek.lan>
Message-ID: <Xine.LNX.4.64.0712181925210.19727@us.intercode.com.au>
References: <20071214213548.10069.59135.stgit@flek.lan>
 <20071214215020.10069.51960.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Dec 2007, Paul Moore wrote:

> Add a secctx_to_secid() LSM hook to go along with the existing
> secid_to_secctx() LSM hook.  This patch also includes the SELinux
> implementation for this hook.

Please sign off your patches (especially this one asap, so I can push it 
upstream).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
