Message-ID: <47A328D2.9080300@manicmethod.com>
Date: Fri, 01 Feb 2008 09:12:34 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Todd Miller <tmiller@tresys.com>
Subject: [PATCH] optionally consume input at expand time to save memory
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch should reduce the amount of peak memory required to expand 
the policy by consuming part of the input policy during expansion. It 
reduced the rss of semodule_expand with a full refpolicy from 86 to 66 meg.

On a side note, if anyone knows of a good tool for profiling heap usage 
I'd like to hear, I've tried valgrind massif, google-perftools, and 
smaps and none of them seem to work that well...

Signed-off-by: Joshua Brindle <method@manicmethod.com>

Index: libsemanage/src/semanage_store.c
===================================================================
--- libsemanage/src/semanage_store.c    (revision 2774)
+++ libsemanage/src/semanage_store.c    (working copy)
@@ -1636,6 +1636,8 @@
        if (sepol_policydb_create(&out))
                goto err;
 
+       sepol_set_expand_consume_base(sh->sepolh, 1);
+
        if (sepol_expand_module(sh->sepolh,
                                sepol_module_package_get_policy(base), out, 0,
                                expand_check)
Index: libsepol/include/sepol/handle.h
===================================================================
--- libsepol/include/sepol/handle.h     (revision 2774)
+++ libsepol/include/sepol/handle.h     (working copy)
@@ -11,6 +11,10 @@
  * not disable dontaudits, 1 disables them */
 void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit);
 
+/* Set whether module_expand() should consume the base policy passed in.
+ * This should reduce the amount of memory required to expand the policy. */
+void sepol_set_expand_consume_base(sepol_handle_t * sh, int consume_base);
+
 /* Destroy a sepol handle. */
 void sepol_handle_destroy(sepol_handle_t *);
 
Index: libsepol/src/handle.h
===================================================================
--- libsepol/src/handle.h       (revision 2774)
+++ libsepol/src/handle.h       (working copy)
@@ -16,6 +16,7 @@
        void *msg_callback_arg;
 
        int disable_dontaudit;
+       int expand_consume_base;
 
 };
 
Index: libsepol/src/libsepol.map
===================================================================
--- libsepol/src/libsepol.map   (revision 2774)
+++ libsepol/src/libsepol.map   (working copy)
@@ -13,5 +13,6 @@
        sepol_policy_kern_*;
        sepol_policy_file_*;
        sepol_set_disable_dontaudit;
+       sepol_set_expand_consume_base;
   local: *;
 };
Index: libsepol/src/expand.c
===================================================================
--- libsepol/src/expand.c       (revision 2774)
+++ libsepol/src/expand.c       (working copy)
@@ -2134,17 +2134,17 @@
  */
 static int copy_and_expand_avrule_block(expand_state_t * state)
 {
-       avrule_block_t *curblock;
+       avrule_block_t *curblock = state->base->global;
+       avrule_block_t *prevblock;
        int retval = -1;
 
-       for (curblock = state->base->global; curblock != NULL;
-            curblock = curblock->next) {
+       while (curblock) {
                avrule_decl_t *decl = curblock->enabled;
                avrule_t *cur_avrule;
 
                if (decl == NULL) {
                        /* nothing was enabled within this block */
-                       continue;
+                       goto cont;
                }
 
                /* copy role allows and role trans */
@@ -2186,6 +2186,18 @@
                /* copy conditional rules */
                if (cond_node_copy(state, decl->cond_list))
                        goto cleanup;
+
+      cont:
+               prevblock = curblock;
+               curblock = curblock->next;
+
+               if (state->handle && state->handle->expand_consume_base) {
+                       /* set base top avrule block in case there
+                        * is an error condition and the policy needs 
+                        * to be destroyed */
+                       state->base->global = curblock;
+                       avrule_block_destroy(prevblock);
+               }
        }
 
        retval = 0;
Index: libsepol/src/handle.c
===================================================================
--- libsepol/src/handle.c       (revision 2774)
+++ libsepol/src/handle.c       (working copy)
@@ -16,6 +16,7 @@
 
        /* by default do not disable dontaudits */
        sh->disable_dontaudit = 0;
+       sh->expand_consume_base = 0;
 
        return sh;
 }
@@ -26,6 +27,12 @@
        sh->disable_dontaudit = disable_dontaudit;
 }
 
+void sepol_set_expand_consume_base(sepol_handle_t *sh, int consume_base)
+{
+       assert(sh != NULL);
+       sh->expand_consume_base = consume_base;
+}
+
 void sepol_handle_destroy(sepol_handle_t * sh)
 {
        free(sh);
Index: policycoreutils/semodule_expand/semodule_expand.c
===================================================================
--- policycoreutils/semodule_expand/semodule_expand.c   (revision 2774)
+++ policycoreutils/semodule_expand/semodule_expand.c   (working copy)
@@ -44,6 +44,7 @@
        sepol_policydb_t *out, *p;
        FILE *fp, *outfile;
        int check_assertions = 1;
+       sepol_handle_t *handle;
 
        while ((ch = getopt(argc, argv, "c:Vva")) != EOF) {
                switch (ch) {
@@ -105,6 +106,10 @@
        basename = argv[optind++];
        outname = argv[optind];
 
+       handle = sepol_handle_create();
+       if (!handle)
+               exit(1);
+
        if (sepol_policy_file_create(&pf)) {
                fprintf(stderr, "%s:  Out of memory\n", argv[0]);
                exit(1);
@@ -132,7 +137,7 @@
 
        /* linking the base takes care of enabling optional avrules */
        p = sepol_module_package_get_policy(base);
-       if (sepol_link_modules(NULL, p, NULL, 0, 0)) {
+       if (sepol_link_modules(handle, p, NULL, 0, 0)) {
                fprintf(stderr, "%s:  Error while enabling avrules\n", argv[0]);
                exit(1);
        }
@@ -144,7 +149,9 @@
                exit(1);
        }
 
-       if (sepol_expand_module(NULL, p, out, verbose, check_assertions)) {
+       sepol_set_expand_consume_base(handle, 1);
+
+       if (sepol_expand_module(handle, p, out, verbose, check_assertions)) {
                fprintf(stderr, "%s:  Error while expanding policy\n", argv[0]);
                exit(1);
        }
@@ -174,6 +181,7 @@
                exit(1);
        }
        fclose(outfile);
+       sepol_handle_destroy(handle);
        sepol_policydb_free(out);
        sepol_policy_file_free(pf);
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
