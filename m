Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75Dj3rT005120
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 09:45:04 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i75DiMn6007068
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 13:44:29 GMT
Message-ID: <411239C9.4020505@redhat.com>
Date: Thu, 05 Aug 2004 09:44:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   selinux-dev@tresys.com
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>	 <1091709011.11061.44.camel@moss-spartans.epoch.ncsc.mil> <1091709228.11061.47.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091709228.11061.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000609080103050809020205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000609080103050809020205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Thu, 2004-08-05 at 08:30, Stephen Smalley wrote:
>  
>
>>Dan has raised the issue of how to handle policy reloads when using
>>booleans, as a policy reload will reset the boolean values to the
>>compile-time default settings.  We could certainly extend load_policy to
>>also set the booleans based on the same configuration file used at boot
>>time, but that will leave open a window between the policy reload and
>>the setting of the booleans where the active policy will fall back to
>>the compile-time defaults.  That could break running processes or create
>>a window of vulnerability, depending on whether the compile-time
>>defaults are more secure or less secure than the configuration file
>>settings.  We could have the policy Makefile patch the boolean default
>>settings based on the configuration file, so that a policy rebuild would
>>change the compile-time defaults to match the desired settings, but that
>>requires policy sources, which may not be available (e.g. the policy
>>reload may have been triggered by a binary policy update, and the end
>>system may not have policy sources installed).  Thoughts?
>>    
>>
>
>Actually, it would be easy to create a simple utility that patches a
>binary policy to change the boolean default values, so that would be a
>possibility.  
>
>  
>
Here is the current patch I was using for load_policy.  As has been 
stated this is not the ideal situation.
Patching the policy.conf is probably the best solution.   Utilities to 
read booleans probably usefull here.

Dan


--------------000609080103050809020205
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

--- policycoreutils-1.15.3/scripts/genhomedircon.rhat	2004-07-29 16:26:01.000000000 -0400
+++ policycoreutils-1.15.3/scripts/genhomedircon	2004-08-05 09:41:35.553364941 -0400
@@ -83,7 +83,7 @@
 	if rc[0] == 0:
 		print rc[1]
 	else:
-		errorExit(join("grep/sed error ", rc[1]))
+		errorExit(string.join("grep/sed error ", rc[1]))
 	return rc
 
 try:
@@ -128,7 +128,7 @@
 	if rc[0] == 0:
 		print rc[1]
 	else:
-		errorExit(join("sed error ", rc[1]))
+		errorExit(string.join("sed error ", rc[1]))
 
 	users = getUsers()
 	print "\n#\n# User-specific file contexts\n#\n"
@@ -137,6 +137,6 @@
 	for u in users.keys():
 		update(sys.argv[2], u, users[u]) 
 except ValueError, error:
-	errorExit(join("ValueError ", error))
+	errorExit(strin.join("ValueError ", error))
 except IndexError, error:
 	errorExit("IndexError")
--- policycoreutils-1.15.3/load_policy/load_policy.c.rhat	2004-08-05 09:41:55.250910627 -0400
+++ policycoreutils-1.15.3/load_policy/load_policy.c	2004-08-05 09:41:59.879803864 -0400
@@ -10,11 +10,67 @@
 #include <selinux/selinux.h>
 #include <locale.h>			    /* for setlocale() */
 #include <libintl.h>			    /* for gettext() */
+#include <ctype.h>
+
 #define _(msgid) gettext (msgid)
 #ifndef PACKAGE
 #define PACKAGE "policycoreutils"   /* the name of this package lang translation */
 #endif
 
+#define BOOLEANS "booleans"      /* booleans file */
+
+
+char *strtrim(char *dest, char *source, int size) {
+	int i=0;
+	char *ptr=source;
+	i=0;
+	while(isspace(*ptr) && i < size) {
+		ptr++;
+		i++;
+	}
+	strncpy(dest,ptr,size);
+	for(i=strlen(dest)-1; i> 0; i--) {
+		if (!isspace(dest[i])) break;
+	}
+	dest[i+1]='\0';
+	return dest;
+}
+
+int load_booleans(void) {
+	FILE *boolf;
+	char buffer[BUFSIZ];
+	char name[BUFSIZ];
+	char name1[BUFSIZ];
+	int val;
+	int errors=0;
+
+	snprintf(buffer,BUFSIZ, "%s/%s", selinux_policy_root(), BOOLEANS);
+	boolf = fopen(buffer,"r");
+	if (boolf == NULL) 
+		return errors;
+
+        while (fgets(buffer, sizeof(buffer), boolf)) {
+		char *tok=strtok(buffer,"=");
+		if (tok) {
+			strncpy(name1,tok, BUFSIZ-1);
+			strtrim(name,name1,BUFSIZ-1);
+			if ( name[0]=='#' ) continue;
+			tok=strtok(NULL,tok);
+			if (tok) {
+				val=atoi(tok);
+				if (security_set_boolean(name, val)!=0) {
+					fprintf(stderr,"error setting boolean %s to value %d \n", name, val);
+					errors++;
+				}
+			}
+		}
+	}
+	fclose(boolf);
+
+	security_commit_booleans();
+
+	return errors;
+}
 int main(int argc, char **argv) 
 {
 	int fd, ret;
@@ -55,5 +111,7 @@
 		fprintf(stderr, _("%s:  security_load_policy failed\n"), argv[0]);
 		exit(3);
 	}
+	load_booleans();
+
 	exit(0);
 }

--------------000609080103050809020205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
