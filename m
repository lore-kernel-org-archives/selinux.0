Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5MLIPDf028840
 for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2018 17:18:25 -0400
From: Paul Moore <pmoore@redhat.com>
To: netdev@vger.kernel.org
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Fri, 22 Jun 2018 17:18:20 -0400
Message-ID: <152970230022.7734.15824980755229329454.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] ipv6: avoid copy_from_user() via
 ipv6_renew_options_kern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

The ipv6_renew_options_kern() function eventually called into
copy_from_user(), despite it not using any userspace buffers, which
was problematic as that ended up calling access_ok() which emited
a warning on x86 (and likely other arches as well).

  ipv6_renew_options_kern()
    ipv6_renew_options()
      ipv6_renew_option()
        copy_from_user()
          _copy_from_user()
            access_ok()

The access_ok() check inside _copy_from_user() is obviously the right
thing to do which means that calling copy_from_user() via
ipv6_renew_options_kern() is obviously the wrong thing to do.  This
patch fixes this by duplicating ipv6_renew_option() in the _kern()
variant, omitting the userspace copies and attributes.  The patch
does make an attempt at limiting the duplicated code by moving the
option allocation code into a common helper function.  I'm not in
love with this solution, but everything else I could think of seemed
worse.

The ipv6_renew_options_kern() function is an required by the
CALIPSO/RFC5570 code in net/ipv6/calipso.c.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 net/ipv6/exthdrs.c |  155 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 121 insertions(+), 34 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 5bc2bf3733ab..902748acd6fe 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1040,36 +1040,47 @@ static int ipv6_renew_option(void *ohdr,
 	return 0;
 }
 
+static int ipv6_renew_option_kern(void *ohdr,
+				  struct ipv6_opt_hdr *newopt, int newoptlen,
+				  int inherit,
+				  struct ipv6_opt_hdr **hdr,
+				  char **p)
+{
+	if (inherit) {
+		if (ohdr) {
+			memcpy(*p, ohdr,
+			       ipv6_optlen((struct ipv6_opt_hdr *)ohdr));
+			*hdr = (struct ipv6_opt_hdr *)*p;
+			*p += CMSG_ALIGN(ipv6_optlen(*hdr));
+		}
+	} else if (newopt) {
+		memcpy(*p, newopt, newoptlen);
+		*hdr = (struct ipv6_opt_hdr *)*p;
+		if (ipv6_optlen(*hdr) > newoptlen)
+			return -EINVAL;
+		*p += CMSG_ALIGN(newoptlen);
+	}
+	return 0;
+}
+
 /**
- * ipv6_renew_options - replace a specific ext hdr with a new one.
+ * ipv6_renew_option_alloc - helper function for allocating ipv6_txoptions
  *
  * @sk: sock from which to allocate memory
  * @opt: original options
  * @newtype: option type to replace in @opt
- * @newopt: new option of type @newtype to replace (user-mem)
- * @newoptlen: length of @newopt
- *
- * Returns a new set of options which is a copy of @opt with the
- * option type @newtype replaced with @newopt.
+ * @newoptlen: length of the new option
  *
- * @opt may be NULL, in which case a new set of options is returned
- * containing just @newopt.
- *
- * @newopt may be NULL, in which case the specified option type is
- * not copied into the new set of options.
- *
- * The new set of options is allocated from the socket option memory
- * buffer of @sk.
+ * This really should only ever be called by ipv6_renew_option() or
+ * ipv6_renew_option_kern().
  */
-struct ipv6_txoptions *
-ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
-		   int newtype,
-		   struct ipv6_opt_hdr __user *newopt, int newoptlen)
+static struct ipv6_txoptions *ipv6_renew_option_alloc(struct sock *sk,
+						      struct ipv6_txoptions *opt,
+						      int newtype,
+						      int newoptlen)
 {
 	int tot_len = 0;
-	char *p;
 	struct ipv6_txoptions *opt2;
-	int err;
 
 	if (opt) {
 		if (newtype != IPV6_HOPOPTS && opt->hopopt)
@@ -1082,7 +1093,7 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
 			tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst1opt));
 	}
 
-	if (newopt && newoptlen)
+	if (newoptlen)
 		tot_len += CMSG_ALIGN(newoptlen);
 
 	if (!tot_len)
@@ -1096,6 +1107,44 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
 	memset(opt2, 0, tot_len);
 	refcount_set(&opt2->refcnt, 1);
 	opt2->tot_len = tot_len;
+
+	return opt2;
+}
+
+/**
+ * ipv6_renew_options - replace a specific ext hdr with a new one.
+ *
+ * @sk: sock from which to allocate memory
+ * @opt: original options
+ * @newtype: option type to replace in @opt
+ * @newopt: new option of type @newtype to replace (user-mem)
+ * @newoptlen: length of @newopt
+ *
+ * Returns a new set of options which is a copy of @opt with the
+ * option type @newtype replaced with @newopt.
+ *
+ * @opt may be NULL, in which case a new set of options is returned
+ * containing just @newopt.
+ *
+ * @newopt may be NULL, in which case the specified option type is
+ * not copied into the new set of options.
+ *
+ * The new set of options is allocated from the socket option memory
+ * buffer of @sk.
+ */
+struct ipv6_txoptions *
+ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
+		   int newtype,
+		   struct ipv6_opt_hdr __user *newopt, int newoptlen)
+{
+	char *p;
+	struct ipv6_txoptions *opt2;
+	int err;
+
+	opt2 = ipv6_renew_option_alloc(sk, opt, newtype,
+				       newopt && newoptlen ? newoptlen : 0);
+	if (!opt2 || IS_ERR(opt2))
+		return opt2;
 	p = (char *)(opt2 + 1);
 
 	err = ipv6_renew_option(opt ? opt->hopopt : NULL, newopt, newoptlen,
@@ -1142,23 +1191,61 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
  * @newopt: new option of type @newtype to replace (kernel-mem)
  * @newoptlen: length of @newopt
  *
- * See ipv6_renew_options().  The difference is that @newopt is
- * kernel memory, rather than user memory.
+ * See ipv6_renew_options().  The difference is that @newopt is kernel memory,
+ * rather than user memory.
  */
 struct ipv6_txoptions *
 ipv6_renew_options_kern(struct sock *sk, struct ipv6_txoptions *opt,
-			int newtype, struct ipv6_opt_hdr *newopt,
-			int newoptlen)
+			int newtype,
+			struct ipv6_opt_hdr *newopt, int newoptlen)
 {
-	struct ipv6_txoptions *ret_val;
-	const mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	ret_val = ipv6_renew_options(sk, opt, newtype,
-				     (struct ipv6_opt_hdr __user *)newopt,
-				     newoptlen);
-	set_fs(old_fs);
-	return ret_val;
+	char *p;
+	struct ipv6_txoptions *opt2;
+	int err;
+
+	opt2 = ipv6_renew_option_alloc(sk, opt, newtype,
+				       newopt && newoptlen ? newoptlen : 0);
+	if (!opt2 || IS_ERR(opt2))
+		return opt2;
+	p = (char *)(opt2 + 1);
+
+	err = ipv6_renew_option_kern(opt ? opt->hopopt : NULL,
+				     newopt, newoptlen,
+				     newtype != IPV6_HOPOPTS,
+				     &opt2->hopopt, &p);
+	if (err)
+		goto out;
+
+	err = ipv6_renew_option_kern(opt ? opt->dst0opt : NULL,
+				     newopt, newoptlen,
+				     newtype != IPV6_RTHDRDSTOPTS,
+				     &opt2->dst0opt, &p);
+	if (err)
+		goto out;
+
+	err = ipv6_renew_option_kern(opt ? opt->srcrt : NULL,
+				     newopt, newoptlen,
+				     newtype != IPV6_RTHDR,
+				     (struct ipv6_opt_hdr **)&opt2->srcrt, &p);
+	if (err)
+		goto out;
+
+	err = ipv6_renew_option_kern(opt ? opt->dst1opt : NULL,
+				     newopt, newoptlen,
+				     newtype != IPV6_DSTOPTS,
+				     &opt2->dst1opt, &p);
+	if (err)
+		goto out;
+
+	opt2->opt_nflen = (opt2->hopopt ? ipv6_optlen(opt2->hopopt) : 0) +
+			  (opt2->dst0opt ? ipv6_optlen(opt2->dst0opt) : 0) +
+			  (opt2->srcrt ? ipv6_optlen(opt2->srcrt) : 0);
+	opt2->opt_flen = (opt2->dst1opt ? ipv6_optlen(opt2->dst1opt) : 0);
+
+	return opt2;
+out:
+	sock_kfree_s(sk, opt2, opt2->tot_len);
+	return ERR_PTR(err);
 }
 
 struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
