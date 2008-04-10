Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3AM6o6m001712
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 18:06:50 -0400
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3AM6nsY029611
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 22:06:50 GMT
Date: Fri, 11 Apr 2008 08:06:04 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v2 1/2] NetLabel: Allow passing the LSM domain as a
 shared pointer
In-Reply-To: <20080409205039.26774.50884.stgit@flek.lan>
Message-ID: <Xine.LNX.4.64.0804110805370.1313@us.intercode.com.au>
References: <20080409204936.26774.55254.stgit@flek.lan>
 <20080409205039.26774.50884.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Apr 2008, Paul Moore wrote:

> Smack doesn't have the need to create a private copy of the LSM "domain" when
> setting NetLabel security attributes like SELinux, however, the current
> NetLabel code requires a private copy of the LSM "domain".  This patches fixes
> that by letting the LSM determine how it wants to pass the domain value.
> 
>  * NETLBL_SECATTR_DOMAIN_CPY
>    The current behavior, NetLabel assumes that the domain value is a copy and
>    frees it when done
> 
>  * NETLBL_SECATTR_DOMAIN
>    New, Smack-friendly behavior, NetLabel assumes that the domain value is a
>    reference to a string managed by the LSM and does not free it when done
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
