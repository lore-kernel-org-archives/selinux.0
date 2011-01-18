Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0II3r1g015624
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2011 13:03:53 -0500
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0II3q1v017158
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2011 18:03:52 GMT
Received: by gwb10 with SMTP id 10so2569351gwb.12
        for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2011 10:03:52 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 18 Jan 2011 13:03:50 -0500
Message-ID: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
Subject: SELinux role separation
From: Qwyjibo Jones <qwyjibojones@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf30433dde0c4c7e049a22b929
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf30433dde0c4c7e049a22b929
Content-Type: text/plain; charset=ISO-8859-1

I am currently working with an Itanium2 system which has RHEL 5.3 MLS
installed.
I am trying to understand how separation of roles works in SELinux/MLS
policy version 21. We have been told that we need to separate roles that the
sys admin is no longer allowed to do.

After reading through these threads, in the archives I am still wondering
about a couple things:

http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082

And this one:
http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml

1) Is the RHEL 5.x MLS policy version 21 capable of the following separation
of sysadm_r and secadm_r roles:

   a) Can the secadm_r role be the only role that can assign roles via
semanage?

   b) Can the secadm_r role be the only role that can assign/modify network
interface labels via semanage?

   c) Can the secadm_r role be the only role that can control files used in
auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...

2) Is this better accomplished with a combination of SUDO and SELinux?
3) How can I determine what secadm_r can do in the current configuration?
can any of the CLI tools show me that? ( no gui tools available )

If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to
Itanium systems, but we may have new hardware soon)

Any tips. hints, pointers etc... would be very helpfull.

Thanks for your time,

--20cf30433dde0c4c7e049a22b929
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>I am currently working with an Itanium2 system which has RHEL 5.3 MLS i=
nstalled.<br>I am trying to understand how separation of roles works in SEL=
inux/MLS policy version 21. We have been told that we need to separate role=
s that the sys admin is no longer allowed to do.<br>

<br>After reading through these threads, in the archives I am still wonderi=
ng about a couple things:<br>


<br><a href=3D"http://www.nsa.gov/research/selinux/list-archive/0504/thread=
_body66.shtml#11082" target=3D"_blank">http://www.nsa.gov/research/selinux/=
list-archive/0504/thread_body66.shtml#11082</a><br><br>And this one: <br><a=
 href=3D"http://www.nsa.gov/research/selinux/list-archive/0802/thread_body6=
0.shtml" target=3D"_blank">http://www.nsa.gov/research/selinux/list-archive=
/0802/thread_body60.shtml</a><br>




<br>1) Is the RHEL 5.x MLS policy version 21 capable of the following separ=
ation of sysadm_r and secadm_r roles:<br><br>=A0=A0 a) Can the secadm_r rol=
e be the only role that can assign roles via semanage? <br>
<br>=A0=A0
b) Can the secadm_r role be the only role that can assign/modify network in=
terface labels via semanage?<br>
<br>=A0=A0 c) Can the secadm_r role be the only role that can control files=
=20
used in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd=20
etc...<br><br>2) Is this better accomplished with a combination of SUDO and=
 SELinux?<br>
3) How can I determine what secadm_r can do in the current=20
configuration? can any of the CLI tools show me that? ( no gui tools=20
available )<br>
<br>If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to I=
tanium systems, but we may have new hardware soon)<br><br>Any tips. hints, =
pointers etc... would be very helpfull.<br>
<br>Thanks for your time,

--20cf30433dde0c4c7e049a22b929--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
