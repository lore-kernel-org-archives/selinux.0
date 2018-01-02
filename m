Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w021eYRI012842
 for <selinux@tycho.nsa.gov>; Mon, 1 Jan 2018 20:40:34 -0500
To: Stephen Smalley <stephen.smalley@gmail.com>
References: <30dd3248-b703-828b-13ba-8d7ace8a09da@huawei.com>
 <CAB9W1A0fN2QSA60JwYEjrCOHxFnobypJdDskkQ8Fz4zrXycy6Q@mail.gmail.com>
 <4b891871-c334-8d08-df77-2b15b1392e33@huawei.com>
 <CAB9W1A0D9EuU0Y6x2aZYBv2Xb=cbmBiXUGAe2zcrBb3edTiDsQ@mail.gmail.com>
CC: selinux <selinux@tycho.nsa.gov>, Qiuxishi <qiuxishi@huawei.com>, wangboshi
 <wangboshi@huawei.com>, Paul Moore <paul@paul-moore.com>
From: Li Kun <hw.likun@huawei.com>
Message-ID: <437a0ab5-12df-05ce-fcc4-78d7b36abb2e@huawei.com>
Date: Tue, 2 Jan 2018 09:39:47 +0800
MIME-Version: 1.0
In-Reply-To: <CAB9W1A0D9EuU0Y6x2aZYBv2Xb=cbmBiXUGAe2zcrBb3edTiDsQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------B36B0E0072C5F88C3A3EE4AB"
Subject: Re: [BUG RFD]selinux: sidtab_context_to_sid return -NOMEM
 when concurrent with security_load_policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--------------B36B0E0072C5F88C3A3EE4AB
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2017/12/30 1:25, Stephen Smalley =E5=86=99=E9=81=93:
> On Dec 28, 2017 10:14 PM, "Li Kun" <hw.likun@huawei.com=20
> <mailto:hw.likun@huawei.com>> wrote:
>
>
>
>     =E5=9C=A8 2017/12/28 22:57, Stephen Smalley =E5=86=99=E9=81=93:
>>     On Sat, Dec 23, 2017 at 3:03 AM, Li Kun <hw.likun@huawei.com
>>     <mailto:hw.likun@huawei.com>> wrote:
>>
>>         Hi all,
>>         When i start a docker container, the runc will call
>>         selinux_setprocattr to set the exec_sid before start the
>>         container.
>>         Meanwhile if i use "semodule -i" to load a policy pp, the old
>>         sidtab will be shutdown before switch to the new sidtab, and
>>         cause
>>         sidtab_context_to_sid  failed with the errno -NOMEM.
>>
>>         Error message:
>>         Dec 14 09:18:18 wuwenming_vudfua_0 docker:
>>         time=3D"2017-12-14T09:18:18.549862564+08:00" level=3Derror
>>         msg=3D"Handler for GET
>>         /v1.23/containers/192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2=
/json
>>         <http://192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2/json>
>>         returned error: No such container:
>>         192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2
>>         <http://192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2>"
>>         Dec 14 09:18:18 wuwenming_vudfua_0 kernel: [   48.463179]
>>         SELinux:
>>         security_context_to_sid(system_u:object_r:svirt_sandbox_file_t=
:s0:c290,c371)
>>         failed for (dev overlay, type overlay) errno=3D-12
>>         Dec 14 09:18:18 wuwenming_vudfua_0 dbus-daemon: dbus[720]:
>>         avc:  received policyload notice (seqno=3D2)
>>         Dec 14 09:18:18 wuwenming_vudfua_0 dbus[720]: avc:  received
>>         policyload notice (seqno=3D2)
>>
>>
>>         runc         semodule
>>         ->selinux_setprocattr ->security_load_policy
>>             ->security_context_to_sid ->sidtab_shutdown(oldsidtab)
>>         ->read_lock(&policy_rwlock); ->sidtab_map(&oldsidtab,
>>         clone_sid, &newsidtab);
>>
>>                 ->sidtab_context_to_sid
>>                     {
>>                                 ....
>>                                 if (s->next_sid =3D=3D UINT_MAX ||
>>         s->shutdown) {
>>                                 ret =3D -ENOMEM;
>>                                 ....
>>                     }
>>         ->read_unlock(&policy_rwlock);
>>         ->write_lock_irq(&policy_rwlock);
>>                                 ->"switch to new policydb"
>>         ->write_unlock_irq(&policy_rwlock);
>>
>>         I wonder that if this is the intention or a bug?
>>         If it is the intention, what should the application do when
>>         it get -ENOMEM error,  to try again?
>>         If it is a bug, may the two options below suitable to solve
>>         the issue?
>>         Option1:
>>             use policy_rwlock to protect the "sidtab_shutdown" &
>>         "sidtab_map" , load_policy is rarely to be called after
>>         system bringing up,
>>         so i think it will not impact much on the performance.
>>         Option2:
>>             Use a temp list to store the sid in oldsidtab after it is
>>         shutdown, and deal with it
>>         after cloning the major sids from oldsidtab to newsidtab and
>>         getting the policy_rwlock.
>>
>>
>>     The current logic is intentional.  One might argue that a
>>     different error code might be more suitable in this situation
>>     (e.g. EAGAIN or something), but ENOMEM is already a possible
>>     error code when loading policy upon transient OOM conditions, so
>>     the caller might have to retry regardless.  The policy write lock
>>     must only be held for the minimal critical section as otherwise
>>     all system activity could be blocked; it is only held when making
>>     the new policydb and sidtab active not during their allocation
>>     and setup - ideally it would be further reduced to a couple of
>>     pointer updates. Is this scenario something you are encountering
>>     in actual practice or just a theoretically possible one?
>     Thank you very much for your reply.
>     Yes, we encounter this issue in our implementation.
>     We have an intertion in our design that we can divide the policy
>     into several parts to load separately.
>     So after the red-hat linux bringing up, which has loaded the
>     system policy db released by redhat, we begin to load the policy
>     released by our product ,
>     and meanwhile someone want to start a docker container, and the
>     runc get an ENOMEM error like i mentioned above.
>     Should we merge all the policy into the system policy db and just
>     load once?
>
>
>     --=20
>     Best Regards
>     Li Kun
>
> Typically you would install your policy module when your package is=20
> installed and not need to do it at runtime.
Would you think it's suibable to change the error code to EAGAIN=EF=BC=9F

--=20
Best Regards
Li Kun


--------------B36B0E0072C5F88C3A3EE4AB
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p><br>
    </p>
    <br>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2017/12/30 1:25, Stephen Sma=
lley =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote
cite=3D"mid:CAB9W1A0D9EuU0Y6x2aZYBv2Xb=3DcbmBiXUGAe2zcrBb3edTiDsQ@mail.gm=
ail.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DU=
TF-8">
      <div dir=3D"auto">
        <div>
          <div class=3D"gmail_extra">
            <div class=3D"gmail_quote">On Dec 28, 2017 10:14 PM, "Li Kun"
              &lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:hw.likun@huawei.com">hw.likun@huawei.com</=
a>&gt;
              wrote:<br type=3D"attribution">
              <blockquote class=3D"quote" style=3D"margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <div bgcolor=3D"#FFFFFF" text=3D"#000000">
                  <div class=3D"elided-text">
                    <p><br>
                    </p>
                    <br>
                    <div class=3D"m_-6684914453742943450moz-cite-prefix">=
=E5=9C=A8
                      2017/12/28 22:57, Stephen Smalley =E5=86=99=E9=81=93=
:<br>
                    </div>
                    <blockquote type=3D"cite">
                      <div dir=3D"ltr">
                        <div class=3D"gmail_extra">
                          <div class=3D"gmail_quote">On Sat, Dec 23, 2017
                            at 3:03 AM, Li Kun <span dir=3D"ltr">&lt;<a
                                moz-do-not-send=3D"true"
                                href=3D"mailto:hw.likun@huawei.com"
                                target=3D"_blank">hw.likun@huawei.com</a>=
&gt;</span>
                            wrote:<br>
                            <blockquote class=3D"gmail_quote"
                              style=3D"margin:0 0 0 .8ex;border-left:1px
                              #ccc solid;padding-left:1ex">
                              <div bgcolor=3D"#FFFFFF" text=3D"#000000"> =
Hi
                                all,<br>
                                When i start a docker container, the
                                runc will call selinux_setprocattr to
                                set the exec_sid before start the
                                container.<br>
                                Meanwhile if i use "semodule -i" to load
                                a policy pp, the old sidtab will be
                                shutdown before switch to the new
                                sidtab, and cause <br>
                                sidtab_context_to_sid=C2=A0 failed with t=
he
                                errno -NOMEM.<br>
                                <br>
                                Error message:<br>
                                Dec 14 09:18:18 wuwenming_vudfua_0
                                docker: time=3D"2017-12-14T09:18:18.5498<=
wbr>62564+08:00"
                                level=3Derror msg=3D"Handler for GET
                                /v1.23/containers/<a
                                  moz-do-not-send=3D"true"
                                  href=3D"http://192.168.0.2:9082/dfs_d:V=
100R013C11SPC000BCD2/json"
                                  target=3D"_blank">192.168.0.2:<wbr>9082=
/dfs_d:V100R013C11SPC000BC<wbr>D2/json</a>
                                returned error: No such container: <a
                                  moz-do-not-send=3D"true"
                                  href=3D"http://192.168.0.2:9082/dfs_d:V=
100R013C11SPC000BCD2"
                                  target=3D"_blank">192.168.0.2:9082/dfs_=
d:V100R01<wbr>3C11SPC000BCD2</a>"<br>
                                Dec 14 09:18:18 wuwenming_vudfua_0
                                kernel: [=C2=A0=C2=A0 48.463179] SELinux:
                                security_context_to_sid(system<wbr>_u:obj=
ect_r:svirt_sandbox_<wbr>file_t:s0:c290,c371)
                                failed for (dev overlay, type overlay)
                                errno=3D-12<br>
                                Dec 14 09:18:18 wuwenming_vudfua_0
                                dbus-daemon: dbus[720]: avc:=C2=A0 receiv=
ed
                                policyload notice (seqno=3D2)<br>
                                Dec 14 09:18:18 wuwenming_vudfua_0
                                dbus[720]: avc:=C2=A0 received policyload
                                notice (seqno=3D2)<br>
                                <br>
                                <br>
                                runc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sem=
odule<br>
                                -&gt;selinux_setprocattr=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<=
wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<=
wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                -&gt;security_load_policy<br>
                                =C2=A0=C2=A0=C2=A0 -&gt;security_context_=
to_sid=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                -&gt;sidtab_shutdown(oldsidtab)<br>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                -&gt;read_lock(&amp;policy_rwlock);=C2=A0=
=C2=A0<wbr>=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0
                                -&gt;sidtab_map(&amp;oldsidtab,
                                clone_sid, &amp;newsidtab);<br>
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 <br=
>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 -&gt;sidtab_context_to_sid=C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 <br>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 {<br>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ....<br>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if
                                (s-&gt;next_sid =3D=3D UINT_MAX || s-&gt;=
<font
                                  color=3D"#ff0000">shutdown</font>) {<br=
>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -<font
                                  color=3D"#ff0000">ENOMEM</font>;<br>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ....<br>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
                                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                -&gt;read_unlock(&amp;policy_rwlock);<wbr=
>=C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 <br>
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                -&gt;write_lock_irq(&amp;policy_rwloc<wbr=
>k);<br>
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 -&gt;=
"switch to
                                new policydb"<br>
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                -&gt;write_unlock_irq(&amp;policy_rwl<wbr=
>ock);<br>
                                <br>
                                I wonder that if this is the intention
                                or a bug?<br>
                                If it is the intention, what should the
                                application do when it get -ENOMEM
                                error,=C2=A0 to try again?<br>
                                If it is a bug, may the two options
                                below suitable to solve the issue?<br>
                                Option1:<br>
                                =C2=A0=C2=A0=C2=A0 use policy_rwlock to p=
rotect the
                                "sidtab_shutdown" &amp; "sidtab_map" ,
                                load_policy is rarely to be called after
                                system bringing up,=C2=A0 <br>
                                so i think it will not impact much on
                                the performance.<br>
                                Option2:<br>
                                =C2=A0=C2=A0=C2=A0 Use a temp list to sto=
re the sid in
                                oldsidtab after it is shutdown, and deal
                                with it <br>
                                after cloning the major sids from
                                oldsidtab to newsidtab and getting the
                                policy_rwlock.</div>
                            </blockquote>
                            <div><br>
                            </div>
                            <div>The current logic is intentional.=C2=A0 =
One
                              might argue that a different error code
                              might be more suitable in this situation
                              (e.g. EAGAIN or something), but ENOMEM is
                              already a possible error code when loading
                              policy upon transient OOM conditions, so
                              the caller might have to retry
                              regardless.=C2=A0 The policy write lock mus=
t
                              only be held for the minimal critical
                              section as otherwise all system activity
                              could be blocked; it is only held when
                              making the new policydb and sidtab active
                              not during their allocation and setup -
                              ideally it would be further reduced to a
                              couple of pointer updates. Is this
                              scenario something you are encountering in
                              actual practice or just a theoretically
                              possible one?=C2=A0 <br>
                            </div>
                          </div>
                        </div>
                      </div>
                    </blockquote>
                  </div>
                  Thank you very much for your reply.<br>
                  Yes, we encounter this issue in our implementation.<br>
                  We have an intertion in our design that we can divide
                  the policy into several parts to load separately. <br>
                  So after the red-hat linux bringing up, which has
                  loaded the system policy db released by redhat, we
                  begin to load the policy released by our product , <br>
                  and meanwhile someone want to start a docker
                  container, and the runc get an ENOMEM error like i
                  mentioned above.<br>
                  Should we merge all the policy into the system policy
                  db and just load once?
                  <div class=3D"quoted-text"><br>
                    <br>
                    <pre class=3D"m_-6684914453742943450moz-signature" co=
ls=3D"72">--=20
Best Regards
Li Kun</pre>
                  </div>
                </div>
              </blockquote>
            </div>
            <span style=3D"font-family:sans-serif">Typically you would
              install your policy module when your package is installed
              and not need to do it at runtime. </span><br>
          </div>
        </div>
      </div>
    </blockquote>
    Would you think it's suibable to change the error code to EAGAIN=EF=BC=
=9F<br>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Best Regards
Li Kun</pre>
  </body>
</html>

--------------B36B0E0072C5F88C3A3EE4AB--
