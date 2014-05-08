MIME-Version: 1.0
Date: Thu, 8 May 2014 17:45:56 +0400
Message-ID: <CAHw9pMX-T9CHgahLLKjAfA_tOeFuKSwniikV_-ejw3GsCOQW0Q@mail.gmail.com>
Subject: selinux and static label for sVirt
From: vlad halilov <vlad.halilov@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b10cedd537b7404f8e3b328
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b10cedd537b7404f8e3b328
Content-Type: text/plain; charset=UTF-8

Hello. I trying to run kvm wih mls policy on RHEL6.5 and got strange error.

Steps:

1) installing with virtulaization software bundle;
2) install selinux mls and some more: xorg-x11-xauth policycoreutils-python
selinux-policy-mls netlabel_tools setools-console;
3) enable mls in selinux/config, set permissive mode, autorelabel fs &
reboot;
4) login by root@ssh with X (permissive mode still in effect) and create vm.

Now, after creating any vm, it can executed only with dynamic label. On
trying to set static label (s0, s1 or any other with compartments) i got
an error:

2014-05-08 13:23:06.711+0000: 1607: error
:virSecuritySELinuxGenSecurityLabel:552 : unable to allocate socket
security context 's0': Invalid argument

Error not depending from emulation type (kvm or qemu), mls or targeted
policy. RH docs describe sVirt as  worked futures, and static labeling have
no limitation. May i am doing it wrong?

I tried to change root shell label to vm label (runcon -l s0 for example)
but got same error... Any idea?

---
vlad f halilov

--047d7b10cedd537b7404f8e3b328
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello. I trying to run kvm wih mls policy on RHEL6.5 and g=
ot strange error.<br>
<br>
Steps:<br>
<br>
1) installing with virtulaization software bundle;<br>
2) install selinux mls and some more: xorg-x11-xauth policycoreutils-python=
 selinux-policy-mls netlabel_tools setools-console;<br>
3) enable mls in selinux/config, set permissive mode, autorelabel fs &amp; =
reboot;<br>
4) login by root@ssh with X (permissive mode still in effect) and create vm=
.<br>
<br>
Now, after creating any vm, it can executed only with dynamic label. On try=
ing to set static label (s0, s1 or any other with compartments) i got<br>
an error:<br>
<br>
2014-05-08 13:23:06.711+0000: 1607: error :virSecuritySELinuxGenSecurityLab=
el:552 : unable to allocate socket security context &#39;s0&#39;: Invalid a=
rgument<br><div>
<br>
Error not depending from emulation type (kvm or qemu), mls or targeted poli=
cy. RH docs describe sVirt as=C2=A0 worked futures, and static labeling hav=
e no limitation. May i am doing it wrong?<br><br></div><div>I tried to chan=
ge root shell label to vm label (runcon -l s0 for example) but got same err=
or... Any idea?<br>
<br></div><div>
---<br>vlad f halilov<br><br></div></div>

--047d7b10cedd537b7404f8e3b328--
