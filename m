Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAI4CPtK020799
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 23:12:25 -0500
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAI4Aljd017004
	for <selinux@tycho.nsa.gov>; Sat, 18 Nov 2006 04:10:47 GMT
Date: Fri, 17 Nov 2006 23:12:38 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 00/13] NetLabel cleanups for 2.6.20 [GIT]
In-Reply-To: <20061117223842.399078000@hp.com>
Message-ID: <XMMS.LNX.4.64.0611172308070.13574@d.namei>
References: <20061117223842.399078000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Nov 2006, paul.moore@hp.com wrote:

> This patchset consists of a lot of small-ish cleanups for NetLabel and in some
> cases labeled networking in general.  I've tested these patches for the past
> few days and I haven't seen any regressions so please consider them for the
> net-2.6.20 git tree.

Thanks, excellent!

There was one minor compilation issue caused by including linux/skbuff.h 
in an SELinux header, which I fixed (see below).

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-net-2.6.20


---

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 015f697..210eec7 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -8,7 +8,6 @@
 #ifndef _SELINUX_SECURITY_H_
 #define _SELINUX_SECURITY_H_
 
-#include <linux/skbuff.h>
 #include "flask.h"
 
 #define SECSID_NULL			0x00000000 /* unspecified SID */
@@ -35,6 +34,8 @@ #else
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
 #endif
 
+struct sk_buff;
+
 extern int selinux_enabled;
 extern int selinux_mls_enabled;
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
