Message-ID: <791924EBDA572C4FA970D4A94AA95DA309E516@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@tcs-sec.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson
	 <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   Daniel J Walsh
	 <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>
Subject: RE: [Announce][Patch] Enhanced MLS support
Date: Wed, 3 Mar 2004 15:24:35 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4015D.8B9AC9A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4015D.8B9AC9A0
Content-Type: text/plain;
	charset="iso-8859-1"


Here is a version of the init patch with Steve's suggested fixes.



-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Wednesday, March 03, 2004 9:32 AM
To: Chad Hanson
Cc: SE Linux (E-mail); Daniel J Walsh; James Morris
Subject: Re: [Announce][Patch] Enhanced MLS support


On Tue, 2004-03-02 at 14:44, Chad Hanson wrote:
> Attached are patches to enable the detection of MLS on a SELinux system. 
> 
> This consists of an mls object inside of selinuxfs (/selinux/mls), a
library
> call for libselinux (is_selinux_mls_enabled()), and application patches
for
> pam and init. The init patch enables loading of MLS or non-MLS policy
> depending on kernel configuration. The pam patch will ask for the MLS
level
> if a default context is not found.

The init and pam patches will need to go to Dan (cc'd above) for
inclusion after we have released a libselinux that includes
is_selinux_mls_enabled().  This can happen independently of the kernel
support getting into the Fedora kernel, as is_selinux_mls_enabled() will
return 0 if /selinux/mls doesn't exist at all.  With regard to the init
patch, it would likely be cleaner to bracket the snprintf with your test
of is_selinux_mls_enabled() and print the entire version string
(including -mls suffix if appropriate) once to the policy_file buffer;
the separate strncat could theoretically overflow the buffer and is
wasteful anyway (having to walk the string again).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


------_=_NextPart_000_01C4015D.8B9AC9A0
Content-Type: application/octet-stream;
	name="sysvinit-selinux-tcs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sysvinit-selinux-tcs.patch"

--- sysvinit-2.85/src/init.c.selinux-tcs	2004-02-27 18:53:07.000000000 =
-0600=0A=
+++ sysvinit-2.85/src/init.c	2004-03-03 14:01:25.000000000 -0600=0A=
@@ -120,12 +120,21 @@=0A=
   } =0A=
   *enforce=3Drc;=0A=
 =0A=
-  =
snprintf(policy_file,sizeof(policy_file),"%s.%d",SELINUXPOLICY,policy_ve=
rsion);=0A=
+  /* Append MLS if needed */=0A=
+  if (is_selinux_mls_enabled())=0A=
+    =
snprintf(policy_file,sizeof(policy_file),"%s.%d-mls",SELINUXPOLICY,polic=
y_version);=0A=
+  else=0A=
+    =
snprintf(policy_file,sizeof(policy_file),"%s.%d",SELINUXPOLICY,policy_ve=
rsion);=0A=
+=0A=
   fd =3D open(policy_file, O_RDONLY);=0A=
   if (fd < 0) {=0A=
     /* Check previous version to see if old policy is available=0A=
      */=0A=
-    =
snprintf(policy_file,sizeof(policy_file),"%s.%d",SELINUXPOLICY,policy_ve=
rsion-1);=0A=
+    /* Append MLS if needed */=0A=
+    if (is_selinux_mls_enabled())=0A=
+      =
snprintf(policy_file,sizeof(policy_file),"%s.%d-mls",SELINUXPOLICY,polic=
y_version-1);=0A=
+    else=0A=
+      =
snprintf(policy_file,sizeof(policy_file),"%s.%d",SELINUXPOLICY,policy_ve=
rsion-1);=0A=
     fd =3D open(policy_file, O_RDONLY);=0A=
     if (fd < 0) {=0A=
       log(L_VB,  "Can't open '%s.%d':  %s\n",=0A=

------_=_NextPart_000_01C4015D.8B9AC9A0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
