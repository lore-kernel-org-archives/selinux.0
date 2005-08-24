Subject: Re: libselinux category patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430C75B4.3020008@redhat.com>
References: <430A33E5.1030100@redhat.com>
	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
	 <430C75B4.3020008@redhat.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 15:36:24 -0400
Message-Id: <1124912184.11553.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 09:27 -0400, Daniel J Walsh wrote:
> I still want at least the set_comp diff to allow me to set level to 
> NULL, so it does not show up.

How about this patch?  Changes set_comp to allow setting to NULL,
but doesn't allow whitespace in the context.  Also changes context_str
to be somewhat more general, but context_new is still not going to like
a context that lacks any field other than the level, and the kernel
won't take a partial one.

Index: libselinux/src/context.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/context.c,v
retrieving revision 1.10
diff -u -p -r1.10 context.c
--- libselinux/src/context.c	11 Aug 2005 13:58:28 -0000	1.10
+++ libselinux/src/context.c	24 Aug 2005 19:14:59 -0000
@@ -119,15 +119,15 @@ context_str(context_t context)
         }
         n->current_str = malloc(total);
         if ( n->current_str != 0 ) {
-                char *cp = stpcpy(n->current_str,n->component[0]);
-                *cp++ = ':';
-                cp = stpcpy(cp,n->component[1]);
-                *cp++ = ':';
-                cp = stpcpy(cp,n->component[2]);
-                if ( n->component[3] ) {
-                        *cp++ = ':';
-                        strcpy(cp,n->component[3]);
-                }
+                char *cp = n->current_str;
+
+		cp = stpcpy(cp, n->component[0]);
+		for (i = 1; i < 4; i++) {
+			if (n->component[i]) {
+				*cp++ = ':';
+				cp = stpcpy(cp, n->component[i]);
+			}
+		}
         }
         return n->current_str;
 }
@@ -137,19 +137,22 @@ hidden_def(context_str)
 
 static int set_comp(context_private_t* n,int index, const char *str)
 {
-        char *t = (char*) malloc(strlen(str)+1);
+	char *t = NULL;
         const char *p;
-        if ( !t ) { return 1; }
-        for ( p = str; *p; p++ ) {
-                if ( *p == '\t' || *p == ' ' || *p == '\n' || *p == '\r' ||
-                     (*p == ':' && index != COMP_RANGE) ) {
-                        free(t);
-                        return 1;
-                }
-        }
+	if (str) {
+		t = (char*) malloc(strlen(str)+1);
+		if ( !t ) { return 1; }
+		for ( p = str; *p; p++ ) {
+			if ( *p == '\t' || *p == ' ' || *p == '\n' || *p == '\r' ||
+			     (*p == ':' && index != COMP_RANGE) ) {
+				free(t);
+				return 1;
+			}
+		}
+		strcpy(t,str);
+	}
         conditional_free(&n->component[index]);
         n->component[index] = t;
-        strcpy(t,str);
         return 0;
 }
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
