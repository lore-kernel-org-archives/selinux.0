Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4PILeRb020489
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 14:21:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4PIJAar024416
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 18:19:10 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i4PIJ9Qu024413
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 18:19:09 GMT
Message-ID: <40B38D50.1080901@redhat.com>
Date: Tue, 25 May 2004 14:15:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
   selinux@tycho.nsa.gov, selinux-dev@tresys.com
Subject: Re: [PATCH][RFC] Allow administrator control over per-user	default_contexts
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>	 <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu>	 <200405240612.15645.russell@coker.com.au>	 <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil> <1085496496.30578.92.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1085496496.30578.92.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2004-05-24 at 08:43, Stephen Smalley wrote:
>  
>
>>On Sun, 2004-05-23 at 16:12, Russell Coker wrote:
>>    
>>
>>>However I am not certain that the existence of the directory should preclude 
>>>any use of ~/.default_contexts.  Maybe only the existence of 
>>>a /etc/security/selinux/default_contexts.user/username should be used to 
>>>indicate that ~/.default_contexts should be ignored.
>>>      
>>>
>>Possibly, but then we need another method to allow an admin to
>>absolutely prohibit any use of $HOME/.default_contexts.  Requiring the
>>admin to create a stub entry under /etc/security/default_contexts.user
>>for every user just to prevent use of $HOME/.default_contexts is
>>unreasonable.  We could use the existence of another file, e.g.
>>/etc/security/default_contexts.user/ONLY, to indicate to libselinux that
>>it should only pull from that subdirectory and not from
>>$HOME/.default_contexts.
>>    
>>
>
>Below is an updated patch that uses the existence of a separate
>/etc/security/default_contexts.user/.force file as an indicator that the
>administrator does not want to allow use of $HOME/.default_contexts at
>all.  Hence, the new logic first checks for
>/etc/security/default_contexts.user/$USER and uses that file if it
>exists; otherwise, it checks for the .force file to determine whether or
>not to check for $HOME/.default_contexts.  As before, the logic still
>pulls in the system default_contexts entries afterwards, and omits any
>invalid contexts for the user or unreachable contexts from the caller. 
>If this looks ok, we'll make this change (although the final location of
>the default_contexts.user directory may change due to some other
>discussions about rearranging the SELinux config file layout and
>supporting multiple policies).
>
>  
>
I see very little reason to continue supporting ~/.default_contexts.  I 
think that the new design allows for specific users to have different 
context but that is controlled by the admin.  Users most likely will not 
understand the contents of the .default_contexts files and those that do 
can probably get an admin to change the system wide one.  The amount of 
headaches of maintaining .default_contexts under a correct security 
context and having the user screw up his file is great.  I vote to just 
get rid of it.

Dan

> 
>  
>
>------------------------------------------------------------------------
>
>Index: libselinux/include/selinux/get_context_list.h
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/get_context_list.h,v
>retrieving revision 1.3
>diff -u -r1.3 get_context_list.h
>--- libselinux/include/selinux/get_context_list.h	6 Oct 2003 19:55:18 -0000	1.3
>+++ libselinux/include/selinux/get_context_list.h	25 May 2004 14:21:31 -0000
>@@ -4,6 +4,8 @@
> #include <selinux/selinux.h>
> 
> #define _DEFCONTEXT_PATH "/etc/security/default_contexts"
>+#define _DEFCONTEXT_USER_PATH "/etc/security/default_contexts.user"
>+#define _DEFCONTEXT_USER_PATH_FORCE "/etc/security/default_contexts.user/.force"
> #define _FAILSAFECONTEXT_PATH "/etc/security/failsafe_context"
> #define SELINUX_DEFAULTUSER "user_u"
> 
>Index: libselinux/src/get_context_list.c
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/get_context_list.c,v
>retrieving revision 1.15
>diff -u -r1.15 get_context_list.c
>--- libselinux/src/get_context_list.c	16 Apr 2004 19:22:24 -0000	1.15
>+++ libselinux/src/get_context_list.c	25 May 2004 14:26:48 -0000
>@@ -213,8 +213,20 @@
>     int retval;           /* The return value                          */
>     long buflen;
> 
>-    if (which == USERPRIORITY)
>-    {
>+    if (which == USERPRIORITY) {
>+        /* Check for an admin-defined per-user default_contexts file first. */
>+        fname_len = sizeof(_DEFCONTEXT_USER_PATH) + strlen(user) + 1;
>+        fname = malloc (fname_len);
>+        if (!fname) 
>+            return -1;
>+        sprintf (fname, "%s/%s", _DEFCONTEXT_USER_PATH, user);
>+        config_file = fopen (fname, "r");
>+	free (fname);
>+	/* If the admin has created a per-user default_contexts file or 
>+	   the admin has created .force file, then do not attempt to 
>+	   open a $HOME/.default_contexts file for the user. */
>+	if (config_file || (access(_DEFCONTEXT_USER_PATH_FORCE, F_OK) == 0))
>+		goto out;
>         /* Get the password structure in order to find the home directory.
> 	   Use getpwnam_r to avoid clobbering any existing pwd struct obtained
> 	   by the caller. */
>@@ -263,6 +275,7 @@
>         return -1;
>     }
> 
>+out:
>     if (!config_file)
>     {
>         return -1;
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
