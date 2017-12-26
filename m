Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBQ3SAj4020046
 for <selinux@tycho.nsa.gov>; Mon, 25 Dec 2017 22:28:10 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 82B802D2E2016
 for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2017 11:27:38 +0800 (CST)
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <3b8d201d-5dec-522e-1475-aa97ef82acf4@huawei.com>
CC: Qiuxishi <qiuxishi@huawei.com>, wangboshi <wangboshi@huawei.com>
From: Li Kun <hw.likun@huawei.com>
Message-ID: <cd77e9b0-d073-174a-c6db-ddfe028ba982@huawei.com>
Date: Tue, 26 Dec 2017 11:27:30 +0800
MIME-Version: 1.0
In-Reply-To: <3b8d201d-5dec-522e-1475-aa97ef82acf4@huawei.com>
Content-Type: multipart/alternative;
 boundary="------------0FBB8773F6600BC3E4E3C39F"
Subject: Re: [BUG RFD]selinux: sidtab_context_to_sid return -NOMEM
 when concurrent with security_load_policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--------------0FBB8773F6600BC3E4E3C39F
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Please ignore this duplicate mail which is resent due to the mail=20
server's error.

Thanks a lot.


=E5=9C=A8 2017/12/25 9:44, Li Kun =E5=86=99=E9=81=93:
>
>
> Hi all,
> When i start a docker container, the runc will call=20
> selinux_setprocattr to set the exec_sid before start the container.
> Meanwhile if i use "semodule -i" to load a policy pp, the old sidtab=20
> will be shutdown before switch to the new sidtab, and cause
> sidtab_context_to_sid  failed with the errno -NOMEM.
>
> Error message:
> Dec 14 09:18:18 wuwenming_vudfua_0 docker:=20
> time=3D"2017-12-14T09:18:18.549862564+08:00" level=3Derror msg=3D"Handl=
er=20
> for GET=20
> /v1.23/containers/192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2/json=20
> returned error: No such container:=20
> 192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2"
> Dec 14 09:18:18 wuwenming_vudfua_0 kernel: [   48.463179] SELinux:=20
> security_context_to_sid(system_u:object_r:svirt_sandbox_file_t:s0:c290,=
c371)=20
> failed for (dev overlay, type overlay) errno=3D-12
> Dec 14 09:18:18 wuwenming_vudfua_0 dbus-daemon: dbus[720]: avc:=20
> received policyload notice (seqno=3D2)
> Dec 14 09:18:18 wuwenming_vudfua_0 dbus[720]: avc:  received=20
> policyload notice (seqno=3D2)
>
>
> runc         semodule
> ->selinux_setprocattr ->security_load_policy
>     ->security_context_to_sid         ->sidtab_shutdown(oldsidtab)
>         ->read_lock(&policy_rwlock);     ->sidtab_map(&oldsidtab,=20
> clone_sid, &newsidtab);
>
>         ->sidtab_context_to_sid
>             {
>                         ....
>                         if (s->next_sid =3D=3D UINT_MAX || s->shutdown)=
 {
>                         ret =3D -ENOMEM;
>                         ....
>             }
>         ->read_unlock(&policy_rwlock);
>                 ->write_lock_irq(&policy_rwlock);
>              ->"switch to new policydb"
>                 ->write_unlock_irq(&policy_rwlock);
>
> I wonder that if this is the intention or a bug?
> If it is the intention, what should the application do when it get=20
> -ENOMEM error,  to try again?
> If it is a bug, may the two options below suitable to solve the issue?
> Option1:
>     use policy_rwlock to protect the "sidtab_shutdown" & "sidtab_map"=20
> , load_policy is rarely to be called after system bringing up,
> so i think it will not impact much on the performance.
> Option2:
>     Use a temp list to store the sid in oldsidtab after it is=20
> shutdown, and deal with it
> after cloning the major sids from oldsidtab to newsidtab and getting=20
> the policy_rwlock.
> --=20
> Best Regards
> Li Kun

--=20
Best Regards
Li Kun


--------------0FBB8773F6600BC3E4E3C39F
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>Please ignore this duplicate mail which is resent due to the mail
      server's error.</p>
    <p>Thanks a lot.<br>
    </p>
    <br>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2017/12/25 9:44, Li Kun =E5=86=
=99=E9=81=93:<br>
    </div>
    <blockquote
      cite=3D"mid:3b8d201d-5dec-522e-1475-aa97ef82acf4@huawei.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DU=
TF-8">
      <p><br>
      </p>
      Hi all,<br>
      When i start a docker container, the runc will call
      selinux_setprocattr to set the exec_sid before start the
      container.<br>
      Meanwhile if i use "semodule -i" to load a policy pp, the old
      sidtab will be shutdown before switch to the new sidtab, and cause
      <br>
      sidtab_context_to_sid=C2=A0 failed with the errno -NOMEM.<br>
      <br>
      Error message:<br>
      Dec 14 09:18:18 wuwenming_vudfua_0 docker:
      time=3D"2017-12-14T09:18:18.549862564+08:00" level=3Derror
      msg=3D"Handler for GET
      /v1.23/containers/192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2/json
      returned error: No such container:
      192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2"<br>
      Dec 14 09:18:18 wuwenming_vudfua_0 kernel: [=C2=A0=C2=A0 48.463179]=
 SELinux:
security_context_to_sid(system_u:object_r:svirt_sandbox_file_t:s0:c290,c3=
71)
      failed for (dev overlay, type overlay) errno=3D-12<br>
      Dec 14 09:18:18 wuwenming_vudfua_0 dbus-daemon: dbus[720]: avc:=C2=A0
      received policyload notice (seqno=3D2)<br>
      Dec 14 09:18:18 wuwenming_vudfua_0 dbus[720]: avc:=C2=A0 received
      policyload notice (seqno=3D2)<br>
      <br>
      <br>
runc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 semodule<br>
-&gt;selinux_setprocattr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
      -&gt;security_load_policy<br>
      =C2=A0=C2=A0=C2=A0 -&gt;security_context_to_sid=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 -&gt;sidtab_shutdown(oldsidta=
b)<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -&gt;read_lock(&amp;poli=
cy_rwlock);=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 -&gt;sidtab_map(&amp;oldsidtab, clone_sid, &amp;=
newsidtab);<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -&gt;sidtab_context_to_s=
id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
{<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...=
.<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(s-&gt;next_sid =3D=3D UINT_MAX || s-&gt;<font
        color=3D"#ff0000">shutdown</font>) {<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -<font color=3D"#ff0000">ENOMEM</font>;<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...=
.<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -&gt;read_unlock(&amp;po=
licy_rwlock);=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 <br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 -&gt;write_lock_irq(&amp;policy_rwlock);<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0
      =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 -&gt;"swi=
tch to new policydb"<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 -&gt;write_unlock_irq(&amp;policy_rwlock);<br>
      <br>
      I wonder that if this is the intention or a bug?<br>
      If it is the intention, what should the application do when it get
      -ENOMEM error,=C2=A0 to try again?<br>
      If it is a bug, may the two options below suitable to solve the
      issue?<br>
      Option1:<br>
      =C2=A0=C2=A0=C2=A0 use policy_rwlock to protect the "sidtab_shutdow=
n" &amp;
      "sidtab_map" , load_policy is rarely to be called after system
      bringing up,=C2=A0 <br>
      so i think it will not impact much on the performance.<br>
      Option2:<br>
      =C2=A0=C2=A0=C2=A0 Use a temp list to store the sid in oldsidtab af=
ter it is
      shutdown, and deal with it <br>
      after cloning the major sids from oldsidtab to newsidtab and
      getting the policy_rwlock.
      <pre class=3D"moz-signature" cols=3D"72">--=20
Best Regards
Li Kun</pre>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Best Regards
Li Kun</pre>
  </body>
</html>

--------------0FBB8773F6600BC3E4E3C39F--
