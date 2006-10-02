Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92Lgod6024638
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 17:42:52 -0400
Received: from aplesnation.dom1.jhuapl.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k92Lff7Y019776
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 21:41:41 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E666.C2490EC3"
Subject: init unconfined in RHEL4?
Date: Mon, 2 Oct 2006 17:07:24 -0400
Message-ID: <7B95239DDD54E54B9BFA23847142B1EE10A29E@aplesnation.dom1.jhuapl.edu>
References: <7B95239DDD54E54B9BFA23847142B1EE10A28A@aplesnation.dom1.jhuapl.edu>
From: "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6E666.C2490EC3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm working on a RHEL4 system with the Reference Policy and init is =
running in unconfined_t.  This leads to most other processes on the =
system running in unconfined_t.  Has anyone seen similar errors?

This is the Ref. Policy version released in March, I got the latest svn =
version but it doesn't work with the libsepol and checkpolicy RHEL4 RPMs =
on the Tresys site.

I'm also having a strange error where I get denied messages saying =
something was trying to access a file with context unlabeled_t when `ls =
-Z` shows the file is clearly labeled something else.

Has anyone seen similar things on RHEL4?

Thanks,
Justin

P.S. I managed to get my template working, many thanks to Dave Caplan.

-----Original Message-----
From: Osborn, Justin D.
Sent: Mon 9/25/2006 10:09 AM
To: selinux@tycho.nsa.gov
Subject: Errors with runcon - RHEL4/refpolicy
=20
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








------_=_NextPart_001_01C6E666.C2490EC3
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
<TITLE>init unconfined in RHEL4?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I'm working on a RHEL4 system with the Reference =
Policy and init is running in unconfined_t.&nbsp; This leads to most =
other processes on the system running in unconfined_t.&nbsp; Has anyone =
seen similar errors?<BR>
<BR>
This is the Ref. Policy version released in March, I got the latest svn =
version but it doesn't work with the libsepol and checkpolicy RHEL4 RPMs =
on the Tresys site.<BR>
<BR>
I'm also having a strange error where I get denied messages saying =
something was trying to access a file with context unlabeled_t when `ls =
-Z` shows the file is clearly labeled something else.<BR>
<BR>
Has anyone seen similar things on RHEL4?<BR>
<BR>
Thanks,<BR>
Justin<BR>
<BR>
P.S. I managed to get my template working, many thanks to Dave =
Caplan.<BR>
<BR>
-----Original Message-----<BR>
From: Osborn, Justin D.<BR>
Sent: Mon 9/25/2006 10:09 AM<BR>
To: selinux@tycho.nsa.gov<BR>
Subject: Errors with runcon - RHEL4/refpolicy<BR>
<BR>
Hi everybody,<BR>
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
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6E666.C2490EC3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
