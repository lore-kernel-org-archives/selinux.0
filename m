Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BHr9T6031356
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 13:53:10 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] secilc: Add options to control the expansion of attributes
Date: Tue, 11 Apr 2017 13:53:43 -0400
Message-Id: <1491933223-18277-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Added "-G, --expand_generated" option to specify that all automatically
generated attributes should be expanded and removed.

Added "-X, --expand_size <SIZE>" option to specify which attributes
are expanded when building a kernel policy. All attributes that have
less types assigned to it than SIZE will be expanded when writing AV
rules.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 secilc/secil2conf.c |  2 ++
 secilc/secilc.8.xml | 10 ++++++++++
 secilc/secilc.c     | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index 5d8fe87..4e97dd6 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -124,6 +124,8 @@ int main(int argc, char *argv[])
 	cil_db_init(&db);
 	cil_set_preserve_tunables(db, preserve_tunables);
 	cil_set_mls(db, mls);
+	cil_set_attrs_expand_generated(db, 0);
+	cil_set_attrs_expand_size(db, 0);
 
 	for (i = optind; i < argc; i++) {
 		file = fopen(argv[i], "r");
diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
index 9e2670b..5d52e59 100644
--- a/secilc/secilc.8.xml
+++ b/secilc/secilc.8.xml
@@ -81,6 +81,16 @@
          </varlistentry>
 
          <varlistentry>
+            <term><option>-G, --expand_generated</option></term>
+            <listitem><para>Expand and remove auto-generated attributes</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-X, --attrs_size &lt;size></option></term>
+            <listitem><para>Expand type attributes with fewer than <emphasis role="bold">&lt;SIZE></emphasis> members.</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
             <term><option>-v, --verbose</option></term>
             <listitem><para>Increment verbosity level.</para></listitem>
          </varlistentry>
diff --git a/secilc/secilc.c b/secilc/secilc.c
index f4ecbee..894f174 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -64,6 +64,9 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("  -D, --disable-dontaudit        do not add dontaudit rules to the binary policy\n");
 	printf("  -P, --preserve-tunables        treat tunables as booleans\n");
 	printf("  -N, --disable-neverallow       do not check neverallow rules\n");
+	printf("  -G, --expand_generated         Expand and remove auto-generated attributes\n");
+	printf("  -X, --expand_size <SIZE>       Expand type attributes with fewer than <SIZE>\n");
+	printf("                                 members.\n");
 	printf("  -v, --verbose                  increment verbosity level\n");
 	printf("  -h, --help                     display usage information\n");
 	exit(1);
@@ -90,6 +93,8 @@ int main(int argc, char *argv[])
 	int preserve_tunables = 0;
 	int handle_unknown = -1;
 	int policyvers = POLICYDB_VERSION_MAX;
+	int attrs_expand_generated = 0;
+	int attrs_expand_size = -1;
 	int opt_char;
 	int opt_index = 0;
 	char *fc_buf = NULL;
@@ -107,12 +112,14 @@ int main(int argc, char *argv[])
 		{"preserve-tunables", no_argument, 0, 'P'},
 		{"output", required_argument, 0, 'o'},
 		{"filecontexts", required_argument, 0, 'f'},
+		{"expand_generated", no_argument, 0, 'G'},
+		{"expand_size", required_argument, 0, 'X'},
 		{0, 0, 0, 0}
 	};
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDNc:", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDNc:GX:", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -180,6 +187,24 @@ int main(int argc, char *argv[])
 			case 'f':
 				filecontexts = strdup(optarg);
 				break;
+			case 'G':
+				attrs_expand_generated = 1;
+				break;
+			case 'X': {
+				char *endptr = NULL;
+				errno = 0;
+				attrs_expand_size = strtol(optarg, &endptr, 10);
+				if (errno != 0 || endptr == optarg || *endptr != '\0') {
+					fprintf(stderr, "Bad attribute expand size: %s\n", optarg);
+					usage(argv[0]);
+				}
+
+				if (attrs_expand_size < 0) {
+					fprintf(stderr, "Attribute expand size must be > 0\n");
+					usage(argv[0]);
+				}
+				break;
+			}
 			case 'h':
 				usage(argv[0]);
 			case '?':
@@ -210,6 +235,10 @@ int main(int argc, char *argv[])
 	cil_set_mls(db, mls);
 	cil_set_target_platform(db, target);
 	cil_set_policy_version(db, policyvers);
+	cil_set_attrs_expand_generated(db, attrs_expand_generated);
+	if (attrs_expand_size >= 0) {
+		cil_set_attrs_expand_size(db, (unsigned)attrs_expand_size);
+	}
 
 	for (i = optind; i < argc; i++) {
 		file = fopen(argv[i], "r");
-- 
2.7.4
