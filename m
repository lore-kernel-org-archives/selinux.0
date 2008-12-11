Message-ID: <494187BF.2090301@tycho.nsa.gov>
Date: Thu, 11 Dec 2008 16:35:59 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Add color translation support to mcstransd
References: <4927839F.4070805@tycho.nsa.gov>	 <AD1BDA2B-D7CF-48AC-846E-54DC795B3C08@nall.com>	 <492AFFAD.5070805@tycho.nsa.gov> <cadfc0e40812051416v15070ddag132ff548d535052c@mail.gmail.com>
In-Reply-To: <cadfc0e40812051416v15070ddag132ff548d535052c@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070309000605090005020800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070309000605090005020800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Xavier Toth wrote:
>
> Sorry to be pedantic but is there a reference implementation or will
> the mcstrans developer (Joe) have to develop it?
>
> Ted
>   

Also here is a preliminary libselinux patch.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--------------070309000605090005020800
Content-Type: text/x-patch;
 name="setrans_color.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setrans_color.patch"

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 3bfc0c8..aa0e328 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -504,6 +504,15 @@ extern int selinux_trans_to_raw_context(security_context_t trans,
 extern int selinux_raw_to_trans_context(security_context_t raw,
 					security_context_t * transp);
 
+/* Perform context translation between security contexts
+   and display colors.  Returns a space-separated list of ten
+   ten hex RGB triples prefixed by hash marks, e.g. "#ff0000".
+   Caller must free the resulting string via free.
+   Returns -1 upon an error or 0 otherwise.
+   If passed NULL, sets the returned string to NULL and returns 0. */
+extern int selinux_raw_context_to_color(security_context_t raw,
+					char **color_str);
+
 /* Get the SELinux username and level to use for a given Linux username. 
    These values may then be passed into the get_ordered_context_list*
    and get_default_context* functions to obtain a context for the user.
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
index a02f407..922f95c 100644
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
+		return 0;
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
+			*transp = strdup(raw);
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

--------------070309000605090005020800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
