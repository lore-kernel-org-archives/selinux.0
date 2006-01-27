Subject: Re: [PATCH] libsepol - cond_expr mapping and package num_sections
	bugs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43DA88D1.5000408@tresys.com>
References: <43DA88D1.5000408@tresys.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 16:16:18 -0500
Message-Id: <1138396578.3728.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-27 at 15:55 -0500, Joshua Brindle wrote:
> This patch fixes a bug where a boolean expression node which was an
> operation was trying to map the boolean value to the base policy during
> linking and getting an index from the previous map ( 0 - 1). The
> solution is to not map the boolean value if the expr_type is not COND_BOOL.
> 
> It also fixes a bug where a base module getting written after being read
> (during linking) would end up with a num_sections of 4 since
> num_sections was initialized during the read and then incremented during
> write. The solution is to move the num_sections incrementing to the
> functions where the sections are actually set, so that it is already
> correct when entering package_write.

diff -x.svn -pruN libsepol/src/module.c libsepol/src/module.c
--- libsepol/src/module.c	2006-01-26 14:51:34.000000000 -0500
+++ libsepol/src/module.c	2006-01-27 15:09:18.000000000 -0500
@@ -78,7 +78,7 @@ static int module_package_init(sepol_mod
 	if (sepol_policydb_create(&p->policy))
 		return -1;
 
-	p->num_sections = 0;
+	p->num_sections = 1;
 	p->version = 1;
 	return 0;
 }
@@ -131,6 +131,7 @@ int sepol_module_package_set_file_contex
 		memcpy(p->file_contexts, data, len);
 	}
 	p->file_contexts_len = len;
+	p->num_sections++;
 	return 0;
 }
  

This seems prone to similar bugs later.  Suppose I call
sepol_module_package_set_file_contexts multiple times; each time it
frees the old one and replaces it, so I shouldn't be incrementing the
number of sections here.

Possibly num_sections shouldn't be part of the state of the struct at
all; it should just be a local variable.  In the read case, we pull it
from the image/file and use it locally (just need to pass it back from
read_offsets to the caller).  For write, we always start with a count of
1 and increment it if we have a p->file_contexts.

@@ -536,9 +537,7 @@ int sepol_module_package_write(sepol_mod
 		if (policydb_write(&p->policy->p, &polfile))
 			return -1;
 		len = polfile.len;
-		if (polfile.len)
-			p->num_sections++;
-		else 
+		if (!polfile.len)
 			return -1;
 		
 	} else {
@@ -546,9 +545,6 @@ int sepol_module_package_write(sepol_mod
 		return -1;
 	}
 
-	if (p->file_contexts)
-		p->num_sections++;
-
 	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
 	buf[1] = cpu_to_le32(p->version);
 	buf[2] = cpu_to_le32(p->num_sections);


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
