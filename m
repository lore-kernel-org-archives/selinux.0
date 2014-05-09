MIME-Version: 1.0
Date: Fri, 9 May 2014 15:22:07 +0400
Message-ID: <CAHw9pMVuZk6i42oT5ejfP+W1qa8zNGLKmWyxDJd5jn+u9Lqhfw@mail.gmail.com>
Subject: svirt & labeled network
From: vlad halilov <vlad.halilov@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7bd75eccd3f1e104f8f5ceba
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bd75eccd3f1e104f8f5ceba
Content-Type: text/plain; charset=UTF-8

Hi again. I successfully executed vm with static label
(system_u:system_r:svirt_t:s1) but suprised, that vm see entire traffic
on network interface. Interface attached via bridge and passed to vm as
virtio device. In selinux todo list , but what with vm
http://selinuxproject.org/page/SVirt/TODO ) i see a job 'Integration with
Labeled Networking/IPSec/Labeled NFS (e.g. use of overlay VPNs for
networks on host)'. Does this mean, that current stable (rhel) selinux
release not cover vm network? I have tested network isolation for regular
proccess, this working fine, but what with vm's part?

---
vlad f halilov

--047d7bd75eccd3f1e104f8f5ceba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D""><span dir=3D"ltr" name=3D"me" class=3D"">=
</span> </span><div class=3D""><img class=3D"" id=3D":lm" src=3D"https://ma=
il.google.com/mail/u/0/images/cleardot.gif" alt=3D""></div><div id=3D":l9" =
class=3D""><div id=3D":l8" class=3D"" style=3D"overflow:hidden">
Hi again. I successfully executed vm with static label (system_u:system_r:s=
virt_t:s1) but suprised, that vm see entire traffic<br>
on network interface. Interface attached via bridge and passed to vm as vir=
tio device. In selinux todo list , but what with vm<br>
<a href=3D"http://selinuxproject.org/page/SVirt/TODO" target=3D"_blank">htt=
p://selinuxproject.org/page/SVirt/TODO</a> ) i see a job &#39;Integration w=
ith Labeled Networking/IPSec/Labeled NFS (e.g. use of overlay VPNs for<br>

networks on host)&#39;. Does this mean, that current stable (rhel) selinux =
release not cover vm network? I have tested network isolation for regular p=
roccess, this working fine, but what with vm&#39;s part?<br><br>---<br>
</div><div id=3D":l8" class=3D"" style=3D"overflow:hidden">vlad f halilov<b=
r></div></div></div>

--047d7bd75eccd3f1e104f8f5ceba--
