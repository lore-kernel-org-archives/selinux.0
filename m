Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 "J . Bruce Fields" <bfields@redhat.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: [PATCH] selinux: Fix SBLABEL_MNT for NFS mounts
Date: Wed, 29 Mar 2017 17:27:23 +0200
Message-Id: <20170329152724.19030-1-tomeu.vizoso@collabora.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Labelling of files in a NFSv4.2 currently fails with ENOTSUPP because
the mount point doesn't have SBLABEL_MNT.

Add specific condition for NFS4 filesystems so it gets correctly
labeled.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: J. Bruce Fields <bfields@redhat.com>

---

Hi,

cannot remotely say that I currently understand how selinux is expected
to work within NFS mounts, but this change allowed me to fully boot AOSP
with its rootfs and ramdisk on a single NFS share.

Thanks,

Tomeu
---
 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0c2ac318aa7f..71cd1d8c67c2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -485,6 +485,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 		!strcmp(sb->s_type->name, "debugfs") ||
 		!strcmp(sb->s_type->name, "tracefs") ||
 		!strcmp(sb->s_type->name, "rootfs") ||
+		!strcmp(sb->s_type->name, "nfs4") ||
 		(selinux_policycap_cgroupseclabel &&
 		 (!strcmp(sb->s_type->name, "cgroup") ||
 		  !strcmp(sb->s_type->name, "cgroup2")));
-- 
2.9.3
