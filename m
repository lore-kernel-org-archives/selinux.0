Subject: [PATCH 2/3] mmap: round mmap hint address above mmap_min_addr
From: Eric Paris <eparis@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: jmorris@namei.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        alan@redhat.com, chrisw@redhat.com, hpa@zytor.com,
        akpm@linux-foundation.org
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:54:46 -0500
Message-Id: <1195246486.2924.87.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If mmap_min_addr is set and a process attempts to mmap (not fixed) with
a non-null hint address less than mmap_min_addr the mapping will fail
the security checks.  Since this is just a hint address this patch will
round such a hint address above mmap_min_addr.

gcj was found to try to be very frugal with vm usage and give hint
addresses in the 8k-32k range.  Without this patch all such programs
failed and with the patch they happily get a higher address.

This patch is wrappad in CONFIG_SECURITY since mmap_min_addr doesn't
exist without it and there would be no security check possible no matter
what.  So we should not both compiling in this rounding if it is just a
waste of time.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 mm/mmap.c  |   10 ++++++++++
 mm/nommu.c |   10 ++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 938313c..0c3ff74 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -912,6 +912,16 @@ unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
 	if (!len)
 		return -EINVAL;
 
+#ifdef CONFIG_SECURITY
+	/*
+	 * If a hint addr is less than mmap_min_addr change addr to be as
+	 * low as possible but still greater than mmap_min_addr
+	 */
+	if (!(flags & MAP_FIXED) && ((void *)addr != NULL) &&
+	    (addr < mmap_min_addr))
+		addr = PAGE_ALIGN(mmap_min_addr);
+#endif
+
 	error = arch_mmap_check(addr, len, flags);
 	if (error)
 		return error;
diff --git a/mm/nommu.c b/mm/nommu.c
index 35622c5..ea4d20a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -829,6 +829,16 @@ unsigned long do_mmap_pgoff(struct file *file,
 	void *result;
 	int ret;
 
+#ifdef CONFIG_SECURITY
+	/*
+	 * If a hint addr is less than mmap_min_addr change addr to be as
+	 * low as possible, but still greater than mmap_min_addr
+	 */
+	if (!(flags & MAP_FIXED) && ((void *)addr != NULL) &&
+	    (addr < mmap_min_addr))
+		addr = PAGE_ALIGN(mmap_min_addr);
+#endif
+
 	/* decide whether we should attempt the mapping, and if so what sort of
 	 * mapping */
 	ret = validate_mmap_request(file, addr, len, prot, flags, pgoff,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
