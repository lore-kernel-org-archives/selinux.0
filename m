From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/24] CacheFiles: Add missing copy_page export for ia64
To: viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        sds@tycho.nsa.gov, casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 26 Sep 2007 15:21:56 +0100
Message-ID: <20070926142156.2656.23766.stgit@warthog.procyon.org.uk>
In-Reply-To: <20070926142059.2656.27100.stgit@warthog.procyon.org.uk>
References: <20070926142059.2656.27100.stgit@warthog.procyon.org.uk>
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
