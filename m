Message-ID: <791924EBDA572C4FA970D4A94AA95DA309E3BA@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@tcs-sec.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: [Announce][Patch] Enhanced MLS support
Date: Tue, 2 Mar 2004 14:44:18 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4008E.C096C980"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4008E.C096C980
Content-Type: text/plain;
	charset="iso-8859-1"


Attached are patches to enable the detection of MLS on a SELinux system. 

This consists of an mls object inside of selinuxfs (/selinux/mls), a library
call for libselinux (is_selinux_mls_enabled()), and application patches for
pam and init. The init patch enables loading of MLS or non-MLS policy
depending on kernel configuration. The pam patch will ask for the MLS level
if a default context is not found.

-Chad

_______________________________________________________________
Chad Hanson				mailto:chanson@tcs-sec.com
Trusted Computer Solutions		Phone: 217-384-0028 x12
121 W Goose Alley			Fax: 217-384-0288
Urbana IL 61801

 <<linux-2.6.3_mls.patch>>  <<libselinux.patch>>  
<<sysvinit-selinux-tcs.patch>>  <<pam-selinux-tcs.patch>> 

------_=_NextPart_000_01C4008E.C096C980
Content-Type: application/octet-stream;
	name="linux-2.6.3_mls.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.6.3_mls.patch"

*** linux-2.6.3/security/selinux/include/security.h	2004-02-25 =
14:33:46.000000000 -0600=0A=
--- linux-2.6.3/security/selinux/include/security.h	2004-02-25 =
15:38:27.000000000 -0600=0A=
***************=0A=
*** 24,29 ****=0A=
--- 24,35 ----=0A=
  #define selinux_enabled 1=0A=
  #endif=0A=
  =0A=
+ #ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
+ #define selinux_mls_enabled 1=0A=
+ #else=0A=
+ #define selinux_mls_enabled 0=0A=
+ #endif=0A=
+ =0A=
  int security_load_policy(void * data, size_t len);=0A=
  =0A=
  struct av_decision {=0A=
*** linux-2.6.3/security/selinux/selinuxfs.c	2004-02-25 =
14:33:46.000000000 -0600=0A=
--- linux-2.6.3/security/selinux/selinuxfs.c	2004-03-01 =
15:58:15.000000000 -0600=0A=
***************=0A=
*** 61,67 ****=0A=
  	SEL_RELABEL,	/* compute relabeling decision */=0A=
  	SEL_USER,	/* compute reachable user contexts */=0A=
  	SEL_POLICYVERS,	/* return policy version for this kernel */=0A=
! 	SEL_COMMIT_BOOLS=0A=
  };=0A=
  =0A=
  static ssize_t sel_read_enforce(struct file *filp, char *buf,=0A=
--- 61,68 ----=0A=
  	SEL_RELABEL,	/* compute relabeling decision */=0A=
  	SEL_USER,	/* compute reachable user contexts */=0A=
  	SEL_POLICYVERS,	/* return policy version for this kernel */=0A=
! 	SEL_COMMIT_BOOLS,=0A=
! 	SEL_MLS		/* return if MLS policy is enabled */=0A=
  };=0A=
  =0A=
  static ssize_t sel_read_enforce(struct file *filp, char *buf,=0A=
***************=0A=
*** 193,198 ****=0A=
--- 194,239 ----=0A=
  /* declaration for sel_write_load */=0A=
  static int sel_make_bools(void);=0A=
  =0A=
+ static ssize_t sel_read_mls(struct file *filp, char *buf,=0A=
+ 				size_t count, loff_t *ppos)=0A=
+ {=0A=
+ 	char *page;=0A=
+ 	ssize_t length;=0A=
+ 	ssize_t end;=0A=
+ =0A=
+ 	if (count < 0 || count > PAGE_SIZE)=0A=
+ 		return -EINVAL;=0A=
+ 	if (!(page =3D (char*)__get_free_page(GFP_KERNEL)))=0A=
+ 		return -ENOMEM;=0A=
+ 	memset(page, 0, PAGE_SIZE);=0A=
+ =0A=
+ 	length =3D snprintf(page, PAGE_SIZE, "%d", selinux_mls_enabled);=0A=
+ 	if (length < 0) {=0A=
+ 		free_page((unsigned long)page);=0A=
+ 		return length;=0A=
+ 	}=0A=
+ =0A=
+ 	if (*ppos >=3D length) {=0A=
+ 		free_page((unsigned long)page);=0A=
+ 		return 0;=0A=
+ 	}=0A=
+ 	if (count + *ppos > length)=0A=
+ 		count =3D length - *ppos;=0A=
+ 	end =3D count + *ppos;=0A=
+ 	if (copy_to_user(buf, (char *) page + *ppos, count)) {=0A=
+ 		count =3D -EFAULT;=0A=
+ 		goto out;=0A=
+ 	}=0A=
+ 	*ppos =3D end;=0A=
+ out:=0A=
+ 	free_page((unsigned long)page);=0A=
+ 	return count;=0A=
+ }=0A=
+ =0A=
+ static struct file_operations sel_mls_ops =3D {=0A=
+ 	.read		=3D sel_read_mls,=0A=
+ };=0A=
+ =0A=
  static ssize_t sel_write_load(struct file * file, const char * =
buf,=0A=
  			      size_t count, loff_t *ppos)=0A=
  =0A=
***************=0A=
*** 963,968 ****=0A=
--- 1004,1010 ----=0A=
  		[SEL_USER] =3D {"user", &transaction_ops, S_IRUGO|S_IWUGO},=0A=
  		[SEL_POLICYVERS] =3D {"policyvers", &sel_policyvers_ops, =
S_IRUGO},=0A=
  		[SEL_COMMIT_BOOLS] =3D {"commit_pending_bools", =
&sel_commit_bools_ops, S_IWUSR},=0A=
+ 		[SEL_MLS] =3D {"mls", &sel_mls_ops, S_IRUGO},=0A=
  		/* last one */ {""}=0A=
  	};=0A=
  	ret =3D simple_fill_super(sb, SELINUX_MAGIC, selinux_files);=0A=

------_=_NextPart_000_01C4008E.C096C980
Content-Type: application/octet-stream;
	name="libselinux.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libselinux.patch"

*** libselinux/src/enabled.c	2004-02-25 15:07:34.000000000 -0600=0A=
--- libselinux/src/enabled.c	2004-02-27 18:06:03.000000000 -0600=0A=
***************=0A=
*** 51,54 ****=0A=
--- 51,90 ----=0A=
  	return enabled;=0A=
  }=0A=
  =0A=
+ /*=0A=
+  * Function: is_selinux_mls_enabled()=0A=
+  * Return:   1 on success=0A=
+  *	     0 on failure=0A=
+  */=0A=
+ int is_selinux_mls_enabled(void)=0A=
+ {=0A=
+ 	char *buf;=0A=
+ 	size_t size;=0A=
+ 	int fd;=0A=
+ 	ssize_t ret;=0A=
+ 	int enabled =3D 0;=0A=
  =0A=
+ 	fd =3D open(SELINUXMNT "mls", O_RDONLY);=0A=
+ 	if (fd < 0)=0A=
+ 		return enabled;=0A=
+ =0A=
+ 	size =3D PAGE_SIZE;=0A=
+ 	buf =3D malloc(size);=0A=
+ 	if (!buf)=0A=
+ 		goto out;=0A=
+ 		=0A=
+ 	memset(buf, 0, size);=0A=
+ =0A=
+ 	ret =3D read(fd, buf, size - 1);=0A=
+ 	if (ret < 0)=0A=
+ 		goto out2;=0A=
+ =0A=
+ 	if (!strcmp(buf, "1"))=0A=
+ 		enabled =3D 1;=0A=
+ =0A=
+ out2:=0A=
+ 	free(buf);=0A=
+ out:=0A=
+ 	close(fd);=0A=
+ 	return enabled;=0A=
+ }=0A=
*** libselinux/src/query_user_context.c	2004-02-25 15:07:34.000000000 =
-0600=0A=
--- libselinux/src/query_user_context.c	2004-02-27 18:06:03.000000000 =
-0600=0A=
***************=0A=
*** 118,124 ****=0A=
      int  typelen =3D 100;=0A=
      char level[100];       /* The level requested by the user         =
*/=0A=
      int  levellen =3D 100;=0A=
!     int mls_enabled =3D 0;=0A=
  =0A=
      context_t new_context;     /* The new context chosen by the user  =
   */=0A=
      char *user_context =3D NULL; /* String value of the user's =
context     */=0A=
--- 118,124 ----=0A=
      int  typelen =3D 100;=0A=
      char level[100];       /* The level requested by the user         =
*/=0A=
      int  levellen =3D 100;=0A=
!     int mls_enabled =3D is_selinux_mls_enabled();=0A=
  =0A=
      context_t new_context;     /* The new context chosen by the user  =
   */=0A=
      char *user_context =3D NULL; /* String value of the user's =
context     */=0A=
*** libselinux/include/selinux/selinux.h	2004-02-25 15:07:34.000000000 =
-0600=0A=
--- libselinux/include/selinux/selinux.h	2004-02-27 18:06:03.000000000 =
-0600=0A=
***************=0A=
*** 5,10 ****=0A=
--- 5,12 ----=0A=
  =0A=
  /* Return 1 if we are running on a SELinux kernel, or 0 otherwise. =
*/=0A=
  extern int is_selinux_enabled(void);=0A=
+ /* Return 1 if we are running on a SELinux MLS kernel, or 0 =
otherwise. */=0A=
+ extern int is_selinux_mls_enabled(void);=0A=
  =0A=
  typedef char* security_context_t;=0A=
  =0A=
*** libselinux/utils/selinuxmlsenabled.c	1969-12-31 18:00:00.000000000 =
-0600=0A=
--- libselinux/utils/selinuxmlsenabled.c	2004-03-01 16:07:00.000000000 =
-0600=0A=
***************=0A=
*** 0 ****=0A=
--- 1,9 ----=0A=
+ #include <unistd.h>=0A=
+ #include <stdio.h>=0A=
+ #include <stdlib.h>=0A=
+ #include <selinux/selinux.h>=0A=
+ =0A=
+ int main(void) =0A=
+ {=0A=
+ 	return !is_selinux_mls_enabled();=0A=
+ }=0A=

------_=_NextPart_000_01C4008E.C096C980
Content-Type: application/octet-stream;
	name="sysvinit-selinux-tcs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sysvinit-selinux-tcs.patch"

*** sysvinit-2.85/src/init.c.selinux-tcs	2004-02-27 18:40:28.000000000 =
-0600=0A=
--- sysvinit-2.85/src/init.c	2004-02-27 18:50:38.000000000 -0600=0A=
***************=0A=
*** 121,131 ****=0A=
--- 121,140 ----=0A=
    *enforce=3Drc;=0A=
  =0A=
    =
snprintf(policy_file,sizeof(policy_file),"%s.%d",SELINUXPOLICY,policy_ve=
rsion);=0A=
+   /* Append MLS if needed */=0A=
+   if (is_selinux_mls_enabled()) {=0A=
+     strncat(policy_file, "-mls", 4);=0A=
+   }=0A=
+ =0A=
    fd =3D open(policy_file, O_RDONLY);=0A=
    if (fd < 0) {=0A=
      /* Check previous version to see if old policy is available=0A=
       */=0A=
      =
snprintf(policy_file,sizeof(policy_file),"%s.%d",SELINUXPOLICY,policy_ve=
rsion-1);=0A=
+     /* Append MLS if needed */=0A=
+     if (is_selinux_mls_enabled()) {=0A=
+       strncat(policy_file, "-mls", 4);=0A=
+     }=0A=
      fd =3D open(policy_file, O_RDONLY);=0A=
      if (fd < 0) {=0A=
        log(L_VB,  "Can't open '%s.%d':  %s\n",=0A=

------_=_NextPart_000_01C4008E.C096C980
Content-Type: application/octet-stream;
	name="pam-selinux-tcs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pam-selinux-tcs.patch"

*** Linux-PAM-0.77/modules/pam_selinux/pam_selinux.c.selinux-tcs	=
2004-03-01 08:47:10.000000000 -0600=0A=
--- Linux-PAM-0.77/modules/pam_selinux/pam_selinux.c	2004-03-01 =
09:20:53.000000000 -0600=0A=
***************=0A=
*** 144,149 ****=0A=
--- 144,152 ----=0A=
  {=0A=
    struct pam_conv *conv;=0A=
    security_context_t newcon;=0A=
+   context_t new_context;=0A=
+   int mls_enabled =3D is_selinux_mls_enabled();=0A=
+ =0A=
    if (pam_get_item(pamh, PAM_CONV, (const void**) &conv) =3D=3D =
PAM_SUCCESS) {=0A=
      if (conv->conv !=3D NULL) {=0A=
        struct pam_response *responses;=0A=
***************=0A=
*** 151,157 ****=0A=
  	query_response(conv,_("Would you like to enter a security context? =
[y] "),&responses,debug);=0A=
  	if ((responses[0].resp[0] =3D=3D 'y') || (responses[0].resp[0] =
=3D=3D 'Y') || responses[0].resp[0]=3D=3D'\0')	=0A=
  	{=0A=
! 	  context_t new_context =3D context_new ("user:role:type");=0A=
  	  /* Allow the user to enter each field of the context individually =
*/=0A=
  	  if (context_user_set (new_context, user))=0A=
  	    {=0A=
--- 154,164 ----=0A=
  	query_response(conv,_("Would you like to enter a security context? =
[y] "),&responses,debug);=0A=
  	if ((responses[0].resp[0] =3D=3D 'y') || (responses[0].resp[0] =
=3D=3D 'Y') || responses[0].resp[0]=3D=3D'\0')	=0A=
  	{=0A=
! 	  if (mls_enabled)=0A=
! 	    new_context =3D context_new ("user:role:type:level");=0A=
! 	  else=0A=
! 	    new_context =3D context_new ("user:role:type");=0A=
! 	=0A=
  	  /* Allow the user to enter each field of the context individually =
*/=0A=
  	  if (context_user_set (new_context, user))=0A=
  	    {=0A=
***************=0A=
*** 170,175 ****=0A=
--- 177,191 ----=0A=
  	      context_free (new_context);=0A=
  	      return NULL;=0A=
  	    }=0A=
+ 	  if (mls_enabled)=0A=
+ 	    {=0A=
+ 	      query_response(conv,_("level: "),&responses,debug);=0A=
+ 	      if (context_range_set (new_context, responses[0].resp))=0A=
+ 	        {=0A=
+ 	          context_free (new_context);=0A=
+ 	          return NULL;=0A=
+ 	        }=0A=
+ 	    }=0A=
  	  /* Get the string value of the context and see if it is valid. =
*/=0A=
  	  if (!security_check_context(context_str(new_context))) {=0A=
  	    newcon =3D strdup(context_str(new_context));=0A=

------_=_NextPart_000_01C4008E.C096C980--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
