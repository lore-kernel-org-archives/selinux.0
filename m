From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 11/18] libselinux: label_file: add accessors for the pcre extra data
Date: Fri, 31 Aug 2012 10:49:47 -0700
Message-Id: <1346435394-1954-11-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When we use an mmap backed version of data we need to declare the pcre
extra data since we are only given a point to the data->buffer.  Since
sometimes the spec will hold a pointer to the extra data and sometimes
we want to declare it on the stack I introduce and use an accessor for
the extra data instead of using it directly.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 4 ++--
 libselinux/src/label_file.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0fba6aa..0f4f9a5 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -490,9 +490,9 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 			if (compile_regex(data, spec, NULL) < 0)
 				goto finish;
 			if (spec->stem_id == -1)
-				rc = pcre_exec(spec->regex, spec->sd, key, strlen(key), 0, 0, NULL, 0);
+				rc = pcre_exec(spec->regex, get_pcre_extra(spec), key, strlen(key), 0, 0, NULL, 0);
 			else
-				rc = pcre_exec(spec->regex, spec->sd, buf, strlen(buf), 0, 0, NULL, 0);
+				rc = pcre_exec(spec->regex, get_pcre_extra(spec), buf, strlen(buf), 0, 0, NULL, 0);
 
 			if (rc == 0) {
 				spec->matches++;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index c6c8ad3..8c213d2 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -42,6 +42,11 @@ struct saved_data {
 	int alloc_stems;
 };
 
+static inline pcre_extra *get_pcre_extra(struct spec *spec)
+{
+	return spec->sd;
+}
+
 static inline mode_t string_to_mode(char *mode)
 {
 	size_t len;
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
