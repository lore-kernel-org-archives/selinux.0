From: Kelly_Djahandari@nai.com
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14CDF@md-exchange1.na.nai.com>
To: SELinux@tycho.nsa.gov
Subject: updated setfiles on sourceforge
Date: Fri, 14 Mar 2003 13:07:10 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2EA6D.ADCEC7E0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2EA6D.ADCEC7E0
Content-Type: text/plain


I've updated setfiles.c and many policy .fc files on sourceforge. Setfiles
was changed to look for duplicate specifications in the policy .fc files and
gives a warning if found. It also sorts the specifications so that the exact
file specifications are searched before any specifications with regular
expression meta characters (.^$?*+|[({)). I've modified some of the policy
fc files to escape the '.' with a backslash (\) when a '.' is required and
not any single character. These changes help with the order problem in
file_contexts when a specification with regular expression meta characters
comes after an exact specification due to the alphabetical concatenation of
the policy fc files. As an example, files /usr/sbin/in.ftpd and
/usr/sbin/in.fingerd are labeled correctly with the changes. I've attached a
diff of setfiles.c.

Kelly Djahandari
Network Associates Laboratories


------_=_NextPart_000_01C2EA6D.ADCEC7E0
Content-Type: application/octet-stream;
	name="setfiles.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setfiles.diff"

--- /tmp/selinux/setfiles/setfiles.c	2003-03-14 14:53:52.000000000 =
-0500=0A=
+++ selinux/setfiles/setfiles.c	2003-03-14 14:21:55.000000000 -0500=0A=
@@ -108,11 +108,16 @@=0A=
 	mode_t mode;		/* mode format value */=0A=
 	security_id_t sid;      /* SID */=0A=
 	int matches;		/* number of matching pathnames */=0A=
+	int hasMetaChars; 	/* indicates whether the RE has =0A=
+				   any meta characters.  =0A=
+				   0 =3D no meta chars =0A=
+				   1 =3D has one or more meta chars */=0A=
 } spec_t;=0A=
 =0A=
 /*=0A=
- * The array of specifications, in the=0A=
+ * The array of specifications, initially in the=0A=
  * same order as in the specification file.=0A=
+ * Sorting occurs based on hasMetaChars=0A=
  */=0A=
 static spec_t *spec;=0A=
 static int nspec;=0A=
@@ -321,6 +326,97 @@=0A=
 	return i;=0A=
 }=0A=
 =0A=
+/* Used with qsort to sort specs from lowest to highest hasMetaChars =
value */=0A=
+int spec_compare(const void* specA, const void* specB)=0A=
+{=0A=
+	return(=0A=
+		((struct spec *)specB)->hasMetaChars -=0A=
+		((struct spec *)specA)->hasMetaChars=0A=
+		); =0A=
+}=0A=
+=0A=
+/*=0A=
+ * Check for duplicate specifications. If a duplicate specification is =
found =0A=
+ * and the context is the same, give a warning to the user. If a =
duplicate =0A=
+ * specification is found and the context is different, give a =
warning=0A=
+ * to the user (This could be changed to error). Return of non-zero is =
an error.=0A=
+ */=0A=
+int nodups_specs()=0A=
+{=0A=
+	int ii, jj;=0A=
+	struct spec *curr_spec;=0A=
+=0A=
+	for (ii =3D 0; ii < nspec; ii++) {=0A=
+		curr_spec =3D &spec[ii];=0A=
+		for (jj =3D ii + 1; jj < nspec; jj++) { =0A=
+				/* Check if same RE string */=0A=
+			if ((!strcmp(spec[jj].regex_str, curr_spec->regex_str))=0A=
+									&&=0A=
+				(!spec[jj].mode || !curr_spec->mode =0A=
+				 || spec[jj].mode =3D=3D curr_spec->mode)) {=0A=
+				/* Same RE string found */=0A=
+				if (strcmp(spec[jj].context, curr_spec->context)) {=0A=
+					/* If different contexts, give warning */=0A=
+					fprintf(stderr,=0A=
+					"ERROR: Multiple different specifications for %s  (%s and =
%s).\n",=0A=
+						curr_spec->regex_str, =0A=
+						spec[jj].context,=0A=
+						curr_spec->context);=0A=
+				}=0A=
+				else {=0A=
+					/* If same contexts give warning */=0A=
+					fprintf(stderr,=0A=
+					"WARNING: Multiple same specifications for %s.\n",=0A=
+						curr_spec->regex_str);=0A=
+				}=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+=0A=
+/* Determine if the regular expression specification has any meta =
characters. */=0A=
+void spec_hasMetaChars(struct spec *spec)=0A=
+{=0A=
+	char *c;=0A=
+	int len;=0A=
+	char *end;=0A=
+=0A=
+	c =3D spec->regex_str;=0A=
+	len =3D strlen(spec->regex_str);=0A=
+	end =3D c + len;=0A=
+=0A=
+	spec->hasMetaChars =3D 0; =0A=
+=0A=
+	/* Look at each character in the RE specification string for a =0A=
+	 * meta character. Return when any meta character reached. */=0A=
+	while (c !=3D end) {=0A=
+		switch(*c) {=0A=
+			case '.':=0A=
+			case '^':=0A=
+			case '$':=0A=
+			case '?':=0A=
+			case '*':=0A=
+			case '+':=0A=
+			case '|':=0A=
+			case '[':=0A=
+			case '(':=0A=
+			case '{':=0A=
+				spec->hasMetaChars =3D 1;=0A=
+				return;=0A=
+			case '\\':		// skip the next character=0A=
+				c++;=0A=
+				break;=0A=
+			default:=0A=
+				break;=0A=
+=0A=
+		}=0A=
+		c++;=0A=
+	}=0A=
+	return;=0A=
+}=0A=
+=0A=
 #define SZ 255=0A=
 =0A=
 /*=0A=
@@ -742,6 +838,9 @@=0A=
 						}=0A=
 					}=0A=
 				}=0A=
+				/* Determine if specification has =0A=
+				 * any meta characters in the RE */=0A=
+				spec_hasMetaChars(&spec[nspec]);=0A=
 			}=0A=
 =0A=
 			nspec++;=0A=
@@ -774,6 +873,14 @@=0A=
 	}=0A=
 	fclose(fp);=0A=
 =0A=
+	/* Sort the specifications with most general first */=0A=
+	qsort(spec, nspec, sizeof(struct spec), spec_compare);=0A=
+=0A=
+	/* Verify no exact duplicates */=0A=
+	if (nodups_specs() !=3D 0) {=0A=
+		exit(1);=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * Apply the specifications to the file systems.=0A=
 	 */=0A=

------_=_NextPart_000_01C2EA6D.ADCEC7E0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
