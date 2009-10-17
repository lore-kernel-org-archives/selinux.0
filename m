Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9H0F35O020808
	for <selinux@tycho.nsa.gov>; Fri, 16 Oct 2009 20:15:03 -0400
Received: from mail-vw0-f188.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9H0EAdP018157
	for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 00:14:11 GMT
Received: by vws26 with SMTP id 26so1180654vws.32
        for <selinux@tycho.nsa.gov>; Fri, 16 Oct 2009 17:15:02 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 16 Oct 2009 17:15:01 -0700
Message-ID: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
Subject: sshd error: Failed to get default security context
From: Larry Ross <selinux.larry@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e648064456dead04761667c0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e648064456dead04761667c0
Content-Type: text/plain; charset=ISO-8859-1

I have created a custom selinux user for the strict policy on RHEL5.3 who's
purpose is to connect via ssh and scp files off the machine.  When that user
tries to login via ssh, I see the following messages in /var/log/secure:

In enforcing:
Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser
from 192.168.1.1 port 64680 ssh2
Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get default security
context for scpuser.
Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux failure. Aborting
connection.

In permissive:
Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser from
192.168.1.1 port 56254 ssh2
Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get default security
context for scpuser.
Oct 16 07:55:59 localhost sshd[23302]: error: SELinux failure. Continuing in
permissive mode.

Could someone explain what these messages mean?

I believe that I have a default context defined in the "default context"
file that should work. I believe I have an executable context available for
this user (using rbash rather than bash).

How is sshd making this decision?  It looks like it is calling setexeccon,
but I'm not sure how that makes its decision.  Where should I look for clues
as to how to fix it?

   Thank you,
   Larry

--0016e648064456dead04761667c0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I have created a custom selinux user for the strict policy on RHEL5.3 =
who&#39;s purpose is to connect via ssh and scp files off the machine.=A0 W=
hen that user tries to login via ssh, I see the following messages in /var/=
log/secure:</div>

<div>=A0</div>
<div>In enforcing:</div>
<div>Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser f=
rom=A0192.168.1.1 port 64680 ssh2<br>Oct 16 07:49:40 localhost sshd[20461]:=
 error: Failed to get default security context for scpuser.<br>Oct 16 07:49=
:40 localhost sshd[20461]: fatal: SELinux failure. Aborting connection.</di=
v>

<div>=A0</div>
<div>In permissive:</div>
<div>Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser f=
rom 192.168.1.1 port 56254 ssh2<br>Oct 16 07:55:59 localhost sshd[23302]: e=
rror: Failed to get default security context for scpuser.<br>Oct 16 07:55:5=
9 localhost sshd[23302]: error: SELinux failure. Continuing in permissive m=
ode.<br>
</div>
<div>=A0</div>
<div>Could someone explain what these messages mean?=A0 </div>
<div>=A0</div>
<div>I believe that I have a default context defined in the &quot;default c=
ontext&quot; file that should work. I believe I have an executable context =
available for this user (using rbash rather than bash).</div>
<div>=A0</div>
<div>How is sshd making this decision?=A0 It looks like it is calling setex=
eccon, but I&#39;m not sure how that makes its decision.=A0 Where should I =
look for clues as to how to fix it?</div>
<div>=A0</div>
<div>=A0=A0 Thank you,</div>
<div>=A0=A0 Larry</div>

--0016e648064456dead04761667c0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
