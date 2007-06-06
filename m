Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56I1rIW023426
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 14:01:53 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l56I1pXZ029557
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 18:01:51 GMT
Date: Wed, 6 Jun 2007 14:01:47 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        drepper@redhat.com, roland@redhat.com, arjan@infradead.org,
        mingo@elte.hu, viro@zeniv.linux.org.uk, chrisw@redhat.com,
        sgrubb@redhat.com
Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
In-Reply-To: <1181151040.3699.181.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0706061400020.31665@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
 <20070603205653.GE25869@devserv.devel.redhat.com>
 <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil>
 <1181075666.3978.31.camel@localhost.localdomain>  <Line.LNX.4.64.0706051658170.23379@d.namei>
  <20070605211616.GE23291@devserv.devel.redhat.com>
 <1181111433.3978.48.camel@localhost.localdomain>
 <1181151040.3699.181.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Jun 2007, Stephen Smalley wrote:

> With the fix already noted by James,
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Final patch applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


Also queued there is the following patch which enables the check in 
SELinux:


Subject: [PATCH] SELinux: enable minimum address checking for mmap

Enable enable minimum address checking for mmap if not already enabled, and
disable it on exit if we enabled it. Processes will then require the
new mmap_zero permission to override the check.  Set the default value to
64KB as suggested.  If already set, the existing value will be used.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Eric Paris <eparis@redhat.com>
Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2b44832..9a8db0b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -112,6 +112,9 @@ int selinux_enabled = 1;
 /* Original (dummy) security module. */
 static struct security_operations *original_ops = NULL;
 
+/* Did we enable minimum mmap address checking? */
+static int enabled_mmap_min_addr;
+
 /* Minimal support for a secondary security module,
    just to allow the use of the dummy or capability modules.
    The owlsm module can alternatively be used as a secondary
@@ -4912,6 +4915,16 @@ static __init int selinux_init(void)
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
 					    0, SLAB_PANIC, NULL, NULL);
+
+	/*
+	 * Tasks cannot mmap below this without the mmap_zero permission.
+	 * If not enabled already, do so by setting it to 64KB.
+	 */
+	if (mmap_min_addr == 0) {
+		enabled_mmap_min_addr = 1;
+		mmap_min_addr = 65536;
+	}
+
 	avc_init();
 
 	original_ops = secondary_ops = security_ops;
@@ -5061,6 +5074,10 @@ int selinux_disable(void)
 
 	selinux_disabled = 1;
 	selinux_enabled = 0;
+	
+	/* Disable minimum mmap address check only if we enabled it */
+	if (enabled_mmap_min_addr)
+		mmap_min_addr = 0;
 
 	/* Reset security_ops to the secondary module, dummy or capability. */
 	security_ops = secondary_ops;
-- 
1.5.0.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
