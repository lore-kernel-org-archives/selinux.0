Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96KB40J007814
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:11:04 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96K9oQW024030
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:09:50 GMT
Message-Id: <20061006201103.644565000@tresys.com>>
References: <20061006200951.006196000@tresys.com>>
Date: Fri, 06 Oct 2006 16:09:52 -0400
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] Bug fix in polidydb_destroy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes two bugs in policydb_destroy. Two list pointers (policydb.ocontexts[i] and policydb.genfs) were not being reset to NULL when the lists they pointed to were being freed. This caused a problem when the initial policy load failed, as the policydb being destroyed was not a temporary new policydb that was thrown away, but rather was the global (active) policydb. Consequently, later functions, particularly sys_bind->selinux_socket_bind->security_node_sid and do_rw_proc->selinux_sysctl->selinux_proc_get_sid->security_genfs_sid tried to dereference memory that had previously been freed.

Signed-off-by: Chad Sellers <csellers@tresys.com>

---
 security/selinux/ss/policydb.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-discovery/security/selinux/ss/policydb.c
===================================================================
--- linux-2.6-discovery.orig/security/selinux/ss/policydb.c
+++ linux-2.6-discovery/security/selinux/ss/policydb.c
@@ -613,6 +613,7 @@ void policydb_destroy(struct policydb *p
 			c = c->next;
 			ocontext_destroy(ctmp,i);
 		}
+		p->ocontexts[i] = NULL;
 	}
 
 	g = p->genfs;
@@ -628,6 +629,7 @@ void policydb_destroy(struct policydb *p
 		g = g->next;
 		kfree(gtmp);
 	}
+	p->genfs = NULL;
 
 	cond_policydb_destroy(p);
 

--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
