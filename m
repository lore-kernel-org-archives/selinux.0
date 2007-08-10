Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AG5hTN017554
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:05:43 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AG5g1t020522
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 16:05:42 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/16] CacheFiles: Add missing copy_page export for ia64 [try
	#3]
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2007 17:05:22 +0100
Message-ID: <20070810160522.24698.99058.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
References: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This one-line patch fixes the missing export of copy_page introduced
by the cachefile patches.  This patch is not yet upstream, but is required
for cachefile on ia64.  It will be pushed upstream when cachefile goes
upstream.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/ia64/kernel/ia64_ksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/ia64_ksyms.c b/arch/ia64/kernel/ia64_ksyms.c
index bd17190..20c3546 100644
--- a/arch/ia64/kernel/ia64_ksyms.c
+++ b/arch/ia64/kernel/ia64_ksyms.c
@@ -43,6 +43,7 @@ EXPORT_SYMBOL(__do_clear_user);
 EXPORT_SYMBOL(__strlen_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
+EXPORT_SYMBOL(copy_page);
 
 /* from arch/ia64/lib */
 extern void __divsi3(void);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
