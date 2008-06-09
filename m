Subject: [PATCH] SELinux: more user friendly unknown handling printk
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Mon, 09 Jun 2008 16:51:37 -0400
Message-Id: <1213044697.4597.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've gotten complaints and reports about people not understanding the
meaning of the current unknown class/perm handling the kernel emits on
every policy load.  Hopefully this will make make it clear to everyone
the meaning of the message and won't waste a printk the user won't care
about anyway on systems where the kernel and the policy agree on
everything.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/selinuxfs.c   |    5 -----
 security/selinux/ss/services.c |    7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ac1ccc1..f47c9c9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -352,11 +352,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		length = count;
 
 out1:
-
-	printk(KERN_INFO "SELinux: policy loaded with handle_unknown=%s\n",
-	       (security_get_reject_unknown() ? "reject" :
-		(security_get_allow_unknown() ? "allow" : "deny")));
-
 	audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"policy loaded auid=%u ses=%u",
 		audit_get_loginuid(current),
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dcc2e1c..c837982 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1110,6 +1110,7 @@ static int validate_classes(struct policydb *p)
 	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	const char *def_class, *def_perm, *pol_class;
 	struct symtab *perms;
+	bool print_unknown_handle = 0;
 
 	if (p->allow_unknown) {
 		u32 num_classes = kdefs->cts_len;
@@ -1130,6 +1131,7 @@ static int validate_classes(struct policydb *p)
 				return -EINVAL;
 			if (p->allow_unknown)
 				p->undefined_perms[i-1] = ~0U;
+			print_unknown_handle = 1;
 			continue;
 		}
 		pol_class = p->p_class_val_to_name[i-1];
@@ -1159,6 +1161,7 @@ static int validate_classes(struct policydb *p)
 				return -EINVAL;
 			if (p->allow_unknown)
 				p->undefined_perms[class_val-1] |= perm_val;
+			print_unknown_handle = 1;
 			continue;
 		}
 		perdatum = hashtab_search(perms->table, def_perm);
@@ -1206,6 +1209,7 @@ static int validate_classes(struct policydb *p)
 					return -EINVAL;
 				if (p->allow_unknown)
 					p->undefined_perms[class_val-1] |= (1 << j);
+				print_unknown_handle = 1;
 				continue;
 			}
 			perdatum = hashtab_search(perms->table, def_perm);
@@ -1223,6 +1227,9 @@ static int validate_classes(struct policydb *p)
 			}
 		}
 	}
+	if (print_unknown_handle)
+		printk(KERN_INFO "SELinux: the above unknown classes and permissions will be %s\n",
+			(security_get_allow_unknown() ? "allowed" : "denied"));
 	return 0;
 }
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
