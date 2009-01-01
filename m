Message-ID: <495C07C0.4010704@tycho.nsa.gov>
Date: Wed, 31 Dec 2008 19:01:04 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Add color translation support to mcstransd
References: <4927839F.4070805@tycho.nsa.gov>	 <AD1BDA2B-D7CF-48AC-846E-54DC795B3C08@nall.com>	 <492AFFAD.5070805@tycho.nsa.gov>	 <cadfc0e40812051416v15070ddag132ff548d535052c@mail.gmail.com>	 <494187BF.2090301@tycho.nsa.gov> <cadfc0e40812240823x5c10c135p59b229fad22c7fb3@mail.gmail.com>
In-Reply-To: <cadfc0e40812240823x5c10c135p59b229fad22c7fb3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> On Thu, Dec 11, 2008 at 3:35 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>   
>> Xavier Toth wrote:
>>     
>>> Sorry to be pedantic but is there a reference implementation or will
>>> the mcstrans developer (Joe) have to develop it?
>>>
>>> Ted
>>>
>>>       
>> Also here is a preliminary libselinux patch.
>>
>>
>> --
>> Eamon Walsh <ewalsh@tycho.nsa.gov>
>> National Security Agency
>>
>>
>>     
>
> This patch could be upstreamed now because even if the installed
> mcstrand doesn't support color a call to selinux_raw_context_to_color
> will simply retrun an error, right?
>
> Ted
>
>   

Yes, the function will return error in that case.

Without objection, I will go ahead and upstream the
selinux_raw_context_to_color() and selinux_colors_path() functions. 
Patch below.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 libselinux/include/selinux/selinux.h |    9 +++++
 libselinux/src/file_path_suffixes.h  |    1 +
 libselinux/src/selinux_config.c      |   10 +++++-
 libselinux/src/selinux_internal.h    |    1 +
 libselinux/src/setrans_client.c      |   61 ++++++++++++++++++++++++++++++++++
 libselinux/src/setrans_internal.h    |    1 +
 6 files changed, 82 insertions(+), 1 deletions(-)


diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 3bfc0c8..fab083e 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -467,6 +467,7 @@ extern const char *selinux_customizable_types_path(void);
 extern const char *selinux_users_path(void);
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
+extern const char *selinux_colors_path(void);
 extern const char *selinux_netfilter_context_path(void);
 extern const char *selinux_path(void);
 
@@ -504,6 +505,14 @@ extern int selinux_trans_to_raw_context(security_context_t trans,
 extern int selinux_raw_to_trans_context(security_context_t raw,
 					security_context_t * transp);
 
+/* Perform context translation between security contexts
+   and display colors.  Returns a space-separated list of ten
+   ten hex RGB triples prefixed by hash marks, e.g. "#ff0000".
+   Caller must free the resulting string via free.
+   Returns -1 upon an error or 0 otherwise. */
+extern int selinux_raw_context_to_color(security_context_t raw,
+					char **color_str);
+
 /* Get the SELinux username and level to use for a given Linux username. 
    These values may then be passed into the get_ordered_context_list*
    and get_default_context* functions to obtain a context for the user.
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index bea5c40..8d207c9 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -19,3 +19,4 @@ S_(BINPOLICY, "/policy/policy")
     S_(FILE_CONTEXTS_HOMEDIR, "/contexts/files/file_contexts.homedirs")
     S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
     S_(X_CONTEXTS, "/contexts/x_contexts")
+    S_(COLORS, "/secolor.conf")
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 7dbbb47..dec5426 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -39,7 +39,8 @@
 #define FILE_CONTEXTS_LOCAL 17
 #define SECURETTY_TYPES   18
 #define X_CONTEXTS        19
-#define NEL               20
+#define COLORS            20
+#define NEL               21
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -356,6 +357,13 @@ const char *selinux_translations_path()
 
 hidden_def(selinux_translations_path)
 
+const char *selinux_colors_path()
+{
+	return get_path(COLORS);
+}
+
+hidden_def(selinux_colors_path)
+
 const char *selinux_netfilter_context_path()
 {
 	return get_path(NETFILTER_CONTEXTS);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index eaf1767..0eeca71 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -77,6 +77,7 @@ hidden_proto(selinux_getenforcemode);
 hidden_proto(selinux_getpolicytype);
 hidden_proto(selinux_raw_to_trans_context);
 hidden_proto(selinux_trans_to_raw_context);
+    hidden_proto(selinux_raw_context_to_color);
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index a02f407..500225e 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -30,6 +30,8 @@ static __thread security_context_t prev_t2r_trans = NULL;
 static __thread security_context_t prev_t2r_raw = NULL;
 static __thread security_context_t prev_r2t_trans = NULL;
 static __thread security_context_t prev_r2t_raw = NULL;
+static __thread char *prev_r2c_trans = NULL;
+static __thread security_context_t prev_r2c_raw = NULL;
 
 /*
  * setransd_open
@@ -212,12 +214,38 @@ static int trans_to_raw_context(char *trans, char **rawp)
 	return ret;
 }
 
+static int raw_context_to_color(char *raw, char **colors)
+{
+	int ret;
+	int32_t ret_val;
+	int fd;
+
+	fd = setransd_open();
+	if (fd < 0)
+		return fd;
+
+	ret = send_request(fd, RAW_CONTEXT_TO_COLOR, raw, NULL);
+	if (ret)
+		goto out;
+
+	ret = receive_response(fd, RAW_CONTEXT_TO_COLOR, colors, &ret_val);
+	if (ret)
+		goto out;
+
+	ret = ret_val;
+out:
+	close(fd);
+	return ret;
+}
+
 hidden void fini_context_translations(void)
 {
 	free(prev_r2t_trans);
 	free(prev_r2t_raw);
 	free(prev_t2r_trans);
 	free(prev_t2r_raw);
+	free(prev_r2c_trans);
+	free(prev_r2c_raw);
 }
 
 hidden int init_context_translations(void)
@@ -303,6 +331,39 @@ int selinux_raw_to_trans_context(security_context_t raw,
 }
 
 hidden_def(selinux_raw_to_trans_context)
+
+int selinux_raw_context_to_color(security_context_t raw, char **transp)
+{
+	if (!raw) {
+		*transp = NULL;
+		return -1;
+	}
+
+	if (prev_r2c_raw && strcmp(prev_r2c_raw, raw) == 0) {
+		*transp = strdup(prev_r2c_trans);
+	} else {
+		free(prev_r2c_raw);
+		prev_r2c_raw = NULL;
+		free(prev_r2c_trans);
+		prev_r2c_trans = NULL;
+		if (raw_context_to_color(raw, transp))
+			return -1;
+		if (*transp) {
+			prev_r2c_raw = strdup(raw);
+			if (!prev_r2c_raw)
+				goto out;
+			prev_r2c_trans = strdup(*transp);
+			if (!prev_r2c_trans) {
+				free(prev_r2c_raw);
+				prev_r2c_raw = NULL;
+			}
+		}
+	}
+      out:
+	return *transp ? 0 : -1;
+}
+
+hidden_def(selinux_raw_context_to_color)
 #else /*DISABLE_SETRANS*/
 
 hidden void fini_context_translations(void)
diff --git a/libselinux/src/setrans_internal.h b/libselinux/src/setrans_internal.h
index 4e04b54..f6e25b1 100644
--- a/libselinux/src/setrans_internal.h
+++ b/libselinux/src/setrans_internal.h
@@ -4,6 +4,7 @@
 
 #define RAW_TO_TRANS_CONTEXT		2
 #define TRANS_TO_RAW_CONTEXT		3
+#define RAW_CONTEXT_TO_COLOR		4
 #define MAX_DATA_BUF			8192
 
 extern int init_context_translations(void);



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
