Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFDAC49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD6520665
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="l9hVwfYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbfIPTXa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:23:30 -0400
Received: from mailomta24-re.btinternet.com ([213.120.69.117]:59058 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387404AbfIPTXa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 15:23:30 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20190916192326.BRKG7249.re-prd-fep-049.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Mon, 16 Sep 2019 20:23:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1568661806; 
        bh=f/vUVv5jehtBTHP61b467JKQ7Hn9BV0KLULSImf+ILQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=l9hVwfYJhM5rhGfuzSfDDOMnGV5HSrzl5U2++Krv0E9C5msJL9HlusE1cw6ZXl4dmcXtR/aIB+NAW2CHRRTxDWWbVzHf32MGBn7sM9ijNNzTrhHm9vb6XoVDSFTU3MkG1S5loyFmNfNnCBcu4MSCJfXs+mkqPFKDvmFhUifSZTr0gyZwNRA6wY1su5XBZrXtoZggWvmVQ6diVZbXUatgg8Fdr0kvy/8GDC4KI+TAjCFd6LSz5rfD8nAqDtwU8WEZVJYMOFgoZPy9ujCyFSbB4URaJDUON0haiely7mTCUe696ms9aJHqiDiEl08ezKiT010ZZoFuGSKr+ZYZiCSAlw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.183]
X-OWM-Source-IP: 31.49.60.183 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudefgddufeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepfedurdegledriedtrddukeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledriedtrddukeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.183) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D6FA1ED0270180F; Mon, 16 Sep 2019 20:23:25 +0100
Message-ID: <35455b30b5185780628e92c98ec8191c70f39bde.camel@btinternet.com>
Subject: Re: [PATCH] selinux-testsuite: Add key and key_socket tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        paul@paul-moore.com
Date:   Mon, 16 Sep 2019 20:23:24 +0100
In-Reply-To: <e31a9342-2970-7d06-fcaa-57af3d05399d@tycho.nsa.gov>
References: <20190909131701.29588-1-richard_c_haines@btinternet.com>
         <39c10e04-a7cc-bfbf-ae6d-9e27ea332ff2@tycho.nsa.gov>
         <416a31737aec3b57b929098b15c02636faa68d4e.camel@btinternet.com>
         <e31a9342-2970-7d06-fcaa-57af3d05399d@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2019-09-16 at 15:11 -0400, Stephen Smalley wrote:
> On 9/16/19 2:55 PM, Richard Haines wrote:
> > On Mon, 2019-09-16 at 13:58 -0400, Stephen Smalley wrote:
> > > On 9/9/19 9:17 AM, Richard Haines wrote:
> > > > Test all permissions associated with the key and key_socket
> > > > classes.
> > > > 
> > > > Note that kernel 5.3 commit keys: Fix request_key() lack of
> > > > Link
> > > > perm
> > > > check on found key ("504b69eb3c95180bc59f1ae9096ad4b10bbbf254")
> > > > added an additional check for link perm on request_key(). The
> > > > tests
> > > > will support earlier kernels.
> > > 
> > > I'm not sure why you coupled key and key_socket together; they
> > > don't
> > > have anything to do with each other, and were introduced in very
> > > different kernel and probably refpolicy releases.  I would
> > > recommend
> > > splitting them.  SECCLASS_KEY and its permission checks were
> > > introduced
> > > in Linux v2.6.18; SECCLASS_KEY_SOCKET was part of the original
> > > SELinux
> > > merge for Linux 2.6.0.
> > 
> > I'll split them.
> > 
> > > You only appear to be testing self access, not permission checks
> > > between
> > > a process and a keyring created by another process in a different
> > > security context.
> > 
> > Okay I'll add these tests
> > > 1 test fails for me,
> > > keys/test ................... Failed KEYCTL_SESSION_TO_PARENT:
> > > Operation
> > > not permitted
> > > keys/test ................... 1/13
> > > #   Failed test at keys/test line 38.
> > > # Looks like you failed 1 test of 13.
> > > keys/test ................... Dubious, test returned 1 (wstat
> > > 256,
> > > 0x100)
> > 
> > You must have systems that don't like my patches - I can't get this
> > fail. Using Fedora 30 and also Rawhide from a few weeks ago.
> 
> I'll have to look into it further, but it was on stock F30.
> 
> > I don't know if this is of any interest (It works on Rawhide with
> > kernel from [1]):
> > 
> > I've been building 'key' tests to add the new permissions defined
> > in
> > kernel-next [1].
> > To test these with new policy supporting the new perms + old policy
> > that does not, I added the kernel test patch below.
> > This patch handles security_key_permission() passing a single
> > permission, as checking the current keys code I only see it passing
> > a
> > single permission at a time.
> > 
> > I've also an sepol patch + selinux-testsuite tests
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/security/selinux?h=next-20190904&id=1f96e0f129eb2bea15a00c154eee8b85aa181d1a
> 
> Yes, that's probably worth submitting for real.  Be sure to include 
> David Howells on the distribution for it. I wouldn't assume that only
> a 
> single permission can ever be passed unless key_permission() itself 
> asserts that invariant.
> 
That's okay as I've also tested the patch below that handles multiple
permissions from keys:
Any view on what is best !!

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 901cc052f..78413277c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6502,7 +6502,8 @@ static int selinux_key_permission(key_ref_t
key_ref,
 {
 	struct key *key;
 	struct key_security_struct *ksec;
-	unsigned oldstyle_perm;
+	unsigned int key_perm = 0, switch_perm = 0;
+	int x = KEY_NEED_ALL, bit = 1;
 	u32 sid;
 
 	/* if no specific permissions are requested, we skip the
@@ -6511,18 +6512,67 @@ static int selinux_key_permission(key_ref_t
key_ref,
 	if (perm == 0)
 		return 0;
 
-	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ |
KEY_NEED_WRITE |
-				KEY_NEED_SEARCH | KEY_NEED_LINK);
-	if (perm & KEY_NEED_SETSEC)
-		oldstyle_perm |= OLD_KEY_NEED_SETATTR;
-	if (perm & KEY_NEED_INVAL)
-		oldstyle_perm |= KEY_NEED_SEARCH;
-	if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
-		oldstyle_perm |= KEY_NEED_WRITE;
-	if (perm & KEY_NEED_JOIN)
-		oldstyle_perm |= KEY_NEED_SEARCH;
-	if (perm & KEY_NEED_CLEAR)
-		oldstyle_perm |= KEY_NEED_WRITE;
+	/*
+	 * selinux_key_permission() is called with only one permission
set.
+	 * However this will handle multiple bits set.
+	 */
+	while (x) {
+		switch_perm = bit & perm;
+		switch (switch_perm) {
+		case KEY_NEED_VIEW:
+			key_perm |= KEY__VIEW;
+			break;
+		case KEY_NEED_READ:
+			key_perm |= KEY__READ;
+			break;
+		case KEY_NEED_WRITE:
+			key_perm |= KEY__WRITE;
+			break;
+		case KEY_NEED_SEARCH:
+			key_perm |= KEY__SEARCH;
+			break;
+		case KEY_NEED_LINK:
+			key_perm |= KEY__LINK;
+			break;
+		case KEY_NEED_SETSEC: /* Keep this as "setattr" in
policy */
+			key_perm |= KEY__SETATTR;
+			break;
+		case KEY_NEED_INVAL:
+			key_perm |= KEY__INVAL;
+			break;
+		case KEY_NEED_REVOKE:
+			key_perm |= KEY__REVOKE;
+			break;
+		case KEY_NEED_JOIN:
+			key_perm |= KEY__JOIN;
+			break;
+		case KEY_NEED_CLEAR:
+			key_perm |= KEY__CLEAR;
+			break;
+		}
+		bit <<= 1;
+		x >>= 1;
+	}
+
+	/* If old policy, then reset new perms to orig. */
+	if (!selinux_policycap_key_perms()) {
+		if (perm & KEY_NEED_INVAL) {
+			key_perm &= ~KEY__INVAL;
+			key_perm |= KEY__SEARCH;
+		}
+		if (perm & KEY_NEED_REVOKE && !(perm &
OLD_KEY_NEED_SETATTR)) {
+			key_perm &= ~KEY__REVOKE;
+			key_perm |= KEY__WRITE;
+		}
+		if (perm & KEY_NEED_JOIN) {
+			key_perm &= ~KEY__JOIN;
+			key_perm |= KEY__SEARCH;
+		}
+		if (perm & KEY_NEED_CLEAR) {
+			key_perm &= ~KEY__CLEAR;
+			key_perm |= KEY__WRITE;
+		}
+	}
 
 	sid = cred_sid(cred);
 
@@ -6530,7 +6580,7 @@ static int selinux_key_permission(key_ref_t
key_ref,
 	ksec = key->security;
 
 	return avc_has_perm(&selinux_state,
-			    sid, ksec->sid, SECCLASS_KEY,
oldstyle_perm, NULL);
+			    sid, ksec->sid, SECCLASS_KEY, key_perm,
NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
@@ -6555,7 +6605,7 @@ static int selinux_watch_key(struct key *key)
 	u32 sid = current_sid();
 
 	return avc_has_perm(&selinux_state,
-			    sid, ksec->sid, SECCLASS_KEY,
KEY_NEED_VIEW, NULL);
+			    sid, ksec->sid, SECCLASS_KEY, KEY__VIEW,
NULL);
 }
 #endif
 #endif
diff --git a/security/selinux/include/classmap.h
b/security/selinux/include/classmap.h
index 201f7e588..a51ab9bd9 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -158,7 +158,7 @@ struct security_class_mapping secclass_map[] = {
 	  { "send", "recv", "relabelto", "forward_in", "forward_out",
NULL } },
 	{ "key",
 	  { "view", "read", "write", "search", "link", "setattr",
"create",
-	    NULL } },
+	    "inval", "revoke", "join", "clear", NULL } },
 	{ "dccp_socket",
 	  { COMMON_SOCK_PERMS,
 	    "node_bind", "name_connect", NULL } },
diff --git a/security/selinux/include/security.h
b/security/selinux/include/security.h
index 111121281..a248eef75 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -78,6 +78,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_KEYPERMS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
@@ -177,6 +178,13 @@ static inline bool
selinux_policycap_nnp_nosuid_transition(void)
 	return state-
>policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
 }
 
+static inline bool selinux_policycap_key_perms(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return state->policycap[POLICYDB_CAPABILITY_KEYPERMS];
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			 void *data, size_t len);
diff --git a/security/selinux/ss/services.c
b/security/selinux/ss/services.c
index d61563a36..eb3949fc8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -73,7 +73,8 @@ const char
*selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"extended_socket_class",
 	"always_check_network",
 	"cgroup_seclabel",
-	"nnp_nosuid_transition"
+	"nnp_nosuid_transition",
+	"key_perms"
 };
 
 static struct selinux_ss selinux_ss;


