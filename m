Subject: RE: how to implement permissive domains + an old bug
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        method@manicmethod.com, Karl MacMillan <kmacmillan@tresys.com>,
        setools <setools@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, pmoore@hp.com
In-Reply-To: <1203968898.2804.220.camel@moss-spartans.epoch.ncsc.mil>
References: <1203097803.2843.49.camel@localhost.localdomain>
	 <1203099272.16038.223.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880181FACF@exchange.columbia.tresys.com>
	 <1203101867.16038.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1203104633.2843.72.camel@localhost.localdomain>
	 <1203105260.16038.280.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880181FB16@exchange.columbia.tresys.com>
	 <1203947476.2804.168.camel@moss-spartans.epoch.ncsc.mil>
	 <47C2CA26.4070800@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B015880195C806@exchange.columbia.tresys.com>
	 <1203968898.2804.220.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 15:16:35 -0500
Message-Id: <1203970595.2846.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-25 at 14:48 -0500, Stephen Smalley wrote:
> On Mon, 2008-02-25 at 09:53 -0500, Joshua Brindle wrote:
> > Daniel J Walsh wrote:

> Maybe it would help if Eric could post or point to prior posting if one
> exists of his earlier experimental patch (offhand, I couldn't dig it up
> quickly).

THIS PATCH DOESN'T APPLY AND DOESN'T WORK.  I just dug it out of an
ancient git tree and haven't looked at it since Sept 17th (at least that
was my last commit on this branch).  It still has 'special' usage of
auditdeny which I don't plan to include when we get back to this.

Wow Dan, I really can ignore you for a long time...

-Eric

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 0e69adf..91b9ec6 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -877,7 +877,17 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	denied = requested & ~(p_ae->avd.allowed);
 
 	if (!requested || denied) {
-		if (selinux_enforcing || (flags & AVC_STRICT))
+		if (selinux_enforcing)
+			if ((unlikely(security_permissive_sid(ssid)) > 0) &&
+			    requested &&
+			    !(requested & avd->auditdeny)) {
+				if (node)
+					avc_update_node(AVC_CALLBACK_GRANT,requested,
+							ssid,tsid,tclass);
+			}
+			else
+				rc = -EACCES;
+		else if (flags & AVC_STRICT)
 			rc = -EACCES;
 		else
 			if (node)
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 83bdd4d..3832899 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -50,6 +50,8 @@ struct av_decision {
 	u32 seqno;
 };
 
+int security_permissive_sid(u32 sid);
+
 int security_compute_av(u32 ssid, u32 tsid,
 	u16 tclass, u32 requested,
 	struct av_decision *avd);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f05f97a..205006d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -254,7 +254,7 @@ static int type_index(void *key, void *datum, void *datap)
 	typdatum = datum;
 	p = datap;
 
-	if (typdatum->primary) {
+	if (typdatum->flags & PRIMARY_MASK) {
 		if (!typdatum->value || typdatum->value > p->p_types.nprim)
 			return -EINVAL;
 		p->p_type_val_to_name[typdatum->value - 1] = key;
@@ -1215,7 +1215,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 
 	len = le32_to_cpu(buf[0]);
 	typdatum->value = le32_to_cpu(buf[1]);
-	typdatum->primary = le32_to_cpu(buf[2]);
+	typdatum->flags = le32_to_cpu(buf[2]);
 
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 8319d5f..c0bd006 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -81,7 +81,9 @@ struct role_allow {
 /* Type attributes */
 struct type_datum {
 	u32 value;		/* internal type value */
-	unsigned char primary;	/* primary name? */
+	unsigned char flags;	/* primary name? */
+#define PRIMARY_MASK 0x01
+#define PERMISSIVE_MASK 0x02
 };
 
 /* User attributes */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f00161e..343dd70 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -389,6 +389,23 @@ static int context_struct_compute_av(struct context *scontext,
 	return 0;
 }
 
+int security_permissive_sid(u32 sid)
+{
+	struct type_datum *typdatum;
+	char *context;
+	int rc;
+	u32 len;
+	rc = security_sid_to_context(sid, &context, &len);
+	if (rc)
+		return rc;
+
+	typdatum = hashtab_search(policydb.p_types.table, context);
+	if (!typdatum)
+		return 0;
+
+	return (typdatum->flags && PERMISSIVE_MASK);
+}
+
 static int security_validtrans_handle_fail(struct context *ocontext,
                                            struct context *ncontext,
                                            struct context *tcontext,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
