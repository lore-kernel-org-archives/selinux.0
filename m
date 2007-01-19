From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: 2.6.19.2 Oops
Date: Fri, 19 Jan 2007 13:07:55 -0500
Cc: Antoine Martin <antoine@nagafix.co.uk>,
        Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>
References: <45B09CFA.5070805@nagafix.co.uk> <45B0E782.9070102@nagafix.co.uk> <200701191048.30219.paul.moore@hp.com>
In-Reply-To: <200701191048.30219.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701191307.56051.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, January 19 2007 10:48 am, Paul Moore wrote:
> On Friday, January 19 2007 10:45 am, Antoine Martin wrote:
> > Disabling Netlabel did the trick.
> > Shouldn't that be sent to stable for 2.6.19.3? (it is a oops after all)
>
> Yep, I'm working on a patch as I type this ...

This patch should solve the problem.  Before I send this off for the stable 
tree does anyone have any comments?

(I'd like to try and send this off by the end of the day today)

---
 security/selinux/ss/mls.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6.19.y/security/selinux/ss/mls.c
===================================================================
--- linux-2.6.19.y.orig/security/selinux/ss/mls.c
+++ linux-2.6.19.y/security/selinux/ss/mls.c
@@ -641,10 +641,14 @@ int mls_export_cat(const struct context 
 	int rc = -EPERM;
 
 	if (!selinux_mls_enabled) {
-		*low = NULL;
-		*low_len = 0;
-		*high = NULL;
-		*high_len = 0;
+		if (low != NULL) {
+			*low = NULL;
+			*low_len = 0;
+		}
+		if (high != NULL) {
+			*high = NULL;
+			*high_len = 0;
+		}
 		return 0;
 	}

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
