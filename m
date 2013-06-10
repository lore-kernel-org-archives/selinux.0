Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5AEFmSV021977
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2013 10:15:48 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so3078839wiv.1
        for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2013 07:15:48 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 10 Jun 2013 07:15:48 -0700
Message-ID: <CAHhDTVmA_3SgoLw-ntFaKGC9m9KxrTCbNFyVQ9dy-CtkpjyvjQ@mail.gmail.com>
Subject: use case
From: Franck <franck.quinard@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c32b46c9564704decd6a1d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001a11c32b46c9564704decd6a1d
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I'm trying to see if the following scenario is something that can be deal
with selinux.

I have a daemon that start multiple identical processes ( let's call them
"agent", and let's say we have 2 of them, but we could as well have 256).
Those processes are there so remote client can start other processes. I
want those processes to be able to read from one location (the binaries of
what they are running) but also to read/write in some specific directories.
Of course, agent A and agent B should not be able to interact between each
other directly (they could using some tcp/http protocol) or read/write
files that are not theirs.

I was thinking of transiting from the agent domain to the client
application domain using a transient domain that would be automatically
generated and unique, but did not see anything like that.

If you have other ideas to do that, w/o selinux, I'm open to anything :)

thank you,

Franck

--001a11c32b46c9564704decd6a1d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I&#39;m trying to see=
 if the following scenario is something that can be deal with selinux.=A0</=
div><div><br></div><div>I have a daemon that start multiple identical proce=
sses ( let&#39;s call them &quot;agent&quot;, and let&#39;s say we have 2 o=
f them, but we could as well have 256). Those processes are there so remote=
 client can start other processes. I want those processes to be able to rea=
d from one location (the binaries of what they are running) but also to rea=
d/write in some specific directories. Of course, agent A and agent B should=
 not be able to interact between each other directly (they could using some=
 tcp/http protocol) or read/write files that are not theirs.</div>
<div><br></div><div style>I was thinking of transiting from the agent domai=
n to the client application domain using a transient domain that would be a=
utomatically generated and unique, but did not see anything like that.=A0</=
div>
<div style><br></div><div style>If you have other ideas to do that, w/o sel=
inux, I&#39;m open to anything :)</div><div style><br></div><div style>than=
k you,</div><div style><br></div><div style>Franck</div></div>

--001a11c32b46c9564704decd6a1d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
