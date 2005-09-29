Message-ID: <433C06F0.3020804@redhat.com>
Date: Thu, 29 Sep 2005 11:23:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: getseuserbyname patch
References: <43398EB2.1050100@redhat.com>	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>	 <433BEB18.7000703@redhat.com> <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-09-29 at 09:24 -0400, Daniel J Walsh wrote:
>  
>
>>Updated patch for libselinux.
>>    
>>
>
>diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.27.1/include/selinux/selinux.h
>--- nsalibselinux/include/selinux/selinux.h	2005-09-01 11:17:40.000000000 -0400
>+++ libselinux-1.27.1/include/selinux/selinux.h	2005-09-28 14:37:04.000000000 -0400
>@@ -354,6 +354,25 @@
> extern int selinux_raw_to_trans_context(security_context_t raw, 
> 					security_context_t *transp);
> 
>+
>+/* the following functions are used to retrieve the SELinux user and their 
>+   security level via the  Linux usernames selinux */
>+
>+#define SEUSERFILE "/etc/selinux/seusers.conf"
>+
>+/* Define data structures */
>+typedef struct seuser {
>+	char* username;
>+	char* seusername;
>+	char* level;
>+} seuser_t;
>+
>+/* read /etc/selinux/seusers.conf file an return selinux user info */
>+
>+extern void freeseuser(seuser_t *seuser);
>+
>+extern int getseuserbyname(const char *name, seuser_t **r_seuser);
>+
>
>Why not just:
>extern int getseuserbyname(const char *linuxname, char **seusername, char **selevel);
>
>Why do we need the struct?  Even with the struct, why do we need to return the
>(Linux) username since it was provided by the caller in the first place?
>Seems simpler to just omit the struct from the public interface.
>
>  
>
I was mimicking getpwdbyname.  Also this allows the user to see if he 
got default instead of username.

Finally we have the ability to add additional fields in the future, if 
we ever need them without breaking API.

>Also, the config file location doesn't need to be exported in the header;
>it should be private to libselinux.  
>
>  
>
Ok.

>diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/seuser.h libselinux-1.27.1/include/selinux/seuser.h
>--- nsalibselinux/include/selinux/seuser.h	1969-12-31 19:00:00.000000000 -0500
>+++ libselinux-1.27.1/include/selinux/seuser.h	2005-09-28 14:32:11.000000000 -0400
>
>This looks like the old interface.  Leftover file that should be dropped?
>
>diff --exclude-from=exclude -N -u -r nsalibselinux/src/seusers.c libselinux-1.27.1/src/seusers.c
>--- nsalibselinux/src/seusers.c	1969-12-31 19:00:00.000000000 -0500
>+++ libselinux-1.27.1/src/seusers.c	2005-09-28 14:48:28.000000000 -0400
>@@ -0,0 +1,132 @@
>+#include <unistd.h>
>+#include <fcntl.h>
>+#include <stdlib.h>
>+#include <string.h>
>+#include <stdio.h>
>+#include <ctype.h>
>+#include <selinux/selinux.h>
>+#include <selinux/context.h>
>+#include "selinux_internal.h"
>+
>+void freeseuser(seuser_t *seuser) {
>+	if (!seuser) return;
>+	if (seuser->username)
>+		free(seuser->username);
>+	if (seuser->seusername)
>+		free(seuser->seusername);
>+	if (seuser->level)
>+		free(seuser->level);
>
>You don't need the if statements for the component frees, because
>free(NULL) is legitimate and does no harm.
>
>+	while (getline(&buffer, &size, cfg) > 0) {
>+		if(process_seusers(buffer, &seuser) == 0) {
>+			if (strcasecmp(seuser->username, name)==0) 
>+			    break;
>
>Why case-insensitive comparison?  Are 'root' and 'Root' really identical as far 
>as the rest of the system is concerned?
>
>  
>

Agreed this should not be strcasecmp.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
