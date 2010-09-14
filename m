Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o8EGLqk6004911
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2010 12:21:52 -0400
Received: from new1.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o8EGLpkR006893
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2010 16:21:51 GMT
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 684792018E
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2010 12:21:51 -0400 (EDT)
Received: from seclab05b.polito.it (unknown [130.192.1.249])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F29F5E4F24
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2010 12:21:49 -0400 (EDT)
From: Roberto Sassu <roberto.sassu@polito.it>
To: selinux@tycho.nsa.gov
Subject: SETools patch: adding exclude type feature in queries
Date: Tue, 14 Sep 2010 18:21:51 +0200
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6970961.iPUpH8VMcK";
  protocol="application/pkcs7-signature";
  micalg=sha1
Message-Id: <201009141821.58119.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart6970961.iPUpH8VMcK
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all

i developed a patch that allows to specify a type or an attribute to be=20
excluded either from source and target criteria of a policy query=20
performed with the 'sesearch' command line tool.

This patch is in a initial state, it works only for AV semantic queries=20
and applies on 'setools' source from the Fedora 13 rpm:
setools-3.3.7-7.fc13.src.rpm


diff -urp setools-3.3.7.orig/libapol/include/apol/avrule-query.h setools-3.=
3.7/libapol/include/apol/avrule-query.h
=2D-- setools-3.3.7.orig/libapol/include/apol/avrule-query.h	2010-09-10 14:=
32:24.032644009 +0200
+++ setools-3.3.7/libapol/include/apol/avrule-query.h	2010-09-13 15:23:43.0=
50612738 +0200
@@ -123,6 +123,8 @@ extern "C"
  */
 	extern int apol_avrule_query_set_source(const apol_policy_t * p, apol_avr=
ule_query_t * a, const char *symbol,
 						int is_indirect);
+	extern int apol_avrule_query_set_source_neg(const apol_policy_t * p, apol=
_avrule_query_t * a, const char *symbol,
+						int is_indirect);
=20
 /**
  * Set an avrule query to return rules whose source symbol is matched as a=
 type
@@ -158,6 +160,8 @@ extern "C"
  */
 	extern int apol_avrule_query_set_target(const apol_policy_t * p, apol_avr=
ule_query_t * a, const char *symbol,
 						int is_indirect);
+	extern int apol_avrule_query_set_target_neg(const apol_policy_t * p, apol=
_avrule_query_t * a, const char *symbol,
+						int is_indirect);
=20
 /**
  * Set an avrule query to return rules whose target symbol is matched as a=
 type
diff -urp setools-3.3.7.orig/libapol/src/avrule-query.c setools-3.3.7/libap=
ol/src/avrule-query.c
=2D-- setools-3.3.7.orig/libapol/src/avrule-query.c	2010-09-10 14:32:24.026=
643858 +0200
+++ setools-3.3.7/libapol/src/avrule-query.c	2010-09-13 15:23:43.051613507 =
+0200
@@ -36,6 +36,7 @@
 struct apol_avrule_query
 {
 	char *source, *target, *bool_name;
+	char *sourceneg, *targetneg;
 	apol_vector_t *classes, *perms;
 	unsigned int rules;
 	unsigned int flags;
@@ -51,6 +52,10 @@ struct apol_avrule_query
  *  If NULL, accept all types.
  *  @param target_list If non-NULL, list of types to use as target.
  *  If NULL, accept all types.
+ *  @param sourceneg_list If non-NULL, list of types to exclude from sourc=
e_list.
+ *  If NULL, accept all types.
+ *  @param targetneg_list If non-NULL, list of types to exclude from targe=
t_list.
+ *  If NULL, accept all types.
  *  @param class_list If non-NULL, list of classes to use.
  *  If NULL, accept all classes.
  *  @param perm_list If non-NULL, list of permisions to use.
@@ -60,7 +65,9 @@ struct apol_avrule_query
  *  @return 0 on success and < 0 on failure.
  */
 static int rule_select(const apol_policy_t * p, apol_vector_t * v, uint32_=
t rule_type, unsigned int flags,
=2D		       const apol_vector_t * source_list, const apol_vector_t * target=
_list, const apol_vector_t * class_list,
+		       const apol_vector_t * source_list, const apol_vector_t * target_l=
ist,=20
+		       const apol_vector_t * sourceneg_list, const apol_vector_t * targe=
tneg_list,=20
+		       const apol_vector_t * class_list,
 		       const apol_vector_t * perm_list, const char *bool_name)
 {
 	qpol_iterator_t *iter =3D NULL, *perm_iter =3D NULL;
@@ -109,16 +116,19 @@ static int rule_select(const apol_policy
 			}
 		}
=20
=2D		if (source_list =3D=3D NULL) {
+		if (source_list =3D=3D NULL && sourceneg_list =3D=3D NULL) {
 			match_source =3D 1;
 		} else {
 			const qpol_type_t *source_type;
 			if (qpol_avrule_get_source_type(p->p, rule, &source_type) < 0) {
 				goto cleanup;
 			}
=2D			if (apol_vector_get_index(source_list, source_type, NULL, NULL, &i) =
=3D=3D 0) {
+			if (source_list =3D=3D NULL || (source_list !=3D NULL && apol_vector_ge=
t_index(source_list,=20
+					source_type, NULL, NULL, &i) =3D=3D 0))
 				match_source =3D 1;
=2D			}
+			if (sourceneg_list !=3D NULL && apol_vector_get_index(sourceneg_list,=20
+					source_type, NULL, NULL, &i) =3D=3D 0)
+				match_source =3D 0;
 		}
=20
 		/* if source did not match, but treating source symbol
@@ -128,16 +138,19 @@ static int rule_select(const apol_policy
 			continue;
 		}
=20
=2D		if (target_list =3D=3D NULL || (source_as_any && match_source)) {
+		if ((target_list =3D=3D NULL && targetneg_list =3D=3D NULL) || (source_a=
s_any && match_source)) {
 			match_target =3D 1;
 		} else {
 			const qpol_type_t *target_type;
 			if (qpol_avrule_get_target_type(p->p, rule, &target_type) < 0) {
 				goto cleanup;
 			}
=2D			if (apol_vector_get_index(target_list, target_type, NULL, NULL, &i) =
=3D=3D 0) {
+			if (target_list =3D=3D NULL || (target_list !=3D NULL && apol_vector_ge=
t_index(target_list,=20
+					target_type, NULL, NULL, &i) =3D=3D 0))
 				match_target =3D 1;
=2D			}
+			if (targetneg_list !=3D NULL && apol_vector_get_index(targetneg_list,=20
+					target_type, NULL, NULL, &i) =3D=3D 0)
+				match_target =3D 0;
 		}
=20
 		if (!match_target) {
@@ -192,6 +205,7 @@ static int rule_select(const apol_policy
 int apol_avrule_get_by_query(const apol_policy_t * p, const apol_avrule_qu=
ery_t * a, apol_vector_t ** v)
 {
 	apol_vector_t *source_list =3D NULL, *target_list =3D NULL, *class_list =
=3D NULL, *perm_list =3D NULL;
+	apol_vector_t *sourceneg_list =3D NULL, *targetneg_list =3D NULL;
 	int retval =3D -1, source_as_any =3D 0, is_regex =3D 0;
 	char *bool_name =3D NULL;
 	*v =3D NULL;
@@ -216,17 +230,38 @@ int apol_avrule_get_by_query(const apol_
 							    APOL_QUERY_SOURCE_TYPE))) =3D=3D NULL) {
 			goto cleanup;
 		}
+		if (a->sourceneg !=3D NULL &&
+		    (sourceneg_list =3D
+		     apol_query_create_candidate_type_list(p, a->sourceneg, is_regex,
+							   a->flags & APOL_QUERY_SOURCE_INDIRECT,
+							   ((a->flags & (APOL_QUERY_SOURCE_TYPE | APOL_QUERY_SOURCE_ATTRIBU=
TE)) /
+							    APOL_QUERY_SOURCE_TYPE))) =3D=3D NULL) {
+			goto cleanup;
+		}
 		if ((a->flags & APOL_QUERY_SOURCE_AS_ANY) && a->source !=3D NULL) {
 			target_list =3D source_list;
+			if (a->sourceneg !=3D NULL)
+				targetneg_list =3D sourceneg_list;
 			source_as_any =3D 1;
=2D		} else if (a->target !=3D NULL &&
+		} else {
+			if (a->target !=3D NULL &&
 			   (target_list =3D
 			    apol_query_create_candidate_type_list(p, a->target, is_regex,
 								  a->flags & APOL_QUERY_TARGET_INDIRECT,
 								  ((a->
 								    flags & (APOL_QUERY_TARGET_TYPE | APOL_QUERY_TARGET_ATTRIBUTE))
 								   / APOL_QUERY_TARGET_TYPE))) =3D=3D NULL) {
=2D			goto cleanup;
+				goto cleanup;
+			}
+			if (a->targetneg !=3D NULL &&
+			   (targetneg_list =3D
+			    apol_query_create_candidate_type_list(p, a->targetneg, is_regex,
+								  a->flags & APOL_QUERY_TARGET_INDIRECT,
+								  ((a->
+								    flags & (APOL_QUERY_TARGET_TYPE | APOL_QUERY_TARGET_ATTRIBUTE))
+								   / APOL_QUERY_TARGET_TYPE))) =3D=3D NULL) {
+				goto cleanup;
+			}
 		}
 		if (a->classes !=3D NULL &&
 		    apol_vector_get_size(a->classes) > 0 &&
@@ -243,7 +278,8 @@ int apol_avrule_get_by_query(const apol_
 		goto cleanup;
 	}
=20
=2D	if (rule_select(p, *v, rule_type, flags, source_list, target_list, clas=
s_list, perm_list, bool_name)) {
+	if (rule_select(p, *v, rule_type, flags, source_list, target_list,=20
+			sourceneg_list, targetneg_list, class_list, perm_list, bool_name)) {
 		goto cleanup;
 	}
=20
@@ -253,8 +289,10 @@ int apol_avrule_get_by_query(const apol_
 		apol_vector_destroy(v);
 	}
 	apol_vector_destroy(&source_list);
+	apol_vector_destroy(&sourceneg_list);
 	if (!source_as_any) {
 		apol_vector_destroy(&target_list);
+		apol_vector_destroy(&targetneg_list);
 	}
 	apol_vector_destroy(&class_list);
 	/* don't destroy perm_list - it points to query's permission list */
@@ -265,6 +303,7 @@ int apol_syn_avrule_get_by_query(const a
 {
 	qpol_iterator_t *iter =3D NULL, *perm_iter =3D NULL;
 	apol_vector_t *source_list =3D NULL, *target_list =3D NULL, *class_list =
=3D NULL, *perm_list =3D NULL, *syn_v =3D NULL;
+	apol_vector_t *sourceneg_list =3D NULL, *targetneg_list =3D NULL;
 	apol_vector_t *target_types_list =3D NULL;
 	int retval =3D -1, source_as_any =3D 0, is_regex =3D 0;
 	char *bool_name =3D NULL;
@@ -322,7 +361,8 @@ int apol_syn_avrule_get_by_query(const a
 		goto cleanup;
 	}
=20
=2D	if (rule_select(p, *v, rule_type, flags, source_list, target_list, clas=
s_list, perm_list, bool_name)) {
+	if (rule_select(p, *v, rule_type, flags, source_list, target_list,=20
+			sourceneg_list, targetneg_list, class_list, perm_list, bool_name)) {
 		goto cleanup;
 	}
=20
@@ -486,6 +526,12 @@ int apol_avrule_query_set_source(const a
 	return apol_query_set(p, &a->source, NULL, symbol);
 }
=20
+int apol_avrule_query_set_source_neg(const apol_policy_t * p, apol_avrule_=
query_t * a, const char *symbol, int is_indirect)
+{
+	apol_query_set_flag(p, &a->flags, is_indirect, APOL_QUERY_SOURCE_INDIRECT=
);
+	return apol_query_set(p, &a->sourceneg, NULL, symbol);
+}
+
 int apol_avrule_query_set_source_component(const apol_policy_t * p, apol_a=
vrule_query_t * a, unsigned int component)
 {
 	if (!a || !(component & APOL_QUERY_SYMBOL_IS_BOTH)) {
@@ -504,6 +550,12 @@ int apol_avrule_query_set_target(const a
 	return apol_query_set(p, &a->target, NULL, symbol);
 }
=20
+int apol_avrule_query_set_target_neg(const apol_policy_t * p, apol_avrule_=
query_t * a, const char *symbol, int is_indirect)
+{
+	apol_query_set_flag(p, &a->flags, is_indirect, APOL_QUERY_TARGET_INDIRECT=
);
+	return apol_query_set(p, &a->targetneg, NULL, symbol);
+}
+
 int apol_avrule_query_set_target_component(const apol_policy_t * p, apol_a=
vrule_query_t * a, unsigned int component)
 {
 	if (!a || !(component && APOL_QUERY_SYMBOL_IS_BOTH)) {
diff -urp setools-3.3.7.orig/secmds/sesearch.c setools-3.3.7/secmds/sesearc=
h.c
=2D-- setools-3.3.7.orig/secmds/sesearch.c	2010-09-10 14:32:24.083894085 +0=
200
+++ setools-3.3.7/secmds/sesearch.c	2010-09-13 15:23:43.055612620 +0200
@@ -72,6 +72,8 @@ static struct option const longopts[] =3D=20
=20
 	{"source", required_argument, NULL, 's'},
 	{"target", required_argument, NULL, 't'},
+	{"source-neg", required_argument, NULL, 'u'},
+	{"target-neg", required_argument, NULL, 'v'},
 	{"role_source", required_argument, NULL, EXPR_ROLE_SOURCE},
 	{"role_target", required_argument, NULL, EXPR_ROLE_TARGET},
 	{"class", required_argument, NULL, 'c'},
@@ -92,6 +94,8 @@ typedef struct options
 {
 	char *src_name;
 	char *tgt_name;
+	char *srcneg_name;
+	char *tgtneg_name;
 	char *src_role_name;
 	char *tgt_role_name;
 	char *class_name;
@@ -136,6 +140,8 @@ void usage(const char *program_name, int
 	printf("EXPRESSIONS:\n");
 	printf("  -s NAME, --source=3DNAME    rules with type/attribute NAME as s=
ource\n");
 	printf("  -t NAME, --target=3DNAME    rules with type/attribute NAME as t=
arget\n");
+	printf("  -u NAME,--source-neg=3DNAME rules without type/attribute NAME a=
s source\n");
+	printf("  -v NAME,--target-neg=3DNAME rules without type/attribute NAME a=
s target\n");
 	printf("  --role_source=3DNAME        rules with role NAME as source\n");
 	printf("  --role_target=3DNAME        rules with role NAME as target\n");
 	printf("  -c NAME, --class=3DNAME     rules with class NAME as the object=
 class\n");
@@ -197,6 +203,10 @@ static int perform_av_query(const apol_p
 		apol_avrule_query_set_source(policy, avq, opt->src_name, opt->indirect);
 	if (opt->tgt_name)
 		apol_avrule_query_set_target(policy, avq, opt->tgt_name, opt->indirect);
+	if (opt->srcneg_name)
+		apol_avrule_query_set_source_neg(policy, avq, opt->srcneg_name, opt->ind=
irect);
+	if (opt->tgtneg_name)
+		apol_avrule_query_set_target_neg(policy, avq, opt->tgtneg_name, opt->ind=
irect);
 	if (opt->bool_name)
 		apol_avrule_query_set_bool(policy, avq, opt->bool_name);
 	if (opt->class_name) {
@@ -841,7 +851,7 @@ int main(int argc, char **argv)
=20
 	memset(&cmd_opts, 0, sizeof(cmd_opts));
 	cmd_opts.indirect =3D true;
=2D	while ((optc =3D getopt_long(argc, argv, "ATs:t:c:p:b:dRnSChV", longopt=
s, NULL)) !=3D -1) {
+	while ((optc =3D getopt_long(argc, argv, "ATs:t:u:v:c:p:b:dRnSChV", longo=
pts, NULL)) !=3D -1) {
 		switch (optc) {
 		case 0:
 			break;
@@ -869,6 +879,30 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			break;
+		case 'u':	       /* source (negated) */
+			if (optarg =3D=3D 0) {
+				usage(argv[0], 1);
+				printf("Missing source type/attribute for -u (--source-neg)\n");
+				exit(1);
+			}
+			cmd_opts.srcneg_name =3D strdup(optarg);
+			if (!cmd_opts.srcneg_name) {
+				fprintf(stderr, "%s\n", strerror(errno));
+				exit(1);
+			}
+			break;
+		case 'v':	       /* target (negated) */
+			if (optarg =3D=3D 0) {
+				usage(argv[0], 1);
+				printf("Missing target type/attribute for -v (--target-neg)\n");
+				exit(1);
+			}
+			cmd_opts.tgtneg_name =3D strdup(optarg);
+			if (!cmd_opts.tgtneg_name) {
+				fprintf(stderr, "%s\n", strerror(errno));
+				exit(1);
+			}
+			break;
 		case EXPR_ROLE_SOURCE:
 			if (optarg =3D=3D 0) {
 				usage(argv[0], 1);
@@ -1162,6 +1196,8 @@ int main(int argc, char **argv)
 	apol_policy_path_destroy(&pol_path);
 	free(cmd_opts.src_name);
 	free(cmd_opts.tgt_name);
+	free(cmd_opts.srcneg_name);
+	free(cmd_opts.tgtneg_name);
 	free(cmd_opts.class_name);
 	free(cmd_opts.permlist);
 	free(cmd_opts.bool_name);

--nextPart6970961.iPUpH8VMcK
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIQCTCCBLMw
ggOboAMCAQICARQwDQYJKoZIhvcNAQEFBQAwQTEQMA4GA1UEChMHRXVyb1BLSTEtMCsGA1UEAxMk
RXVyb1BLSSBSb290IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA2MTAyNDEzMzEzM1oXDTEw
MTIzMTEyNTk1OVowUTELMAkGA1UEBhMCSVQxEDAOBgNVBAoTB0V1cm9QS0kxMDAuBgNVBAMTJ0V1
cm9QS0kgSXRhbGlhbiBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAPbJ3y5bE0iL2iFW59R4KGHS3iTc22mq2GlDaOZLE3Xz1wTvB/yBl5e4ntMZ
eEeWTW9JInNRTtfC3mcLk0gnEdK1rQZbe4lQwBVHdkG8LvRQDWHIkZNuccoUpQXMv+JbZjI6m7rH
fU2CN/YCvFY9QL08xXsfDxvX2Ee4S7EwJiSEEJSiy+R00uTfvfn27d8a6LCqYLzlInRlz4C2CUbk
+U2UAwjYEPTP2ziqFxztysbxC3fjqH8e6P5wIPXOS5cSYnVaEyp21VXhAOamVJEGlQCdVoTHs+pP
BYqCBuNhBfienUPaEDHHUUYHZ2nS4eNzd9XOu+5hFi1/8hVZxN4sbdECAwEAAaOCAaQwggGgMEwG
CWCGSAGG+EIBDQQ/Fj1Jc3N1ZWQgdW5kZXIgcG9saWN5OgogaHR0cDovL3d3dy5ldXJvcGtpLm9y
Zy9jYS9yb290L2Nwcy8xLjEvMGUGCCsGAQUFBwEBBFkwVzAoBggrBgEFBQcwAYYcaHR0cDovL29j
c3AuZXVyb3BraS5vcmc6ODAyNjArBggrBgEFBQcwAoYfaHR0cDovL3d3dy5ldXJvcGtpLm9yZy9j
YS9yb290LzA7BgNVHR8ENDAyMDCgLqAshipodHRwOi8vd3d3LmV1cm9wa2kub3JnL2NhL3Jvb3Qv
Y3JsL2NybC5kZXIwDAYDVR0TBAUwAwEB/zBOBgNVHSAERzBFMEMGCisGAQQBqQcBAQEwNTAzBggr
BgEFBQcCARYnaHR0cDovL3d3dy5ldXJvcGtpLm9yZy9jYS9yb290L2Nwcy8xLjEvMA4GA1UdDwEB
/wQEAwIB9jAdBgNVHQ4EFgQUjl4HtzG0Gbu5BJU0rMX9016KQsAwHwYDVR0jBBgwFoAUjNyLsaVK
kOdOiHMYPJ3VXn7kss0wDQYJKoZIhvcNAQEFBQADggEBAFjlAWMiL7uhEAVcrPeMXsbQU+bQNbP1
TBqyBoMCMJ4RakM7/67AsmqpKGIYwhjVkSNHhscRl5BuSiyviHOLbWUJ9tAAKt6hzMDr1J4OvWSH
Sn8y9fSlyQU8+fQE8FHxXT3Aa7aLYVqsqr0ppmxRDL/9b/mdUVcMXiKFAdopFzhXIigfZFh6MW/o
7/GEiDMGsovCiwKJ5ZL46zGRDaS+O0aRYQv2PHZaWrC8i0OPwghlTeB2DfUBzm0urPijBATdjzP8
yO3YGymFZOIG08Roe4bwzrANGzX5luBk3lNmtXTPHoUtRLn3ADa+IUGwK6VYWHYJe1+uUHRNziQu
/Zsb858wggU/MIIEJ6ADAgECAgIJzzANBgkqhkiG9w0BAQUFADBRMQswCQYDVQQGEwJJVDEQMA4G
A1UEChMHRXVyb1BLSTEwMC4GA1UEAxMnRXVyb1BLSSBJdGFsaWFuIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MB4XDTA2MTEwNjE3MTU1OVoXDTEwMTIzMTEyNTk1OVowZTELMAkGA1UEBhMCSVQxHjAc
BgNVBAoTFVBvbGl0ZWNuaWNvIGRpIFRvcmlubzE2MDQGA1UEAxMtUG9saXRlY25pY28gZGkgVG9y
aW5vIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEA/s1vopfmSp2eqKG/jW4H5YyfrZc/jWEnctMMm7TlVT+ryxJ2ifYV/7VyuYVIGdnCBnmJiav6
uhePqpHyuejEZ+IdCchk04BSBbgzkSbWakw2ekv1SKm8WfvhxHbiSo/t//LQEANMJ+XeeqGl1TRR
8gdMC6erWFGdl5FcuOpMoaqW6DszVGlOAf7Uo/DExZ0/9cw77GTRoDTA3vi1QJEYGaAAvI2/flaU
8gn4QoktjowchDXBylVsyqs+ux3v7m3H0cgC3q62t2om2badk40F9XH1w2WPLQB6rSl+TPDxkl2k
kR4goQprXR0b0OujS5ADq5Ds2w7YPj5h4J6ebsbIUQIDAQABo4ICCzCCAgcwdQYJYIZIAYb4QgEN
BGgWZklzc3VlZCB1bmRlciBwb2xpY2llczoKIGh0dHA6Ly93d3cuZXVyb3BraS5vcmcvY2Evcm9v
dC9jcHMvMS4xLwogaHR0cDovL3d3dy5ldXJvcGtpLm9yZy9jYS9pdC9jcHMvMS4xLzBcBggrBgEF
BQcBAQRQME4wKAYIKwYBBQUHMAGGHGh0dHA6Ly9vY3NwLmV1cm9wa2kub3JnOjgwMjYwIgYIKwYB
BQUHMAKGFmh0dHA6Ly93d3cuZXVyb3BraS5vcmcwPAYDVR0fBDUwMzAxoC+gLYYraHR0cDovL3d3
dy5ldXJvcGtpLm9yZy9jYS9pdDIvY3JsMDMvY3JsLmRlcjAPBgNVHRMBAf8EBTADAQH/MIGTBgNV
HSAEgYswgYgwQwYKKwYBBAGpBwEBATA1MDMGCCsGAQUFBwIBFidodHRwOi8vd3d3LmV1cm9wa2ku
b3JnL2NhL3Jvb3QvY3BzLzEuMS8wQQYKKwYBBAGpBwIBATAzMDEGCCsGAQUFBwIBFiVodHRwOi8v
d3d3LmV1cm9wa2kub3JnL2NhL2l0L2Nwcy8xLjEvMAsGA1UdDwQEAwIB9jAdBgNVHQ4EFgQUCf0l
GW/jaHyCazVzvCgAviw8OjgwHwYDVR0jBBgwFoAUjl4HtzG0Gbu5BJU0rMX9016KQsAwDQYJKoZI
hvcNAQEFBQADggEBANfGdD6B98NUwBOVYIiuo+SNfw8Afjr2oFHLYEHYhKdBED1WBckhK610v2zJ
ctramnrqdd+xfyzmkyNm48OtkiVetYzXbgYeyMGxhO8HrJ1Ztf1yEN0lL8HgdK3lmJeLYNYH/cwZ
5SlKwvTR/VENHLYlWsgWk47ut7W8+Zd/ESwzNdJUCBUMoQnGZ3giyhAXKAgIOckwL0g8KmnceY7J
Y4L1G++1OuOoUcgg2jRPxcVmHVEe/cM0WHfUcigDXSBTIxAiDwlQ7ni97yX1RqBV/6IVdRDYKyjg
YkdYcwU9ZuOKUP4Pl5KKCegLOHRoo5kX6V1o7b2IZGBFoVmkag4m4kkwggYLMIIE86ADAgECAgID
wTANBgkqhkiG9w0BAQUFADBlMQswCQYDVQQGEwJJVDEeMBwGA1UEChMVUG9saXRlY25pY28gZGkg
VG9yaW5vMTYwNAYDVQQDEy1Qb2xpdGVjbmljbyBkaSBUb3Jpbm8gQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMDgxMjA1MTYwMDAwWhcNMTAxMjMwMTIwMDAwWjB5MQswCQYDVQQGEwJJVDEeMBwG
A1UEChMVUG9saXRlY25pY28gZGkgVG9yaW5vMTEwLwYDVQQLEyhEaXBhcnRpbWVudG8gZGkgQXV0
b21hdGljYSBlIEluZm9ybWF0aWNhMRcwFQYDVQQDEw5Sb2JlcnRvICBTYXNzdTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAOS/leMNzG5v7FG73ythWtNPOdq8MEFpzg7mjy4M7UsS9+sc
b7QE8TOX365q/+mBwxZ7qW+OhNKfgv14A3y/quju5P7mjTmTNvKWDpsUBjC+tCs+WpWsgIPc2xxW
PrR7br04U/SYYNsxynh1TtO2gsQrHIj9S/wNiNRP8GGPCAiuYRlaL2CeSVn4JEKcT0zOeLIIqfDp
3Ad3YeBhj+cR3TrmO9TyGTPCAb1oyq9wuA1Tx044rqSQNbp0e0RvOrwAIpD/2mNPP3ReTeB53aSg
q0pCHoH1s2AcY/jWJ1joYFC9hh/2DqZRvMNIsM7Uce5Iiz2sgl1I61IUD4658HYzCmMCAwEAAaOC
Aq8wggKrMIGVBglghkgBhvhCAQ0EgYcWgYRJc3N1ZWQgdW5kZXIgcG9saWNpZXM6CiBodHRwOi8v
d3d3LmV1cm9wa2kub3JnL2NhL3Jvb3QvY3BzLzEuMS8KIGh0dHA6Ly93d3cuZXVyb3BraS5vcmcv
Y2EvaXQvY3BzLzEuMS8KIGh0dHA6Ly9jYS5wb2xpdG8uaXQvY3BzLzIuMS8wEQYJYIZIAYb4QgEB
BAQDAgCwMGMGCCsGAQUFBwEBBFcwVTAoBggrBgEFBQcwAYYcaHR0cDovL29jc3AuZXVyb3BraS5v
cmc6ODAyNjApBggrBgEFBQcwAoYdaHR0cDovL3d3dy5ldXJvcGtpLm9yZy9jYS9pdC8wMgYDVR0f
BCswKTAnoCWgI4YhaHR0cDovL2NhLnBvbGl0by5pdC9jcmwwMy9jcmwuZGVyMAwGA1UdEwEB/wQC
MAAwOgYDVR0RBDMwMYEXcm9iZXJ0by5zYXNzdUBwb2xpdG8uaXSgFgYKKwYBBAGVYgIBAaAIFgYw
MjEzMDUwgc0GA1UdIASBxTCBwjBDBgorBgEEAakHAQEBMDUwMwYIKwYBBQUHAgEWJ2h0dHA6Ly93
d3cuZXVyb3BraS5vcmcvY2Evcm9vdC9jcHMvMS4xLzBBBgorBgEEAakHAgEBMDMwMQYIKwYBBQUH
AgEWJWh0dHA6Ly93d3cuZXVyb3BraS5vcmcvY2EvaXQvY3BzLzEuMS8wOAYKKwYBBAGVYgECATAq
MCgGCCsGAQUFBwIBFhxodHRwOi8vY2EucG9saXRvLml0L2Nwcy8yLjEvMAsGA1UdDwQEAwIE8DAd
BgNVHQ4EFgQUP+37DpRL6r5BNjgsgFjI8MHvGTcwHwYDVR0jBBgwFoAUCf0lGW/jaHyCazVzvCgA
viw8OjgwDQYJKoZIhvcNAQEFBQADggEBADRj0OWMglzLXTPuKND9gMTHd1iRPzRNI1TiYFN/WIyu
a3mNev65wKn35VxbbMV6k7zuxxdC7o+iYRLepVOnpw90Af/SiJRc9QI4rk8tzSr5xII7vI0fPvcl
rjSMymXCvwKrbYwrKe0FhBnSZ8AoewXoHDQ8f64heLIU8mLWuwo1+brq0pJUH5Q+69WAGD03ln+l
Fhk2KqvVv8yAD21PydrS7Uk2ZLE7l7/+BTQBY8ZjpNRZ44C6+o7lou2zN6lkWtVHBwUNVdfu3wkS
TdtCm/yxR8XUlFyZkLHfhY19VW4luxb7KZ4GiPKDERdQwBb0kja4eqSOBkAPWZ9Y8zpv4bAxggIc
MIICGAIBATBrMGUxCzAJBgNVBAYTAklUMR4wHAYDVQQKExVQb2xpdGVjbmljbyBkaSBUb3Jpbm8x
NjA0BgNVBAMTLVBvbGl0ZWNuaWNvIGRpIFRvcmlubyBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eQIC
A8EwCQYFKw4DAhoFAKCBhzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xMDA5MTQxNjIxNTFaMCMGCSqGSIb3DQEJBDEWBBQklO86T4uLehTTM0Q1ohjAj+f1BzAoBgkq
hkiG9w0BCQ8xGzAZMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBgkqhkiG9w0BAQEFAASCAQA2
YW7a5ZGSbfZ74Fn0CM0tu9jnvgmWkPQ0UdVo4TU1x5mZU0yl9X9Pe767w4Eo67w1oAL9nuwxfK1+
c3XLq8rlr18xj4qm29BajSvVCvNmK59285v8+w/Uf8etxS+EZ8+BK8j/krIiM8gWPQkGx4wYgK45
5JekWioRsFuL9YIOSGfuLUh12cjBZYUkCAmH51AnjoaE/kyYGD+VLsT2feDglC9KGbMkftRS2QPk
OXvGU0XoHC4x/7ODmHFyst/ztaQrxh+2yMMl7VfyxaetJiwODbdDqam0OerB769JM5ekbvzAaxsb
UBuOjT4TucXfU5nOYdAvecmcG8/zfS+tliF5AAAAAAAA

--nextPart6970961.iPUpH8VMcK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
