Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1254322047.30591.52.camel@moss-pluto.epoch.ncsc.mil>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>
	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>
	 <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4AC2C32D.3010405@ak.jp.nec.com>
	 <1254314361.30591.11.camel@moss-pluto.epoch.ncsc.mil>
	 <1254318841.30591.22.camel@moss-pluto.epoch.ncsc.mil>
	 <1254322047.30591.52.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Sep 2009 11:10:53 -0400
Message-Id: <1254323453.30591.56.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-30 at 10:47 -0400, Stephen Smalley wrote:
> On Wed, 2009-09-30 at 09:54 -0400, Stephen Smalley wrote:
> > On Wed, 2009-09-30 at 08:39 -0400, Stephen Smalley wrote:
> > > On Wed, 2009-09-30 at 11:32 +0900, KaiGai Kohei wrote:
> > > > Stephen Smalley wrote:
> > > > > There are several legacy permissions that are no longer used by SELinux.
> > > > > We could remove these from the kernel's classmap.h definitions without
> > > > > breaking anything (subsequent permissions would get mapped to policy
> > > > > values appropriately by the new logic), but removing them from the
> > > > > policy would be harder as it would break all kernels that predate these
> > > > > patches.  Thus, I'm not sure we benefit from removing them from
> > > > > classmap.h.
> > > > > 
> > > > > The unused permissions include:
> > > > > # LSM hook never merged to mainline
> > > > > file swapon
> > > > > # compat_net=1 checks
> > > > > socket { recv_msg send_msg }
> > > > > # Only added so that subsequent permissions (execmod) would get the same value as class file
> > > > > chr_file { execute_no_trans entrypoint }
> > > > > # Original socket controls; never merged to mainline
> > > > > tcp_socket { connectto newconn acceptfrom }
> > > > > # legacy network or compat_net=1 checks
> > > > > node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send enforce_dest dccp_recv dccp_send }
> > > > > # legacy network or compat_net=1 checks
> > > > > netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
> > > > > # Original socket controls; never merged to mainline - only connectto is used
> > > > > unix_stream_socket { newconn acceptfrom }
> > > > > # Patches merged prematurely by Fedora, never merged to mainline
> > > > > packet { flow_in flow_out }
> > > > 
> > > > It is just a report. I could not reach origin of the matter yet.
> > > > 
> > > > When I applies your patch as is, build, install and reboot,
> > > > I could not find any *obvious* matter (such as boot failed). Good.
> > > > 
> > > > Then, I modified the classmap.h for the test purpose.
> > > > The object classes and access vectors are ramdomized as the
> > > > attached claasmap.h.
> > > > This patch enables to map value of them using text identifier,
> > > > so we can expect it works fine independent from the order of
> > > > classes and access vectors.
> > > > 
> > > > Did you already remove the unused kernel permissions?
> > > > 
> > > > -- kernel boot messages
> > > >    :
> > > > Creating initial device nodes
> > > > plymouthd used greatest stack depth: 6532 bytes left
> > > > async/0 used greatest stack depth: 6284 bytes left
> > > > async/1 used greatest stack depth: 5828 bytes left
> > > > input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
> > > > kjournald starting.  Commit interval 5 seconds
> > > > EXT3-fs: mounted filesystem with ordered data mode.
> > > > type=1404 audit(1254231627.600:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
> > > > SELinux:  Permission module_request in class system not defined in policy.
> > > > SELinux: the above unknown classes and permissions will be allowed
> > > > type=1403 audit(1254231628.088:3): policy loaded auid=4294967295 ses=4294967295
> > > > type=1400 audit(1254231628.100:4): avc:  denied  { transition } for  pid=58 comm="init" path="/bin/plymouth" dev=rootfs ino=3512 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:root_t:s0 tclass=process
> > > > type=1400 audit(1254231628.438:5): avc:  denied  { transition } for  pid=58 comm="init" path="/sbin/telinit" dev=sda5 ino=621655 scontext=system_u:object_r:init_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=process
> > > > type=1400 audit(1254231628.458:6): avc:  denied  { entrypoint } for  pid=58 comm="init" path="/sbin/telinit" dev=sda5 ino=621655 scontext=system_u:object_r:bin_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
> > > > init used greatest stack depth: 5684 bytes left
> > > > init: Not being executed as init
> > > > ------
> > > 
> > > Oh, I see why.  The security server internally uses a few class and
> > > permission symbolic definitions (e.g. SECCLASS_PROCESS,
> > > PROCESS__TRANSITION, ...), and it expects them to correspond to the
> > > policy values rather than the kernel-private indices.  So it needs to
> > > instead use string_to_security_class() and string_to_av_perm() to look
> > > them up.  Easy enough to fix.
> > 
> > I applied the patch below on top.  Since we use the process class and
> > process transition permissions multiple times and even need the process
> > class value at policy load, I look those values up during policydb_read
> > and cache them in the policydb.  For the other uses of SECCLASS_ values
> > within the security server, I just call unmap_class() as needed.
> > Building it now. I'll fold this into the first patch if it works.
> 
> Ah, that crashes on boot.  Need to wait until after we've done
> policydb_index_classes() to call string_to_av_perm().  Let's try this
> instead:

Almost, but not quite - need to always unmap the class passed to
security_genfs_sid().

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index b5407f1..3f2b270 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -532,7 +532,7 @@ int mls_compute_sid(struct context *scontext,
 		}
 		/* Fallthrough */
 	case AVTAB_CHANGE:
-		if (tclass == SECCLASS_PROCESS)
+		if (tclass == policydb.process_class)
 			/* Use the process MLS attributes. */
 			return mls_context_cpy(newcontext, scontext);
 		else
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index d6948d1..f036672 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1639,6 +1639,40 @@ static int policydb_bounds_sanity_check(struct policydb *p)
 
 extern int ss_initialized;
 
+u16 string_to_security_class(struct policydb *p, const char *name)
+{
+	struct class_datum *cladatum;
+
+	cladatum = hashtab_search(p->p_classes.table, name);
+	if (!cladatum)
+		return 0;
+
+	return cladatum->value;
+}
+
+u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
+{
+	struct class_datum *cladatum;
+	struct perm_datum *perdatum = NULL;
+	struct common_datum *comdatum;
+
+	if (!tclass || tclass > p->p_classes.nprim)
+		return 0;
+
+	cladatum = p->class_val_to_struct[tclass-1];
+	comdatum = cladatum->comdatum;
+	if (comdatum)
+		perdatum = hashtab_search(comdatum->permissions.table,
+					  name);
+	if (!perdatum)
+		perdatum = hashtab_search(cladatum->permissions.table,
+					  name);
+	if (!perdatum)
+		return 0;
+
+	return 1U << (perdatum->value-1);
+}
+
 /*
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
@@ -1860,6 +1894,16 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
+	p->process_class = string_to_security_class(p, "process");
+	if (!p->process_class)
+		goto bad;
+	p->process_trans_perms = string_to_av_perm(p, p->process_class,
+						   "transition");
+	p->process_trans_perms |= string_to_av_perm(p, p->process_class,
+						    "dyntransition");
+	if (!p->process_trans_perms)
+		goto bad;
+
 	for (i = 0; i < info->ocon_num; i++) {
 		rc = next_entry(buf, fp, sizeof(u32));
 		if (rc < 0)
@@ -2100,7 +2144,7 @@ int policydb_read(struct policydb *p, void *fp)
 					goto bad;
 				rt->target_class = le32_to_cpu(buf[0]);
 			} else
-				rt->target_class = SECCLASS_PROCESS;
+				rt->target_class = p->process_class;
 			if (!policydb_type_isvalid(p, rt->source_type) ||
 			    !policydb_type_isvalid(p, rt->target_type) ||
 			    !policydb_class_isvalid(p, rt->target_class)) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 1109505..cdcc570 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -254,6 +254,9 @@ struct policydb {
 
 	unsigned int reject_unknown : 1;
 	unsigned int allow_unknown : 1;
+
+	u16 process_class;
+	u32 process_trans_perms;
 };
 
 extern void policydb_destroy(struct policydb *p);
@@ -294,5 +297,8 @@ static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 	return 0;
 }
 
+extern u16 string_to_security_class(struct policydb *p, const char *name);
+extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
+
 #endif	/* _SS_POLICYDB_H_ */
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f0522aa..e19baa8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -94,41 +94,6 @@ static int context_struct_compute_av(struct context *scontext,
 				     u32 requested,
 				     struct av_decision *avd);
 
-static u16 string_to_security_class(struct policydb *p,
-				    const char *name)
-{
-	struct class_datum *cladatum;
-
-	cladatum = hashtab_search(p->p_classes.table, name);
-	if (!cladatum)
-		return 0;
-
-	return cladatum->value;
-}
-
-static u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
-{
-	struct class_datum *cladatum;
-	struct perm_datum *perdatum = NULL;
-	struct common_datum *comdatum;
-
-	if (!tclass || tclass > p->p_classes.nprim)
-		return 0;
-
-	cladatum = p->class_val_to_struct[tclass-1];
-	comdatum = cladatum->comdatum;
-	if (comdatum)
-		perdatum = hashtab_search(comdatum->permissions.table,
-					  name);
-	if (!perdatum)
-		perdatum = hashtab_search(cladatum->permissions.table,
-					  name);
-	if (!perdatum)
-		return 0;
-
-	return 1U << (perdatum->value-1);
-}
-
 struct selinux_mapping {
 	u16 value; /* policy value */
 	unsigned num_perms;
@@ -138,11 +103,10 @@ struct selinux_mapping {
 static struct selinux_mapping *current_mapping;
 static u16 current_mapping_size;
 
-static int
-selinux_set_mapping(struct policydb *pol,
-		    struct security_class_mapping *map,
-		    struct selinux_mapping **out_map_p,
-		    u16 *out_map_size)
+static int selinux_set_mapping(struct policydb *pol,
+			       struct security_class_mapping *map,
+			       struct selinux_mapping **out_map_p,
+			       u16 *out_map_size)
 {
 	struct selinux_mapping *out_map = NULL;
 	size_t size = sizeof(struct selinux_mapping);
@@ -225,8 +189,7 @@ err:
  * Get real, policy values from mapped values
  */
 
-static u16
-unmap_class(u16 tclass)
+static u16 unmap_class(u16 tclass)
 {
 	if (tclass < current_mapping_size)
 		return current_mapping[tclass].value;
@@ -234,8 +197,7 @@ unmap_class(u16 tclass)
 	return tclass;
 }
 
-static u32
-unmap_perm(u16 tclass, u32 tperm)
+static u32 unmap_perm(u16 tclass, u32 tperm)
 {
 	if (tclass < current_mapping_size) {
 		unsigned i;
@@ -252,8 +214,8 @@ unmap_perm(u16 tclass, u32 tperm)
 	return tperm;
 }
 
-static void
-map_decision(u16 tclass, struct av_decision *avd, int allow_unknown)
+static void map_decision(u16 tclass, struct av_decision *avd,
+			 int allow_unknown)
 {
 	if (tclass < current_mapping_size) {
 		unsigned i, n = current_mapping[tclass].num_perms;
@@ -661,9 +623,9 @@ static int context_struct_compute_av(struct context *scontext,
 	 * to remain in the correct class.
 	 */
 	if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
-		if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
-		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
-			tclass = SECCLASS_NETLINK_SOCKET;
+		if (tclass >= unmap_class(SECCLASS_NETLINK_ROUTE_SOCKET) &&
+		    tclass <= unmap_class(SECCLASS_NETLINK_DNRT_SOCKET))
+			tclass = unmap_class(SECCLASS_NETLINK_SOCKET);
 
 	/*
 	 * Initialize the access vectors to the default values.
@@ -730,8 +692,8 @@ static int context_struct_compute_av(struct context *scontext,
 	 * role is changing, then check the (current_role, new_role)
 	 * pair.
 	 */
-	if (tclass == SECCLASS_PROCESS &&
-	    (avd->allowed & (PROCESS__TRANSITION | PROCESS__DYNTRANSITION)) &&
+	if (tclass == policydb.process_class &&
+	    (avd->allowed & policydb.process_trans_perms) &&
 	    scontext->role != tcontext->role) {
 		for (ra = policydb.role_allow; ra; ra = ra->next) {
 			if (scontext->role == ra->role &&
@@ -739,8 +701,7 @@ static int context_struct_compute_av(struct context *scontext,
 				break;
 		}
 		if (!ra)
-			avd->allowed &= ~(PROCESS__TRANSITION |
-					  PROCESS__DYNTRANSITION);
+			avd->allowed &= ~policydb.process_trans_perms;
 	}
 
 	/*
@@ -807,9 +768,9 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 	 * to remain in the correct class.
 	 */
 	if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
-		if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
-		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
-			tclass = SECCLASS_NETLINK_SOCKET;
+		if (tclass >= unmap_class(SECCLASS_NETLINK_ROUTE_SOCKET) &&
+		    tclass <= unmap_class(SECCLASS_NETLINK_DNRT_SOCKET))
+			tclass = unmap_class(SECCLASS_NETLINK_SOCKET);
 
 	if (!tclass || tclass > policydb.p_classes.nprim) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n",
@@ -1412,7 +1373,7 @@ static int security_compute_sid(u32 ssid,
 
 	if (!ss_initialized) {
 		switch (orig_tclass) {
-		case SECCLASS_PROCESS:
+		case SECCLASS_PROCESS: /* kernel value */
 			*out_sid = ssid;
 			break;
 		default:
@@ -1460,13 +1421,11 @@ static int security_compute_sid(u32 ssid,
 	}
 
 	/* Set the role and type to default values. */
-	switch (tclass) {
-	case SECCLASS_PROCESS:
+	if (tclass == policydb.process_class) {
 		/* Use the current role and type of process. */
 		newcontext.role = scontext->role;
 		newcontext.type = scontext->type;
-		break;
-	default:
+	} else {
 		/* Use the well-defined object role. */
 		newcontext.role = OBJECT_R_VAL;
 		/* Use the type of the related object. */
@@ -1497,8 +1456,7 @@ static int security_compute_sid(u32 ssid,
 	}
 
 	/* Check for class-specific changes. */
-	switch (tclass) {
-	case SECCLASS_PROCESS:
+	if  (tclass == policydb.process_class) {
 		if (specified & AVTAB_TRANSITION) {
 			/* Look for a role transition rule. */
 			for (roletr = policydb.role_tr; roletr;
@@ -1511,9 +1469,6 @@ static int security_compute_sid(u32 ssid,
 				}
 			}
 		}
-		break;
-	default:
-		break;
 	}
 
 	/* Set the MLS attributes.
@@ -2167,7 +2122,7 @@ out_unlock:
 	}
 	for (i = 0, j = 0; i < mynel; i++) {
 		rc = avc_has_perm_noaudit(fromsid, mysids[i],
-					  SECCLASS_PROCESS,
+					  SECCLASS_PROCESS, /* kernel value */
 					  PROCESS__TRANSITION, AVC_STRICT,
 					  NULL);
 		if (!rc)
@@ -2195,10 +2150,11 @@ out:
  */
 int security_genfs_sid(const char *fstype,
 		       char *path,
-		       u16 sclass,
+		       u16 orig_sclass,
 		       u32 *sid)
 {
 	int len;
+	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
 	int rc = 0, cmp = 0;
@@ -2208,6 +2164,8 @@ int security_genfs_sid(const char *fstype,
 
 	read_lock(&policy_rwlock);
 
+	sclass = unmap_class(orig_sclass);
+
 	for (genfs = policydb.genfs; genfs; genfs = genfs->next) {
 		cmp = strcmp(fstype, genfs->fstype);
 		if (cmp <= 0)


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
