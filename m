Message-ID: <4A028CC1.2070109@ak.jp.nec.com>
Date: Thu, 07 May 2009 16:24:49 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, Andy Warner <warner@rubix.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com> <49D018A3.2090304@ak.jp.nec.com> <49D08105.2090607@ak.jp.nec.com> <49EE5FE3.7010601@tycho.nsa.gov> <49EE9619.6090602@ak.jp.nec.com> <49FA80A2.7060804@tycho.nsa.gov> <4A023AC0.9080207@ak.jp.nec.com>
In-Reply-To: <4A023AC0.9080207@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010504020205090605030806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010504020205090605030806
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

KaiGai Kohei wrote:
> Please wait for a while.
> 
> As I noted before, the selabel patch tries to solve two matters.
>  - The default label for db_database class.
>  - The default label for temporary schame.
> 
> If we can have db_schema_temp class, the only remaining matter is the default
> in db_database class. It can be solved using a file which store a default label
> for SE-PostgreSQL's db_database objects, as if run_init uses initrc_context.
> 
> It makes sense for me, and clear its behavior from the viewpoint of the analogy.

I would like to reserve /etc/selinux/$POLICYTYPE/context/sepgsql_context to
store the default security context for db_database object in SE-PostgreSQL.
(I guess RUBIX can store its default in rubix_context in same way.)

The attached patch adds a new API: selinux_sepgsql_context_path() which
returns the pathname of the configuration file.

Please apply this one, instead of the patch for selabel_lookup().

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010504020205090605030806
Content-Type: text/x-patch;
 name="libselinux-selinux_sepgsql_context_path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-selinux_sepgsql_context_path.patch"

[PATCH] add selinux_sepgsql_context_path()

 The /etc/selinux/$POLICYTYPE/context/sepgsql_context can store a default
 security context of db_database class object in SE-PostgreSQL.
 This patch add a new API: selinux_sepgsql_context_path() which returns
 a pathname of the configuration file.

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 libselinux/include/selinux/selinux.h |    1 +
 libselinux/src/file_path_suffixes.h  |    1 +
 libselinux/src/selinux_config.c      |    9 ++++++++-
 libselinux/src/selinux_internal.h    |    1 +
 4 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 0a0b195..8adbbcf 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -492,6 +492,7 @@ extern const char *selinux_users_path(void);
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
 extern const char *selinux_colors_path(void);
+extern const char *selinux_sepgsql_context_path(void);
 extern const char *selinux_netfilter_context_path(void);
 extern const char *selinux_path(void);
 
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index 8d207c9..b4e13d2 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -20,3 +20,4 @@ S_(BINPOLICY, "/policy/policy")
     S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
     S_(X_CONTEXTS, "/contexts/x_contexts")
     S_(COLORS, "/secolor.conf")
+    S_(SEPGSQL_CONTEXT, "/contexts/sepgsql_context")
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index dec5426..620a2ce 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -40,7 +40,8 @@
 #define SECURETTY_TYPES   18
 #define X_CONTEXTS        19
 #define COLORS            20
-#define NEL               21
+#define SEPGSQL_CONTEXT   21
+#define NEL               22
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -391,3 +392,9 @@ const char *selinux_x_context_path()
 }
 
 hidden_def(selinux_x_context_path)
+
+const char *selinux_sepgsql_context_path()
+{
+	return get_path(SEPGSQL_CONTEXT);
+}
+hidden_def(selinux_sepgsql_context_path)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 24c1396..2d2beb8 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -77,6 +77,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(selinux_usersconf_path);
 hidden_proto(selinux_translations_path);
 hidden_proto(selinux_colors_path);
+hidden_proto(selinux_sepgsql_context_path);
 hidden_proto(selinux_getenforcemode);
 hidden_proto(selinux_getpolicytype);
 hidden_proto(selinux_raw_to_trans_context);

--------------010504020205090605030806--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
