Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m93MJX1v004020
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 18:19:33 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m93MJWrA005789
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 22:19:33 GMT
Date: Sat, 4 Oct 2008 08:19:25 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Fix an uninitialized variable BUG/panic in
 selinux_secattr_to_sid()
In-Reply-To: <20081003145114.22380.57711.stgit@flek>
Message-ID: <alpine.LRH.1.10.0810040819050.25866@tundra.namei.org>
References: <20081003145114.22380.57711.stgit@flek>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Oct 2008, Paul Moore wrote:

> At some point during the 2.6.27 development cycle two new fields were added
> to the SELinux context structure, a string pointer and a length field.  The
> code in selinux_secattr_to_sid() was not modified and as a result these two
> fields were left uninitialized which could result in erratic behavior,
> including kernel panics, when NetLabel is used.  This patch fixes the
> problem by fully initializing the context in selinux_secattr_to_sid() before
> use and reducing the level of direct context manipulation done to help
> prevent future problems.
> 
> Please apply this to the 2.6.27-rcX release stream.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>


Applied to:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
