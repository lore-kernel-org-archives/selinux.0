From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/4] flex_array: fix flex_array_put_ptr macro to be valid C
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Tue, 23 Nov 2010 11:52:27 -0500
Message-ID: <20101123165227.4489.29282.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Using flex_array_put_ptr() results in a compile error "error: lvalue
required as unary ‘&’ operand"  fix the casting order to fix this.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/flex_array.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/flex_array.h b/include/linux/flex_array.h
index 631b77f..70e4efa 100644
--- a/include/linux/flex_array.h
+++ b/include/linux/flex_array.h
@@ -71,7 +71,7 @@ void *flex_array_get(struct flex_array *fa, unsigned int element_nr);
 int flex_array_shrink(struct flex_array *fa);
 
 #define flex_array_put_ptr(fa, nr, src, gfp) \
-	flex_array_put(fa, nr, &(void *)(src), gfp)
+	flex_array_put(fa, nr, (void *)&(src), gfp)
 
 void *flex_array_get_ptr(struct flex_array *fa, unsigned int element_nr);
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
