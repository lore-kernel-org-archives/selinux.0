Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SG5Xj0004621
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 12:05:35 -0400
Received: by mail-lf0-f50.google.com with SMTP id y6so57669372lff.1
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 09:05:17 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Cc: jdanis@google.com, Janis Danisevskis <jdanis@android.com>
Subject: [PATCH] libselinux: android: fix lax service context lookup
Date: Wed, 28 Sep 2016 17:04:50 +0100
Message-Id: <1475078690-42486-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We use the same lookup function for service contexts
that we use for property contexts. However, property
contexts are namespace based and only compare the
prefix. This may lead to service associations with
a wrong label.

This patch introduces a stricter lookup function for
services contexts. Now the service name must match
the key of the service label exactly.

Signed-off-by: Janis Danisevskis <jdanis@android.com>
---
 libselinux/include/selinux/label.h      |  2 ++
 libselinux/src/label.c                  |  1 +
 libselinux/src/label_android_property.c | 50 +++++++++++++++++++++++++++++++++
 libselinux/src/label_internal.h         |  3 ++
 4 files changed, 56 insertions(+)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index f0b1e10..277287e 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -34,6 +34,8 @@ struct selabel_handle;
 #define SELABEL_CTX_DB		3
 /* Android property service contexts */
 #define SELABEL_CTX_ANDROID_PROP 4
+/* Android service contexts */
+#define SELABEL_CTX_ANDROID_SERVICE 5
 
 /*
  * Available options
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 96a4ff1..eb0e766 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -45,6 +45,7 @@ static selabel_initfunc initfuncs[] = {
 	CONFIG_X_BACKEND(selabel_x_init),
 	CONFIG_DB_BACKEND(selabel_db_init),
 	&selabel_property_init,
+	&selabel_service_init,
 };
 
 static void selabel_subs_fini(struct selabel_sub *ptr)
diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index 290b438..69d6afd 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -279,6 +279,38 @@ finish:
 	return ret;
 }
 
+static struct selabel_lookup_rec *service_lookup(struct selabel_handle *rec,
+		const char *key, int __attribute__((unused)) type)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	spec_t *spec_arr = data->spec_arr;
+	unsigned int i;
+	struct selabel_lookup_rec *ret = NULL;
+
+	if (!data->nspec) {
+		errno = ENOENT;
+		goto finish;
+	}
+
+	for (i = 0; i < data->nspec; i++) {
+		if (strcmp(spec_arr[i].property_key, key) == 0)
+			break;
+		if (strcmp(spec_arr[i].property_key, "*") == 0)
+			break;
+	}
+
+	if (i >= data->nspec) {
+		/* No matching specification. */
+		errno = ENOENT;
+		goto finish;
+	}
+
+	ret = &spec_arr[i].lr;
+
+finish:
+	return ret;
+}
+
 static void stats(struct selabel_handle __attribute__((unused)) *rec)
 {
 	selinux_log(SELINUX_WARNING, "'stats' functionality not implemented.\n");
@@ -302,3 +334,21 @@ int selabel_property_init(struct selabel_handle *rec,
 
 	return init(rec, opts, nopts);
 }
+
+int selabel_service_init(struct selabel_handle *rec,
+		const struct selinux_opt *opts, unsigned nopts)
+{
+	struct saved_data *data;
+
+	data = (struct saved_data *)malloc(sizeof(*data));
+	if (!data)
+		return -1;
+	memset(data, 0, sizeof(*data));
+
+	rec->data = data;
+	rec->func_close = &closef;
+	rec->func_stats = &stats;
+	rec->func_lookup = &service_lookup;
+
+	return init(rec, opts, nopts);
+}
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 7c55531..6a9481a 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -39,6 +39,9 @@ int selabel_db_init(struct selabel_handle *rec,
 int selabel_property_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
 			    unsigned nopts) hidden;
+int selabel_service_init(struct selabel_handle *rec,
+			    const struct selinux_opt *opts,
+			    unsigned nopts) hidden;
 
 /*
  * Labeling internal structures
-- 
2.8.0.rc3.226.g39d4020
