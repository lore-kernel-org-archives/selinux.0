Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5K1XYRI030837
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2008 21:33:34 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5K1XX6n021255
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 01:33:34 GMT
Received: by fg-out-1718.google.com with SMTP id 16so518726fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2008 18:33:32 -0700 (PDT)
Message-ID: <cadfc0e40806191533j265e146q2070b19d2bcd10d@mail.gmail.com>
Date: Thu, 19 Jun 2008 17:33:12 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>
Subject: x_extension use
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing a number of AVCs out of gnome applications for a range of X
extensions. Now I wondering about allowing access to X extensions. In
general should apps be able to use any extension or are there specific
one that need greater access control?

type=USER_AVC msg=audit(1213883752.209:892): user pid=23989 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { use } for request=RANDR:QueryVersion comm=gnome-session
extension=RANDR scontext=user_u:user_r:user_t:s0
tcontext=system_u:object_r:output_xext_t:s0 tclass=x_extension :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1213883755.647:918): user pid=23989 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { use } for request=XFree86-VidModeExtension:QueryVersion
comm=gnome-screensaver extension=XFree86-VidModeExtension
scontext=user_u:user_r:user_t:s0
tcontext=system_u:object_r:directhw_xext_t:s0 tclass=x_extension :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1213883796.665:934): user pid=23989 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { use } for request=DPMS:Capable comm=gnome-power-manager
extension=DPMS scontext=user_u:user_r:user_t:s0
tcontext=system_u:object_r:screensaver_xext_t:s0 tclass=x_extension :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1213884106.649:948): user pid=23989 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { use } for request=XFree86-Misc:SetGrabKeysState
comm=gnome-screensaver extension=XFree86-Misc
scontext=user_u:user_r:user_t:s0 tcontext=system_u:object_r:xext_t:s0
tclass=x_extension : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
terminal=?)'
type=USER_AVC msg=audit(1213889695.688:955): user pid=23989 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { use } for request=GLX:QueryVersion
comm=/usr/libexec/gnome-screensaver-gl-helper extension=GLX
scontext=user_u:user_r:user_t:s0
tcontext=system_u:object_r:accelgraphics_xext_t:s0 tclass=x_extension
: exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
