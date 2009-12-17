Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBH7xgKo012767
	for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2009 02:59:42 -0500
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBH7wVvL004018
	for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2009 07:58:31 GMT
Date: Thu, 17 Dec 2009 18:59:29 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
        amworsley@gmail.com
Subject: Re: [RFC PATCH v2] selinux: Fix security_compute_av() to not return
 unknown class errors when in permissive mode
In-Reply-To: <20091216221002.10808.67004.stgit@flek.lan>
Message-ID: <alpine.LRH.2.00.0912171845380.2193@tundra.namei.org>
References: <20091216221002.10808.67004.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Dec 2009, Paul Moore wrote:

> It is possible security_compute_av() to return -EINVAL, even when in
> permissive mode, due to unknown object classes and SIDs.  This patch fixes
> this by doing away with the return value for security_compute_av() and
> treating unknown classes and SIDs as permission denials.
> 
> NOTE: I've only tested this on Fedora/Rawhide using the standard policy,
> so while I'm fairly confident there are no regressions in the common case
> the error case hasn't been fully tested yet; I'm posting this to solicit
> comments on the basic approach.

Looks ok to me.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
