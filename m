From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/2] SELinux: silence build warning when !CONFIG_BUG
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 20 Apr 2011 10:42:43 -0400
Message-ID: <20110420144243.17305.13584.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If one builds a kernel without CONFIG_BUG there are a number of 'may be
used uninitialized' warnings.  Silence these by returning after the BUG().

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c   |    2 ++
 security/selinux/netnode.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 722cc0e..5b762a7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -992,6 +992,7 @@ static void selinux_write_opts(struct seq_file *m,
 			continue;
 		default:
 			BUG();
+			return;
 		};
 		/* we need a comma before each option */
 		seq_putc(m, ',');
@@ -1445,6 +1446,7 @@ static int task_has_capability(struct task_struct *tsk,
 		printk(KERN_ERR
 		       "SELinux:  out of range capability %d\n", cap);
 		BUG();
+		return -EINVAL;
 	}
 
 	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 65ebfe9..3618251 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -141,6 +141,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 		break;
 	default:
 		BUG();
+		return NULL;
 	}
 
 	list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
