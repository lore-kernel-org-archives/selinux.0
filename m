Message-ID: <36282A1733C57546BE392885C0618592D3A092@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   "Daniel J Walsh (E-mail)"
	 <dwalsh@redhat.com>
Cc: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: [PATCH] libsetrans
Date: Mon, 24 Oct 2005 16:55:11 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5D8DD.3972BD00"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5D8DD.3972BD00
Content-Type: text/plain;
	charset="iso-8859-1"


The following proposed patch to libsetrans incorporates the following
changes:

- Make libsetrans generic by creating a setrans config file
- Add translation config file for MLS policy
- Fix to handle translation for same level range string without separate
definition (e.g. SystemHigh-SystemHigh)
- move libsetrans disable option from translation config file
(mcs.conf/mls.conf) to setrans config file
- Some comment updates for mcs.conf

-Chad


------_=_NextPart_000_01C5D8DD.3972BD00
Content-Type: application/octet-stream;
	name="libsetrans.spec.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsetrans.spec.patch"

--- libsetrans_ori.spec	2005-10-24 11:05:31.000000000 -0500=0A=
+++ libsetrans.spec	2005-10-24 15:30:24.730920732 -0500=0A=
@@ -7,9 +7,12 @@=0A=
 Group: System Environment/Libraries=0A=
 Source: %{name}-%{version}.tgz=0A=
 Source1: mcs.conf=0A=
+Source2: mls.conf=0A=
+Source3: setrans=0A=
 BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot=0A=
 BuildRequires: libselinux-devel >=3D %{libselinuxver}=0A=
 Requires: libselinux >=3D %{libselinuxver}=0A=
+Patch: libsetrans-0.1.7-mls.patch=0A=
 =0A=
 %description=0A=
 Security-enhanced Linux is a feature of the Linux=C2=AE kernel and a =
number=0A=
@@ -27,6 +30,7 @@=0A=
 =0A=
 %prep=0A=
 %setup -q=0A=
+%patch0 -p1=0A=
 =0A=
 %build=0A=
 make CFLAGS=3D"-g %{optflags}"=0A=
@@ -37,6 +41,8 @@=0A=
 mkdir -p ${RPM_BUILD_ROOT}/%{_libdir} =0A=
 make DESTDIR=3D"${RPM_BUILD_ROOT}" =
LIBDIR=3D"${RPM_BUILD_ROOT}%{_libdir}" =
SHLIBDIR=3D"${RPM_BUILD_ROOT}/%{_lib}" install=0A=
 install -D -m 644 %{SOURCE1} ${RPM_BUILD_ROOT}/etc/mcs.conf=0A=
+install -D -m 644 %{SOURCE2} ${RPM_BUILD_ROOT}/etc/mls.conf=0A=
+install -D -m 644 %{SOURCE3} =
${RPM_BUILD_ROOT}/etc/sysconfig/setrans=0A=
 rm -f ${RPM_BUILD_ROOT}%{_sbindir}/*=0A=
 rm -f ${RPM_BUILD_ROOT}%{_libdir}/*.a=0A=
 =0A=
@@ -53,6 +59,8 @@=0A=
 /%{_libdir}/libsetrans.so=0A=
 %{_bindir}/chcat=0A=
 %config(noreplace) /etc/mcs.conf=0A=
+%config(noreplace) /etc/mls.conf=0A=
+%config(noreplace) /etc/sysconfig/setrans=0A=
 %{_mandir}/man8/*=0A=
 =0A=
 %changelog=0A=

------_=_NextPart_000_01C5D8DD.3972BD00
Content-Type: application/octet-stream;
	name="libsetrans-0.1.7-mls.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsetrans-0.1.7-mls.patch"

diff -ur libsetrans-0.1.7_ori/src/setrans.c =
libsetrans-0.1.7/src/setrans.c=0A=
--- libsetrans-0.1.7_ori/src/setrans.c	2005-09-19 12:30:27.000000000 =
-0500=0A=
+++ libsetrans-0.1.7/src/setrans.c	2005-10-19 07:28:33.000000000 =
-0500=0A=
@@ -7,21 +7,22 @@=0A=
 #include <selinux/selinux.h>=0A=
 #include <selinux/context.h>=0A=
 =0A=
-#define CATEGORYFILE "/etc/mcs.conf"=0A=
+#define CONFIGFILE "/etc/sysconfig/setrans"=0A=
+#define DEFAULT_TRANSFILE "/etc/mcs.conf"=0A=
 =0A=
 /* Define data structures */=0A=
-typedef struct selevel {=0A=
+typedef struct selabel {=0A=
 	char* name;=0A=
 	char* sename;=0A=
-} selevel_t;=0A=
+} selabel_t;=0A=
 =0A=
-/* catlist is a simple linked list of selevels extracted from the =
CATEGORYFILE */=0A=
-typedef struct cat {=0A=
-	struct cat *next;=0A=
-	selevel_t level;=0A=
-} cat_t;=0A=
+/* labellist is a simple linked list of selabels extracted from the =
translation file */=0A=
+typedef struct labels {=0A=
+	struct labels *next;=0A=
+	selabel_t label;=0A=
+} labels_t;=0A=
 =0A=
-static cat_t *catlist=3DNULL;=0A=
+static labels_t *labellist=3DNULL;=0A=
 =0A=
 /* Remove excess white space */=0A=
 static char *strtrim(char *dest, char *source, int size) {=0A=
@@ -41,29 +42,29 @@=0A=
 }=0A=
 =0A=
 void finish_context_translations(void) {=0A=
-	cat_t *ptr=3DNULL;=0A=
-	cat_t *current=3DNULL;=0A=
-	if (!catlist) return;=0A=
-	ptr=3Dcatlist;=0A=
+	labels_t *ptr=3DNULL;=0A=
+	labels_t *current=3DNULL;=0A=
+	if (!labellist) return;=0A=
+	ptr=3Dlabellist;=0A=
 	while(ptr) {=0A=
-		if (ptr->level.name) free(ptr->level.name);=0A=
-		if (ptr->level.sename) free(ptr->level.sename);=0A=
+		if (ptr->label.name) free(ptr->label.name);=0A=
+		if (ptr->label.sename) free(ptr->label.sename);=0A=
 	        current=3Dptr;=0A=
 		ptr=3Dcurrent->next;=0A=
 		free(current);=0A=
 	}=0A=
-	catlist=3DNULL;=0A=
+	labellist=3DNULL;=0A=
 }=0A=
 =0A=
-/* Process line from CATEGORYFILE. =0A=
+/* Process line from translation file. =0A=
    Remove white space and set name do data before the "=3D" and sename =
to data=0A=
    after it */=0A=
-static int process_category(const char *buffer, cat_t **cat) {=0A=
+static int process_label(const char *buffer, labels_t **labels) {=0A=
 	char name[BUFSIZ];=0A=
 	char name1[BUFSIZ];=0A=
 	char *newbuf=3Dstrdup(buffer);=0A=
 	int namesize=3Dsizeof(name);=0A=
-	cat_t *next=3DNULL;=0A=
+	labels_t *next=3DNULL;=0A=
 	char *ptr;=0A=
 	int rc=3D0;=0A=
 	=0A=
@@ -78,14 +79,14 @@=0A=
 	if (!tok) goto err;=0A=
 	while (isspace(*tok)) tok++;=0A=
 =0A=
-	next=3D(cat_t *) calloc(1, sizeof(cat_t));=0A=
+	next=3D(labels_t *) calloc(1, sizeof(labels_t));=0A=
 	if (!next) { =0A=
 		rc=3D-1; =0A=
 		goto err;=0A=
 	}=0A=
 =0A=
-	next->level.name=3Dstrdup(name);=0A=
-	if (!next->level.name) {=0A=
+	next->label.name=3Dstrdup(name);=0A=
+	if (!next->label.name) {=0A=
 		free(next);=0A=
 		rc=3D-1; =0A=
 		goto err;=0A=
@@ -93,77 +94,151 @@=0A=
 =0A=
 	strncpy(name1,tok, BUFSIZ-1);=0A=
 	strtrim(name,name1,namesize-1);=0A=
-	next->level.sename=3Dstrdup(name);=0A=
-	if (!next->level.sename) {=0A=
-		free(next->level.name);=0A=
+	next->label.sename=3Dstrdup(name);=0A=
+	if (!next->label.sename) {=0A=
+		free(next->label.name);=0A=
 		free(next);=0A=
 		rc=3D-1; =0A=
 		goto err;=0A=
 	}=0A=
-	*cat=3Dnext;=0A=
+	*labels=3Dnext;=0A=
 	rc=3D1;=0A=
 err:		=0A=
 	free(newbuf);=0A=
 	return rc;=0A=
 }=0A=
 =0A=
-/* Look for selevel via internal name */=0A=
-static char *translate(const char *cat) {=0A=
-	cat_t *ptr=3DNULL;=0A=
-	if (catlist) =0A=
-		for (ptr=3Dcatlist->next;ptr; ptr=3Dptr->next) =0A=
-			if (strcmp(cat,ptr->level.name)=3D=3D0) {=0A=
-				if (strlen(ptr->level.sename)=3D=3D0)=0A=
+/* Search entry string and return value string from CONFIGFILE=0A=
+ * value buffer need to be allocated ahead.=0A=
+ * Return:=0A=
+ *  Success: 0=0A=
+ *  Fail : 1 */=0A=
+static int get_config_value(const char *entry, char *value)=0A=
+{=0A=
+	FILE *fp=3DNULL;=0A=
+	char *cfgbuf=3DNULL;=0A=
+	size_t size=3D0;=0A=
+	char *tok;=0A=
+	char token[BUFSIZ];=0A=
+	char token_raw[BUFSIZ];=0A=
+	int tokensize=3Dsizeof(token);=0A=
+	char *ptr;=0A=
+	int ret=3D0;=0A=
+=0A=
+	fp =3D fopen(CONFIGFILE,"r");=0A=
+	if (fp) {=0A=
+		while ( getline(&cfgbuf, &size, fp) > 0) {=0A=
+			/* ignore comment line */=0A=
+			if ( cfgbuf[0]=3D=3D'#' ) {=0A=
+				continue;=0A=
+			}=0A=
+=0A=
+			tok=3Dstrtok_r(cfgbuf,"=3D",&ptr);=0A=
+			if (!tok) {=0A=
+				ret=3D1;=0A=
+				goto exit1;=0A=
+			}=0A=
+			strncpy(token_raw,tok, BUFSIZ-1);=0A=
+			strtrim(token,token_raw,tokensize-1);=0A=
+=0A=
+			/* ignore meaningless line */=0A=
+			tok=3Dstrtok_r(NULL,"\0",&ptr);=0A=
+			if (!tok) {=0A=
+				continue;=0A=
+			}=0A=
+			while (isspace(*tok)) tok++;=0A=
+=0A=
+			if(strcasecmp(token,entry)=3D=3D0)=0A=
+			{=0A=
+				strncpy(token_raw,tok, BUFSIZ-1);=0A=
+				strtrim(token,token_raw,tokensize-1);=0A=
+				strcpy(value, token);=0A=
+				break;=0A=
+			}=0A=
+                }=0A=
+        }=0A=
+        else {=0A=
+		ret=3D1;=0A=
+		goto exit2;=0A=
+        }=0A=
+=0A=
+exit1:=0A=
+	free(cfgbuf);=0A=
+	fclose(fp);=0A=
+exit2:=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+/* Look for selabel via internal name */=0A=
+static char *translate(const char *labels) {=0A=
+	labels_t *ptr=3DNULL;=0A=
+	if (labellist) =0A=
+		for (ptr=3Dlabellist->next;ptr; ptr=3Dptr->next) =0A=
+			if (strcmp(labels,ptr->label.name)=3D=3D0) {=0A=
+				if (strlen(ptr->label.sename)=3D=3D0)=0A=
 					return NULL;=0A=
 				else=0A=
-					return strdup(ptr->level.sename); =0A=
+					return strdup(ptr->label.sename); =0A=
 			}=0A=
-	return strdup(cat);=0A=
+	return strdup(labels);=0A=
 }=0A=
 =0A=
-/* Look for selevel via external name */=0A=
+/* Look for selabel via external name */=0A=
 static char *untranslate(const char *sename) {=0A=
-	cat_t *ptr=3DNULL;=0A=
-	if (catlist) =0A=
-		for(ptr=3Dcatlist->next;ptr; ptr=3Dptr->next) =0A=
-			if (strcmp(sename,ptr->level.sename)=3D=3D0) =0A=
-				return strdup(ptr->level.name); =0A=
+	labels_t *ptr=3DNULL;=0A=
+	if (labellist) =0A=
+		for(ptr=3Dlabellist->next;ptr; ptr=3Dptr->next) =0A=
+			if (strcmp(sename,ptr->label.sename)=3D=3D0) =0A=
+				return strdup(ptr->label.name); =0A=
 	return strdup(sename);=0A=
 }=0A=
 =0A=
-/* Read in CATEGORYFILE Only runs once per process.  =0A=
+/* Read in translation file Only runs once per process.  =0A=
    Might want to change to some kind of reload eventually, for long =
running=0A=
    processes.=0A=
  */=0A=
 int init_context_translations(void) {=0A=
 	FILE *cfg=3DNULL;=0A=
-	cat_t *ptr=3DNULL;=0A=
-	cat_t *next=3DNULL;=0A=
+	labels_t *ptr=3DNULL;=0A=
+	labels_t *next=3DNULL;=0A=
 	size_t size=3D0;=0A=
 	char *buffer=3DNULL;=0A=
+	char transfile[BUFSIZ];=0A=
+	int ret;=0A=
 =0A=
 	if (is_selinux_mls_enabled() <=3D 0 ) {=0A=
 		return 1;=0A=
 	}=0A=
 =0A=
-	cfg =3D fopen(CATEGORYFILE,"r");=0A=
-	if (!cfg) return 1;=0A=
+	ret=3Dget_config_value("disable", transfile);=0A=
+	if (ret=3D=3D0) {=0A=
+		if (strcmp(transfile,"1") =3D=3D 0) {=0A=
+			return 1;=0A=
+		}=0A=
+	}=0A=
+	ret=3Dget_config_value("TRANSTABLE", transfile);=0A=
+	if (ret=3D=3D0) {=0A=
+		cfg =3D fopen(transfile,"r");=0A=
+		if (!cfg) return 1;=0A=
+	}=0A=
+	else {=0A=
+		cfg =3D fopen(DEFAULT_TRANSFILE,"r");=0A=
+		if (!cfg) return 1;=0A=
+	}=0A=
 =0A=
-	ptr=3Dcatlist=3Dcalloc(1,sizeof(cat_t));=0A=
+	ptr=3Dlabellist=3Dcalloc(1,sizeof(labels_t));=0A=
 	if (!ptr) {=0A=
 		fclose(cfg);=0A=
 		return 1;=0A=
 	}=0A=
 =0A=
 	while (getline(&buffer, &size, cfg) > 0) {=0A=
-		if(process_category(buffer, &next)) {=0A=
+		if(process_label(buffer, &next)) {=0A=
 			ptr->next=3Dnext;=0A=
 			ptr=3Dnext;=0A=
-			if ((strcasecmp(next->level.name,"disable")=3D=3D0) &&=0A=
-			    (strcmp(next->level.sename,"1") =3D=3D 0)) {=0A=
-				finish_context_translations();		=0A=
-				break;=0A=
-			}=0A=
 		}=0A=
 	}=0A=
 	if (buffer) free(buffer);=0A=
@@ -172,14 +247,14 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/* Look for selevel via external name */=0A=
+/* Look for selabel via external name */=0A=
 int translate_context( const security_context_t oldcon, =
security_context_t *rcon) {=0A=
 	const char *range=3DNULL;=0A=
 	context_t con=3Dcontext_new(oldcon);=0A=
 =0A=
 	if (! con) return -1;=0A=
 =0A=
-	if (catlist) {=0A=
+	if (labellist) {=0A=
 		range=3Dcontext_range_get(con);=0A=
 		if (range) {=0A=
 			context_range_set(con,translate(range));=0A=
@@ -190,17 +265,35 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/* Look for selevel via external name */=0A=
+/* Look for selabel via external name */=0A=
 int untranslate_context( const security_context_t oldcon, =
security_context_t *rcon) {=0A=
 	const char *range=3DNULL;=0A=
 	char *newrange=3DNULL;=0A=
+	char tmpbuf[BUFSIZ]=3D"";=0A=
+	int i=3D0;=0A=
 	context_t con=3Dcontext_new(oldcon);=0A=
 =0A=
 	if (! con) return -1;=0A=
-	if (catlist) {=0A=
+	if (labellist) {=0A=
 		range=3Dcontext_range_get(con);=0A=
-		if (range)=0A=
+		if (range) {=0A=
+			/* if ranged label */=0A=
+			if(strchr(range,'-')) {=0A=
+				while (range[i] !=3D '-') tmpbuf[i]=3Drange[i++];=0A=
+				tmpbuf[i++]=3D'\0';=0A=
+				/* Now tmpbuf has minimum level string=0A=
+				 * and &range[i] has clearance level string.=0A=
+				 * If minimum and clearance level is same =0A=
+	 			 * use single level string as range.=0A=
+	 			 * This removes the need to define same =0A=
+				 * level ranges (ex: SystemHigh-SystemHigh)=0A=
+				 * in translation table */=0A=
+				if( strcmp(tmpbuf, &range[i])=3D=3D0 ) {=0A=
+					range=3D&range[i];=0A=
+				}=0A=
+			}=0A=
 			newrange=3Duntranslate(range);=0A=
+		}=0A=
 		else =0A=
 			newrange=3Duntranslate("");=0A=
 		if (newrange) =0A=

------_=_NextPart_000_01C5D8DD.3972BD00
Content-Type: application/octet-stream;
	name="mls.conf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mls.conf"

#=0A=
# Multi-Level Security translation table for SELinux=0A=
# =0A=
# Objects can be labeled with one of 16 levels and be categorized with =
0-256 =0A=
# categories defined by the admin.=0A=
# Objects can be in more than one category at a time.=0A=
# Users can modify this table to translate the MLS labels for different =
purpose.=0A=
#=0A=
# Assumptions: using below MLS labels.=0A=
#  SystemLow=0A=
#  SystemHigh=0A=
#  Unclassified =0A=
#  Secret with compartments A and B.=0A=
# =0A=
# SystemLow and SystemHigh=0A=
s0=3DSystemLow=0A=
s15:c0.c255=3DSystemHigh=0A=
s0-s15:c0.c255=3DSystemLow-SystemHigh=0A=
=0A=
# Unclassified level=0A=
s1=3DUnclassified=0A=
=0A=
# Secret level with compartments=0A=
s2=3DSecret=0A=
s2:c0=3DSecret:A=0A=
s2:c1=3DSecret:B=0A=
s2:c0,c1=3DSecret:AB=0A=
=0A=
# ranges for Unclassified=0A=
s0-s1=3DSystemLow-Unclassified=0A=
s1-s2=3DUnclassified-Secret=0A=
s1-s15:c0.c255=3DUnclassified-SystemHigh=0A=
=0A=
# ranges for Secret with compartments=0A=
s0-s2=3DSystemLow-Secret=0A=
s0-s2:c0=3DSystemLow-Secret:A=0A=
s0-s2:c1=3DSystemLow-Secret:B=0A=
s0-s2:c0,c1=3DSystemLow-Secret:AB=0A=
s1-s2:c0=3DUnclassified-Secret:A=0A=
s1-s2:c1=3DUnclassified-Secret:B=0A=
s1-s2:c0,c1=3DUnclassified-Secret:AB=0A=
s2-s2:c0=3DSecret-Secret:A=0A=
s2-s2:c1=3DSecret-Secret:B=0A=
s2-s2:c0,c1=3DSecret-Secret:AB=0A=
s2-s15:c0.c255=3DSecret-SystemHigh=0A=
s2:c0-s2:c0,c1=3DSecret:A-Secret:AB=0A=
s2:c0-s15:c0.c255=3DSecret:A-SystemHigh=0A=
s2:c1-s2:c0,c1=3DSecret:B-Secret:AB=0A=
s2:c1-s15:c0.c255=3DSecret:B-SystemHigh=0A=
s2:c0,c1-s15:c0.c255=3DSecret:AB-SystemHigh=0A=

------_=_NextPart_000_01C5D8DD.3972BD00
Content-Type: application/octet-stream;
	name="setrans"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setrans"

# Uncomment the following to disable translation library=0A=
# disable=3D1=0A=
=0A=
# specify label translation file path=0A=
TRANSTABLE=3D/etc/mls.conf=0A=

------_=_NextPart_000_01C5D8DD.3972BD00
Content-Type: application/octet-stream;
	name="mcs.conf.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mcs.conf.patch"

--- mcs_ori.conf	2005-10-21 14:00:17.000000000 -0500=0A=
+++ mcs.conf	2005-10-24 15:02:48.000000000 -0500=0A=
@@ -1,13 +1,10 @@=0A=
 #=0A=
-# Multiple Category System translation table for SELinux=0A=
+# Multi-Category Security translation table for SELinux=0A=
 # =0A=
-# Uncomment the following to disable translation libary=0A=
-# disable=3D1=0A=
-#=0A=
-# Objects can be categorized with 0-127 categories defined by the =
admin.=0A=
-# Objects can be in more then one categories at a time.=0A=
-# Categories are stored in the system as c0-c127.  Users can use =
this=0A=
-# table to translate the categories into a more meaningfull output.=0A=
+# Objects can be categorized with 0-256 categories defined by the =
admin.=0A=
+# Objects can be in more than one category at a time.=0A=
+# Categories are stored in the system as c0-c255.  Users can use =
this=0A=
+# table to translate the categories into a more meaningful output.=0A=
 # Examples:=0A=
 # s0:c0=3DCompanyConfidential=0A=
 # s0:c1=3DPatientRecord=0A=

------_=_NextPart_000_01C5D8DD.3972BD00--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
