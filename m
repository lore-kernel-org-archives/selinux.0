Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3AM99ex001861
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 18:09:09 -0400
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3AM98sY029982
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 22:09:08 GMT
Date: Fri, 11 Apr 2008 08:08:50 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v2 2/2] LSM: Make the Labeled IPsec hooks more stack
 friendly
In-Reply-To: <20080409205044.26774.12364.stgit@flek.lan>
Message-ID: <Xine.LNX.4.64.0804110808080.1313@us.intercode.com.au>
References: <20080409204936.26774.55254.stgit@flek.lan>
 <20080409205044.26774.12364.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Apr 2008, Paul Moore wrote:

> The xfrm_get_policy() and xfrm_add_pol_expire() put some rather large structs
> on the stack to work around the LSM API.  This patch attempts to fix that
> problem by changing the LSM API to require only the relevant "security"
> pointers instead of the entire SPD entry; we do this for all of the
> security_xfrm_policy*() functions to keep things consistent.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
