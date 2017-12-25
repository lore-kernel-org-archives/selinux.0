Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBP1isLm018041
 for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2017 20:44:55 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2988AA4DCC5C8
 for <selinux@tycho.nsa.gov>; Mon, 25 Dec 2017 09:44:24 +0800 (CST)
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
CC: Qiuxishi <qiuxishi@huawei.com>, wangboshi <wangboshi@huawei.com>
From: Li Kun <hw.likun@huawei.com>
Message-ID: <3b8d201d-5dec-522e-1475-aa97ef82acf4@huawei.com>
Date: Mon, 25 Dec 2017 09:44:17 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------BFEA75FA15B4076C47603D0D"
Subject: [BUG RFD]selinux: sidtab_context_to_sid return -NOMEM when
 concurrent with security_load_policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--------------BFEA75FA15B4076C47603D0D
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


Hi all,
When i start a docker container, the runc will call selinux_setprocattr 
to set the exec_sid before start the container.
Meanwhile if i use "semodule -i" to load a policy pp, the old sidtab 
will be shutdown before switch to the new sidtab, and cause
sidtab_context_to_sid  failed with the errno -NOMEM.

Error message:
Dec 14 09:18:18 wuwenming_vudfua_0 docker: 
time="2017-12-14T09:18:18.549862564+08:00" level=error msg="Handler for 
GET /v1.23/containers/192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2/json 
returned error: No such container: 
192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2"
Dec 14 09:18:18 wuwenming_vudfua_0 kernel: [   48.463179] SELinux: 
security_context_to_sid(system_u:object_r:svirt_sandbox_file_t:s0:c290,c371) 
failed for (dev overlay, type overlay) errno=-12
Dec 14 09:18:18 wuwenming_vudfua_0 dbus-daemon: dbus[720]: avc: received 
policyload notice (seqno=2)
Dec 14 09:18:18 wuwenming_vudfua_0 dbus[720]: avc:  received policyload 
notice (seqno=2)


runc         semodule
->selinux_setprocattr ->security_load_policy
     ->security_context_to_sid ->sidtab_shutdown(oldsidtab)
         ->read_lock(&policy_rwlock);     ->sidtab_map(&oldsidtab, 
clone_sid, &newsidtab);

         ->sidtab_context_to_sid
             {
                         ....
                         if (s->next_sid == UINT_MAX || s->shutdown) {
                         ret = -ENOMEM;
                         ....
             }
         ->read_unlock(&policy_rwlock);
         ->write_lock_irq(&policy_rwlock);
           ->"switch to new policydb"
         ->write_unlock_irq(&policy_rwlock);

I wonder that if this is the intention or a bug?
If it is the intention, what should the application do when it get 
-ENOMEM error,  to try again?
If it is a bug, may the two options below suitable to solve the issue?
Option1:
     use policy_rwlock to protect the "sidtab_shutdown" & "sidtab_map" , 
load_policy is rarely to be called after system bringing up,
so i think it will not impact much on the performance.
Option2:
     Use a temp list to store the sid in oldsidtab after it is shutdown, 
and deal with it
after cloning the major sids from oldsidtab to newsidtab and getting the 
policy_rwlock.

-- 
Best Regards
Li Kun


--------------BFEA75FA15B4076C47603D0D
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dwin=
dows-1252">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p><br>
    </p>
    Hi all,<br>
    When i start a docker container, the runc will call
    selinux_setprocattr to set the exec_sid before start the container.<b=
r>
    Meanwhile if i use "semodule -i" to load a policy pp, the old sidtab
    will be shutdown before switch to the new sidtab, and cause <br>
    sidtab_context_to_sid=A0 failed with the errno -NOMEM.<br>
    <br>
    Error message:<br>
    Dec 14 09:18:18 wuwenming_vudfua_0 docker:
    time=3D"2017-12-14T09:18:18.549862564+08:00" level=3Derror msg=3D"Han=
dler
    for GET
    /v1.23/containers/192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2/json
    returned error: No such container:
    192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2"<br>
    Dec 14 09:18:18 wuwenming_vudfua_0 kernel: [=A0=A0 48.463179] SELinux=
:
security_context_to_sid(system_u:object_r:svirt_sandbox_file_t:s0:c290,c3=
71)
    failed for (dev overlay, type overlay) errno=3D-12<br>
    Dec 14 09:18:18 wuwenming_vudfua_0 dbus-daemon: dbus[720]: avc:=A0
    received policyload notice (seqno=3D2)<br>
    Dec 14 09:18:18 wuwenming_vudfua_0 dbus[720]: avc:=A0 received
    policyload notice (seqno=3D2)<br>
    <br>
    <br>
runc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 semodule<br>
-&gt;selinux_setprocattr=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
    -&gt;security_load_policy<br>
    =A0=A0=A0 -&gt;security_context_to_sid=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0
    -&gt;sidtab_shutdown(oldsidtab)<br>
    =A0=A0=A0=A0=A0=A0=A0 -&gt;read_lock(&amp;policy_rwlock);=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0=A0=A0
    =A0=A0=A0 -&gt;sidtab_map(&amp;oldsidtab, clone_sid, &amp;newsidtab);=
<br>
    =A0=A0=A0 =A0=A0=A0 <br>
    =A0=A0=A0=A0=A0=A0=A0 -&gt;sidtab_context_to_sid=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 <br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {<br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ....<br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 if (s-&gt;next_sid =3D=3D UINT_MAX || s-&gt;<font
      color=3D"#ff0000">shutdown</font>) {<br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ret =3D -<font color=3D"#ff0000">ENOMEM</font>;<br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ....<br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<br>
    =A0=A0=A0=A0=A0=A0=A0 -&gt;read_unlock(&amp;policy_rwlock);=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 <br>
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 -&gt;write_lock_irq(&amp;policy_rwlock);<br>
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0 =A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0 -&gt;"switch to new policydb"<br>
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0
    =A0=A0=A0 =A0=A0=A0 -&gt;write_unlock_irq(&amp;policy_rwlock);<br>
    <br>
    I wonder that if this is the intention or a bug?<br>
    If it is the intention, what should the application do when it get
    -ENOMEM error,=A0 to try again?<br>
    If it is a bug, may the two options below suitable to solve the
    issue?<br>
    Option1:<br>
    =A0=A0=A0 use policy_rwlock to protect the "sidtab_shutdown" &amp;
    "sidtab_map" , load_policy is rarely to be called after system
    bringing up,=A0 <br>
    so i think it will not impact much on the performance.<br>
    Option2:<br>
    =A0=A0=A0 Use a temp list to store the sid in oldsidtab after it is
    shutdown, and deal with it <br>
    after cloning the major sids from oldsidtab to newsidtab and getting
    the policy_rwlock.
    <pre class=3D"moz-signature" cols=3D"72">--=20
Best Regards
Li Kun</pre>
  </body>
</html>

--------------BFEA75FA15B4076C47603D0D--
