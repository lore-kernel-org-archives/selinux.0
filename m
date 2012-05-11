Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4BB5D1G000721
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 07:05:13 -0400
Received: by yhjj72 with SMTP id j72so2725859yhj.12
        for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 04:05:14 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 11 May 2012 15:05:14 +0400
Message-ID: <CAHx7xgW22yYYEgDR=tqomoS3AEOOwOc351d0+1WZNnbsv1rYVA@mail.gmail.com>
Subject: labeled NFS
From: zyxel <zyx1984@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8fb20228f54bef04bfc0b503
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8fb20228f54bef04bfc0b503
Content-Type: text/plain; charset=ISO-8859-1

Hello.

I have some questions about labeled NFS.
We have client and server systems running RHEL 6.1
Kernels for both client and server were downloaded from git://
git.selinuxproject.org/~dpquigl/lnfs
Kernel version is 2.6.32. and they are already patched to support labeled
NFS.
Server is configured to export NFS share. Nfs-utils on server are patched
for labeled nfs too.

Here is listing for server exports file:
/export *(rw,fsid=0,sec=unix,insecure,no_subtree_check,sync,security_label)

Client and server have the same MLS policy.

If I mount NFS share with command
 #mount -t nfs4 server:/ /mnt/nfsv4
everything works good, but when i try to mount the same share to another
directory
 #mount -t nfs4 server:/ /mnt/nfsv4_2
it fails with:

Message from syslogd@localhost at May 11 13:07:17 ...
kernel:Oops: 0000 [#1] SMP

Message from syslogd@localhost at May 11 13:07:17 ...
kernel:last sysfs file: /sys/devices/virtual/block/dm-0/dev

Message from syslogd@localhost at May 11 13:07:17 ...
kernel:Stack:

Why does it happens? Where I can get more information about that.

The second question is that maybe I don't need labeled NFS.
My task is to transfer security levels between client and server over NFS
so that client with security level s0, for example, couldn't get access to
file with level s1 on NFS share.
I don't know if it may be done with netlabel or something.
Could you help me a bit.

Andrei

--e89a8fb20228f54bef04bfc0b503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello. <br><br>I have some questions about labeled NFS.<br>We have client a=
nd server systems running RHEL 6.1<br>Kernels for both client and server we=
re downloaded from git://<a href=3D"http://git.selinuxproject.org/~dpquigl/=
lnfs">git.selinuxproject.org/~dpquigl/lnfs</a><br>
Kernel version is 2.6.32. and they are already patched to support labeled N=
FS.<br>Server is configured to export NFS share. Nfs-utils on server are pa=
tched for labeled nfs too.<br><br>Here is listing for server exports file:<=
br>
/export *(rw,fsid=3D0,sec=3Dunix,insecure,no_subtree_check,sync,security_la=
bel)<br><br>Client and server have the same MLS policy.<br><br>If I mount N=
FS share with command<br>=A0#mount -t nfs4 server:/ /mnt/nfsv4<br>everythin=
g works good, but when i try to mount the same share to another directory<b=
r>
=A0#mount -t nfs4 server:/ /mnt/nfsv4_2<br>it fails with:<br><br>Message fr=
om syslogd@localhost at May 11 13:07:17 ...<br>kernel:Oops: 0000 [#1] SMP <=
br>=A0<br>Message from syslogd@localhost at May 11 13:07:17 ...<br>kernel:l=
ast sysfs file: /sys/devices/virtual/block/dm-0/dev<br>
=A0 <br>Message from syslogd@localhost at May 11 13:07:17 ...<br>kernel:Sta=
ck:<br><br>Why does it happens? Where I can get more information about that=
.<br><br>The second question is that maybe I don&#39;t need labeled NFS.<br=
>
My task is to transfer security levels between client and server over NFS<b=
r>so that client with security level s0, for example, couldn&#39;t get acce=
ss to file with level s1 on NFS share.<br>I don&#39;t know if it may be don=
e with netlabel or something.<br>
Could you help me a bit.<br><br>Andrei<br>

--e89a8fb20228f54bef04bfc0b503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
