Message-ID: <791924EBDA572C4FA970D4A94AA95DA309E3CE@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@tcs-sec.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson
	 <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   James Morris
	 <jmorris@redhat.com>
Subject: RE: [Announce][Patch] Enhanced MLS support
Date: Tue, 2 Mar 2004 16:33:22 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4009D.FC9D4FD0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4009D.FC9D4FD0
Content-Type: text/plain;
	charset="iso-8859-1"


I have attached a new version of the library function utilizing selinuxmnt.

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Tuesday, March 02, 2004 2:34 PM
To: Chad Hanson
Cc: SE Linux (E-mail); James Morris
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

Thanks for working on this.  With regard to the libselinux function,
note that the other libselinux functions have been converted to obtain
the selinuxfs mount point from selinux_mnt (determined at runtime by
libselinux/src/init.c:init_selinuxmnt()) rather than compiling in a
fixed location.  That allows the selinuxfs mount point to be easily
changed without affecting any package other than SysVinit.  There has
been prior discussion of moving the selinuxfs mount point from /selinux
to a better location, so we want to prepare for such a transition.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


------_=_NextPart_000_01C4009D.FC9D4FD0
Content-Type: application/octet-stream;
	name="libselinux_1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libselinux_1.patch"

--- libselinux/src/enabled.c	2004-03-02 15:27:40.000000000 -0600=0A=
+++ libselinux/src/enabled.c	2004-03-02 15:18:37.000000000 -0600=0A=
@@ -51,4 +51,30 @@=0A=
 	return enabled;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Function: is_selinux_mls_enabled()=0A=
+ * Return:   1 on success=0A=
+ *	     0 on failure=0A=
+ */=0A=
+int is_selinux_mls_enabled(void)=0A=
+{=0A=
+	char buf[20], path[PATH_MAX];=0A=
+	int fd, ret, enabled =3D 0;=0A=
 =0A=
+	snprintf(path, sizeof path, "%s/mls", selinux_mnt);=0A=
+	fd =3D open(path, O_RDONLY);=0A=
+	if (fd < 0)=0A=
+		return enabled;=0A=
+=0A=
+	memset(buf, 0, sizeof buf);=0A=
+=0A=
+	ret =3D read(fd, buf, sizeof buf-1);=0A=
+	close(fd);=0A=
+	if (ret < 0)=0A=
+		return enabled;=0A=
+=0A=
+	if (!strcmp(buf, "1"))=0A=
+		enabled =3D 1;=0A=
+=0A=
+	return enabled;=0A=
+}=0A=

------_=_NextPart_000_01C4009D.FC9D4FD0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
