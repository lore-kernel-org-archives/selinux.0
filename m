Message-ID: <42430AD2.9040403@redhat.com>
Date: Thu, 24 Mar 2005 13:45:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: setsebool problems
References: <4243050D.3050808@redhat.com> <1111688788.14076.4.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1111688788.14076.4.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060003040008080808040308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060003040008080808040308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Thu, 2005-03-24 at 13:21 -0500, Daniel J Walsh wrote:
>  
>
>>So this patch changes the selinux handling of booleans.  First it 
>>introduces a new file booleans.local which will contain the users custom 
>>boolean settings.  booleans will be changes to a config file so that it 
>>will be overwritten by rpm on upgrade.  security_load_booleans now reads 
>>booleans and booleans.local to setup boolean values.  setsebool now only 
>>writes the changed values to booleans.local.
>>    
>>
>
>Don't you need to modify libsepol (sepol_genbools) as well in order to
>get booleans.local consulted by load_policy and /sbin/init?
>
>  
>
Ok here is the diff for sepol

-- 



--------------060003040008080808040308
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibsepol/src/genbools.c libsepol-1.5.2/src/genbools.c
--- nsalibsepol/src/genbools.c	2005-03-08 15:15:26.000000000 -0500
+++ libsepol-1.5.2/src/genbools.c	2005-03-24 13:43:55.000000000 -0500
@@ -24,11 +24,39 @@
 	return dest;
 }
 
+static int process_boolean(char *buffer, char *name, int namesize, int *val) {
+	char name1[BUFSIZ];
+	char *ptr;
+	char *tok=strtok_r(buffer,"=",&ptr);
+	if (tok) {
+		strncpy(name1,tok, BUFSIZ-1);
+		strtrim(name,name1,namesize-1);
+		if ( name[0]=='#' ) return 0;
+		tok=strtok_r(NULL,"\0",&ptr);
+		if (tok) {
+			while (isspace(*tok)) tok++;
+			*val = -1;
+			if (isdigit(tok[0]))
+				*val=atoi(tok);
+			else if (!strncmp(tok, "true", sizeof("true")-1))
+				*val = 1;
+			else if (!strncmp(tok, "false", sizeof("false")-1))
+				*val = 0;
+			if (*val != 0 && *val != 1) {
+				fprintf(stderr,"illegal value for boolean %s=%s\n", name, tok);
+				return -1;
+			}
+			
+		}
+	}
+	return 1;
+}
+
 static int load_booleans(struct policydb *policydb, char *path) {
 	FILE *boolf;
 	char buffer[BUFSIZ];
+	char localbools[BUFSIZ];
 	char name[BUFSIZ];
-	char name1[BUFSIZ];
 	int val;
 	int errors=0;
 	struct cond_bool_datum *datum;
@@ -38,27 +66,28 @@
 		return -1;
 
         while (fgets(buffer, sizeof(buffer), boolf)) {
-		char *tok=strtok(buffer,"=");
-		if (tok) {
-			strncpy(name1,tok, BUFSIZ-1);
-			strtrim(name,name1,BUFSIZ-1);
-			if ( name[0]=='#' ) continue;
-			tok=strtok(NULL,"\0");
-			if (tok) {
-				while (isspace(*tok)) tok++;
-				val = -1;
-				if (isdigit(tok[0]))
-					val=atoi(tok);
-				else if (!strncasecmp(tok, "true", sizeof("true")-1))
-					val = 1;
-				else if (!strncasecmp(tok, "false", sizeof("false")-1))
-					val = 0;
-				if (val != 0 && val != 1) {
-					fprintf(stderr,"illegal value for boolean %s=%s\n", name, tok);
-					errors++;
-					continue;
-				}
-
+		int ret=process_boolean(buffer, name, sizeof(name), &val);
+		if (ret==-1) 
+			errors++;
+		if (ret==1) {
+			datum = hashtab_search(policydb->p_bools.table, name);
+			if (!datum) {
+				fprintf(stderr,"unknown boolean %s\n", name);
+				errors++;
+				continue;
+			}
+			datum->state = val;
+		}
+	}
+	fclose(boolf);
+	snprintf(localbools,sizeof(localbools), "%s.local", path);
+	boolf = fopen(localbools,"r");
+	if (boolf != NULL) {
+		while (fgets(buffer, sizeof(buffer), boolf)) {
+			int ret=process_boolean(buffer, name, sizeof(name), &val);
+			if (ret==-1) 
+				errors++;
+			if (ret==1) {
 				datum = hashtab_search(policydb->p_bools.table, name);
 				if (!datum) {
 					fprintf(stderr,"unknown boolean %s\n", name);
@@ -68,8 +97,8 @@
 				datum->state = val;
 			}
 		}
+		fclose(boolf);
 	}
-	fclose(boolf);
 
 	if (errors)
 		errno = EINVAL;

--------------060003040008080808040308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
