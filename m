Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PE9EFC013451
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 10:09:14 -0400
Received: from aplesnation.dom1.jhuapl.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PE8B2d007567
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 14:08:12 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E0AC.2DB82B8B"
Subject: Errors with runcon - RHEL4/refpolicy
Date: Mon, 25 Sep 2006 10:09:13 -0400
Message-ID: <7B95239DDD54E54B9BFA23847142B1EE10A28A@aplesnation.dom1.jhuapl.edu>
From: "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6E0AC.2DB82B8B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everybody,
      I'm working on a project to do containment of VMware VMs using =
SELinux policy.  Our system is set up on RHEL4 and I have the Reference =
Policy installed. =20

      We're trying to reuse the VMware policy that was originally =
distributed with the Reference Policy.  Specifically there is a =
per-user-domain template that we modified for our use and instantiate =
from another te file.  The policy compiles and our VMs are properly =
labeled after relabeling.

     The problem is that when I try to kick off a VM using runcon, I get =
the non-descript "unable to setup security context" error.  The command =
I'm running is: runcon root:system_r:ziplock_vm1_vmware_t vmware-cmd =
start /VMs/foo.vmx.  My bash shell is running as =
root:system_r:unconfined_t.  I added my types to system_r and verified =
with apol.

     So my questions are:
     a) Why was the VMware policy renoved from the Reference Policy?
     b) What am I missing with the runcon error?  Is there somewhere I =
can look for a more descriptive error message?

Thanks,
Justin
JHU/APL






------_=_NextPart_001_01C6E0AC.2DB82B8B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.3">
<TITLE>Errors with runcon - RHEL4/refpolicy</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi everybody,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I'm working on a project to do =
containment of VMware VMs using SELinux policy.&nbsp; Our system is set =
up on RHEL4 and I have the Reference Policy installed.&nbsp;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We're trying to reuse the VMware policy =
that was originally distributed with the Reference Policy.&nbsp; =
Specifically there is a per-user-domain template that we modified for =
our use and instantiate from another te file.&nbsp; The policy compiles =
and our VMs are properly labeled after relabeling.<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp; The problem is that when I try to kick off a VM =
using runcon, I get the non-descript &quot;unable to setup security =
context&quot; error.&nbsp; The command I'm running is: runcon =
root:system_r:ziplock_vm1_vmware_t vmware-cmd start /VMs/foo.vmx.&nbsp; =
My bash shell is running as root:system_r:unconfined_t.&nbsp; I added my =
types to system_r and verified with apol.<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp; So my questions are:<BR>
&nbsp;&nbsp;&nbsp;&nbsp; a) Why was the VMware policy renoved from the =
Reference Policy?<BR>
&nbsp;&nbsp;&nbsp;&nbsp; b) What am I missing with the runcon =
error?&nbsp; Is there somewhere I can look for a more descriptive error =
message?<BR>
<BR>
Thanks,<BR>
Justin<BR>
JHU/APL<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6E0AC.2DB82B8B--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
