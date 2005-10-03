Subject: Re: [PATCH] mls in modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux-dev@tresys.com, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1128112952.22583.25.camel@twoface.columbia.tresys.com>
References: <1128112952.22583.25.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 11:31:25 -0400
Message-Id: <1128353485.26285.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 16:42 -0400, Joshua Brindle wrote:
> This patch allows both base modules and modules to be built with the -M
> (MLS) flag. For base modules it adds all the MLS components that are in
> the normal policy. For modules it sets the MLS flag. The following
> restrictions are currently placed on the policy:
> 
> - Users cannot be declared in MLS modules, because levels cannot be
> 'required'

Will this be addressed soon?  Or are modules in Fedora going to be
unable to declare users at all?

diff -purN -x .svn libsepol/include/sepol/context.h libsepol/include/sepol/context.h
--- libsepol/include/sepol/context.h	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/include/sepol/context.h	2005-09-30 11:16:30.000000000 -0400
@@ -38,6 +38,10 @@ typedef struct context_struct {
 static inline void mls_context_init(context_struct_t * c)
 {
 	memset(&c->range, 0, sizeof(c->range));
+	memset(&c->range.level[0], 0, sizeof(c->range.level[0]));
+	memset(&c->range.level[1], 0, sizeof(c->range.level[1]));
+	ebitmap_init(&c->range.level[0].cat);
+	ebitmap_init(&c->range.level[1].cat);
 }

Seems a bit redundant?

@@ -75,12 +73,9 @@ static inline int mls_context_cmp(contex
 
 static inline void mls_context_destroy(context_struct_t * c)
 {
-	if (!sepol_mls_enabled())
-		return;
-
 	ebitmap_destroy(&c->range.level[0].cat);
 	ebitmap_destroy(&c->range.level[1].cat);
-	mls_context_init(c);
+	memset(&c->range, 0, sizeof(c->range));
 }

Seems equivalent.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
