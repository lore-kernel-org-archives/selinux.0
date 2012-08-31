From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 17/18] libselinux: utils: new file context regex compiler
Date: Fri, 31 Aug 2012 10:49:53 -0700
Message-Id: <1346435394-1954-17-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a new 'compiler' which tranforms the file context database into
a binary format.  This binary format may be mmap'd in later removing the
need to compile the regular expression at run time.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/utils/.gitignore           |   1 +
 libselinux/utils/Makefile             |   1 +
 libselinux/utils/sefcontext_compile.c | 338 ++++++++++++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 libselinux/utils/sefcontext_compile.c

diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index 8b9294d..060eaab 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -13,6 +13,7 @@ getsebool
 getseuser
 matchpathcon
 policyvers
+sefcontext_compile
 selinux_check_securetty_context
 selinuxenabled
 selinuxexeccon
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 5f3e047..f469924 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -28,6 +28,7 @@ LDLIBS += -L../src -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
+sefcontext_compile: LDLIBS += -lpcre
 
 ifeq ($(DISABLE_AVC),y)
 	UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
new file mode 100644
index 0000000..2393763
--- /dev/null
+++ b/libselinux/utils/sefcontext_compile.c
@@ -0,0 +1,338 @@
+#include <ctype.h>
+#include <errno.h>
+#include <pcre.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <linux/limits.h>
+
+#include "../src/label_file.h"
+
+static int process_file(struct saved_data *data, const char *filename)
+{
+	struct spec *spec;
+	unsigned int line_num;
+	char *line_buf = NULL;
+	size_t line_len;
+	ssize_t len;
+	FILE *context_file;
+
+	context_file = fopen(filename, "r");
+	if (!context_file)
+		return -1;
+
+	line_num = 0;
+	while ((len = getline(&line_buf, &line_len, context_file)) != -1) {
+		char *context;
+		char *mode;
+		char *regex;
+		char *cp, *anchored_regex;
+		char *buf_p;
+		pcre *re;
+		pcre_extra *sd;
+		const char *err;
+		int items, erroff, rc;
+		size_t regex_len;
+		int32_t stem_id;
+
+		len = strlen(line_buf);
+		if (line_buf[len - 1] == '\n')
+			line_buf[len - 1] = 0;
+		buf_p = line_buf;
+		while (isspace(*buf_p))
+			buf_p++;
+		/* Skip comment lines and empty lines. */
+		if (*buf_p == '#' || *buf_p == 0)
+			continue;
+
+		items = sscanf(line_buf, "%ms %ms %ms", &regex, &mode, &context);
+		if (items < 2 || items > 3) {
+			fprintf(stderr, "invalid entry, skipping:%s", line_buf);
+			continue;
+		}
+
+		if (items == 2) {
+			context = mode;
+			mode = NULL;
+		}
+
+		rc = grow_specs(data);
+		if (rc)
+			return rc;
+
+		spec = &data->spec_arr[data->nspec];
+
+		spec->lr.ctx_raw = context;
+		spec->mode = string_to_mode(mode);
+		if (spec->mode == -1) {
+			fprintf(stderr, "%s: line %d has invalid file type %s\n",
+				regex, line_num + 1, mode);
+			spec->mode = 0;
+		}
+		free(mode);
+		spec->regex_str = regex;
+
+		stem_id = find_stem_from_spec(data, regex);
+		spec->stem_id = stem_id;
+		/* skip past the fixed stem part */
+		if (stem_id != -1)
+			regex += data->stem_arr[stem_id].len;
+
+		regex_len = strlen(regex);
+		cp = anchored_regex = malloc(regex_len + 3);
+		if (!cp)
+			return -1;
+
+		*cp++ = '^';
+		memcpy(cp, regex, regex_len); 
+		cp += regex_len;
+		*cp++ = '$';
+		*cp = '\0';
+
+		spec_hasMetaChars(spec);
+
+		re = pcre_compile(anchored_regex, 0, &err, &erroff, NULL);
+		if (!re) {
+			fprintf(stderr, "PCRE compilation failed for %s at offset %d: %s\n", anchored_regex, erroff, err);
+			return -1;
+		}
+		spec->regex = re;
+
+		sd = pcre_study(re, 0, &err);
+		if (!sd) {
+			fprintf(stderr, "PCRE study failed for %s: %s\n", anchored_regex, err);
+			return -1;
+		}
+		free(anchored_regex);
+		spec->sd = sd;
+
+		line_num++;
+		data->nspec++;
+	}
+
+	free(line_buf);
+	fclose(context_file);
+
+	return 0;
+}
+
+/*
+ * File Format
+ *
+ * u32 - magic number
+ * u32 - number of stems
+ * ** Stems
+ * 	u32  - length of stem EXCLUDING nul
+ * 	char - stem char array INCLUDING nul
+ * u32 - number of regexs
+ * ** Regexes
+ * 	u32  - length of upcoming context INCLUDING nul
+ * 	char - char array of the raw context
+ *	u32  - length of the upcoming regex_str
+ *	char - char array of the original regex string including the stem.
+ *	mode_t - mode bits
+ *	s32  - stemid associated with the regex
+ *	u32  - spec has meta characters
+ *	u32  - data length of the pcre regex
+ *	char - a bufer holding the raw pcre regex info
+ *	u32  - data length of the pcre regex study daya
+ *	char - a buffer holding the raw pcre regex study data
+ */
+static int write_binary_file(struct saved_data *data, char *filename)
+{
+	struct spec *specs = data->spec_arr;
+	FILE *bin_file;
+	size_t len;
+	uint32_t magic = 0xdeadbeef;
+	uint32_t section_len;
+	uint32_t i;
+
+	bin_file = fopen(filename, "w");
+	if (!bin_file) {
+		perror("fopen output_file");
+		exit(EXIT_FAILURE);
+	}
+
+	/* write some magic number or version or soemthing FIXME "*/
+	len = fwrite(&magic, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* write the number of stems coming */
+	section_len = data->num_stems;
+	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	for (i = 0; i < section_len; i++) {
+		char *stem = data->stem_arr[i].buf;
+		uint32_t stem_len = data->stem_arr[i].len;
+		
+		/* write the strlen (aka no nul) */
+		len = fwrite(&stem_len, sizeof(uint32_t), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* include the nul in the file */
+		stem_len += 1;
+		len = fwrite(stem, sizeof(char), stem_len, bin_file);
+		if (len != stem_len)
+			return -1;
+	}
+
+	/* write the number of regexes coming */
+	section_len = data->nspec;
+	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	for (i = 0; i < section_len; i++) {
+		char *context = specs[i].lr.ctx_raw;
+		char *regex_str = specs[i].regex_str;
+		mode_t mode = specs[i].mode;
+		int32_t stem_id = specs[i].stem_id;
+		pcre *re = specs[i].regex;
+		pcre_extra *sd = get_pcre_extra(&specs[i]);
+		uint32_t to_write;
+		size_t size;
+		int rc;
+
+		/* length of the context string (including nul) */
+		to_write = strlen(context) + 1;
+		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* original context strin (including nul) */
+		len = fwrite(context, sizeof(char), to_write, bin_file);
+		if (len != to_write)
+			return -1;
+
+		/* length of the original regex string (including nul) */
+		to_write = strlen(regex_str) + 1;
+		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* original regex string */
+		len = fwrite(regex_str, sizeof(char), to_write, bin_file);
+		if (len != to_write)
+			return -1;
+
+		/* binary F_MODE bits */
+		len = fwrite(&mode, sizeof(mode), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* stem for this regex (could be -1) */
+		len = fwrite(&stem_id, sizeof(stem_id), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* does this spec have a metaChar? */
+		to_write = specs[i].hasMetaChars;
+		len = fwrite(&to_write, sizeof(to_write), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* determine the size of the pcre data in bytes */
+		rc = pcre_fullinfo(re, NULL, PCRE_INFO_SIZE, &size);
+		if (rc < 0)
+			return -1;
+
+		/* write the number of bytes in the pcre data */
+		to_write = size;
+		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* write the actual pcre data as a char array */
+		len = fwrite(re, 1, to_write, bin_file);
+		if (len != to_write)
+			return -1;
+
+		/* determine the size of the pcre study info */
+		rc = pcre_fullinfo(re, sd, PCRE_INFO_STUDYSIZE, &size);
+		if (rc < 0)
+			return -1;
+
+		/* write the number of bytes in the pcre study data */
+		to_write = size;
+		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
+		if (len != 1)
+			return -1;
+
+		/* write the actual pcre study data as a char array */
+		len = fwrite(sd->study_data, 1, to_write, bin_file);
+		if (len != to_write)
+			return -1;
+	}
+
+	fclose(bin_file);
+
+	return 0;
+}
+
+static int free_specs(struct saved_data *data)
+{
+	struct spec *specs = data->spec_arr;
+	unsigned int num_entries = data->nspec;
+	unsigned int i;
+
+	for (i = 0; i < num_entries; i++) {
+		free(specs[i].lr.ctx_raw);
+		free(specs[i].lr.ctx_trans);
+		free(specs[i].regex_str);
+		pcre_free(specs[i].regex);
+		pcre_free_study(specs[i].sd);
+	}
+	free(specs);
+
+	num_entries = data->num_stems;
+	for (i = 0; i < num_entries; i++) {
+		free(data->stem_arr[i].buf);
+	}
+	free(data->stem_arr);
+
+	memset(data, 0, sizeof(*data));
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct saved_data data;
+	const char *path;
+	char stack_path[PATH_MAX + 1];
+	int rc;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s input_file\n", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&data, 0, sizeof(data));
+
+	path = argv[1];
+
+	rc = process_file(&data, path);
+	if (rc < 0)
+		return rc;
+
+	rc = sort_specs(&data);
+	if (rc)
+		return rc;
+
+	rc = snprintf(stack_path, sizeof(stack_path), "%s.bin", path);
+	if (rc < 0 || rc >= sizeof(stack_path))
+		return rc;
+	rc = write_binary_file(&data, stack_path);
+	if (rc < 0)
+		return rc;
+
+	rc = free_specs(&data);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
