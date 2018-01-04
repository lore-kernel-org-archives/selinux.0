Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w04DdPL5020446
 for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2018 08:39:25 -0500
Received: by mail-io0-f182.google.com with SMTP id n14so2241725iob.4
 for <selinux@tycho.nsa.gov>; Thu, 04 Jan 2018 05:39:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bf779caf-6138-6636-2d5f-d4929a2971e5@huawei.com>
References: <30dd3248-b703-828b-13ba-8d7ace8a09da@huawei.com>
 <CAB9W1A0fN2QSA60JwYEjrCOHxFnobypJdDskkQ8Fz4zrXycy6Q@mail.gmail.com>
 <4b891871-c334-8d08-df77-2b15b1392e33@huawei.com>
 <CAB9W1A0D9EuU0Y6x2aZYBv2Xb=cbmBiXUGAe2zcrBb3edTiDsQ@mail.gmail.com>
 <437a0ab5-12df-05ce-fcc4-78d7b36abb2e@huawei.com>
 <CAB9W1A2DgSwrbfd1Lkg4RgPbgJ21npQVv8oibcH_D_xHR92muQ@mail.gmail.com>
 <7b8413c7-f7cf-dc38-2234-2fad365b37e9@huawei.com>
 <CAB9W1A1vD-63Grz70FvKn4sJno+-77DX2fcnP-sQTJ9Hms1g3Q@mail.gmail.com>
 <bf779caf-6138-6636-2d5f-d4929a2971e5@huawei.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Thu, 4 Jan 2018 08:39:13 -0500
Message-ID: <CAB9W1A1mKh7aQziuzm5XeV8daqzL-9qDFPUe9GK0dsbXN7eXag@mail.gmail.com>
To: Li Kun <hw.likun@huawei.com>
Cc: selinux <selinux@tycho.nsa.gov>, Qiuxishi <qiuxishi@huawei.com>,
 wangboshi <wangboshi@huawei.com>, Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary="94eb2c0689d63102c90561f37586"
Subject: Re: [BUG RFD]selinux: sidtab_context_to_sid return -NOMEM
 when concurrent with security_load_policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0689d63102c90561f37586
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Try testing such a patch to see if it resolves your issue. However, I think
if you switch to installing your policy module from your package post
scriptlet, you won't encounter this issue in the first place.

On Jan 3, 2018 7:26 AM, "Li Kun" <hw.likun@huawei.com> wrote:

>
>
> =E5=9C=A8 2018/1/2 22:31, Stephen Smalley =E5=86=99=E9=81=93:
>
>
>
> On Jan 2, 2018 1:37 AM, "Li Kun" <hw.likun@huawei.com> wrote:
>
>
>
> On 2018/1/2 12:16, Stephen Smalley wrote:
>
> On Jan 1, 2018 8:40 PM, "Li Kun" <hw.likun@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2017/12/30 1:25, Stephen Smalley =E5=86=99=E9=81=93:
>
> On Dec 28, 2017 10:14 PM, "Li Kun" <hw.likun@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2017/12/28 22:57, Stephen Smalley =E5=86=99=E9=81=93:
>
> On Sat, Dec 23, 2017 at 3:03 AM, Li Kun <hw.likun@huawei.com> wrote:
>
>> Hi all,
>> When i start a docker container, the runc will call selinux_setprocattr
>> to set the exec_sid before start the container.
>> Meanwhile if i use "semodule -i" to load a policy pp, the old sidtab wil=
l
>> be shutdown before switch to the new sidtab, and cause
>> sidtab_context_to_sid  failed with the errno -NOMEM.
>>
>> Error message:
>> Dec 14 09:18:18 wuwenming_vudfua_0 docker: time=3D"2017-12-14T09:18:18.5=
49862564+08:00"
>> level=3Derror msg=3D"Handler for GET /v1.23/containers/192.168.0.2:
>> 9082/dfs_d:V100R013C11SPC000BCD2/json returned error: No such container:
>> 192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2"
>> Dec 14 09:18:18 wuwenming_vudfua_0 kernel: [   48.463179] SELinux:
>> security_context_to_sid(system_u:object_r:svirt_sandbox_file_t:s0:c290,c=
371)
>> failed for (dev overlay, type overlay) errno=3D-12
>> Dec 14 09:18:18 wuwenming_vudfua_0 dbus-daemon: dbus[720]: avc:  receive=
d
>> policyload notice (seqno=3D2)
>> Dec 14 09:18:18 wuwenming_vudfua_0 dbus[720]: avc:  received policyload
>> notice (seqno=3D2)
>>
>>
>> runc
>>
>>     semodule
>> ->selinux_setprocattr
>>
>> ->security_load_policy
>>     ->security_context_to_sid
>>
>> ->sidtab_shutdown(oldsidtab)
>>         ->read_lock(&policy_rwlock);
>>
>> ->sidtab_map(&oldsidtab, clone_sid, &newsidtab);
>>
>>         ->sidtab_context_to_sid
>>
>>             {
>>                         ....
>>                         if (s->next_sid =3D=3D UINT_MAX || s->shutdown) =
{
>>                         ret =3D -ENOMEM;
>>                         ....
>>             }
>>         ->read_unlock(&policy_rwlock);
>>
>>
>>
>> ->write_lock_irq(&policy_rwlock);
>>
>>
>> ->"switch to new policydb"
>>
>>
>> ->write_unlock_irq(&policy_rwlock);
>>
>> I wonder that if this is the intention or a bug?
>> If it is the intention, what should the application do when it get
>> -ENOMEM error,  to try again?
>> If it is a bug, may the two options below suitable to solve the issue?
>> Option1:
>>     use policy_rwlock to protect the "sidtab_shutdown" & "sidtab_map" ,
>> load_policy is rarely to be called after system bringing up,
>> so i think it will not impact much on the performance.
>> Option2:
>>     Use a temp list to store the sid in oldsidtab after it is shutdown,
>> and deal with it
>> after cloning the major sids from oldsidtab to newsidtab and getting the
>> policy_rwlock.
>>
>
> The current logic is intentional.  One might argue that a different error
> code might be more suitable in this situation (e.g. EAGAIN or something),
> but ENOMEM is already a possible error code when loading policy upon
> transient OOM conditions, so the caller might have to retry regardless.
> The policy write lock must only be held for the minimal critical section =
as
> otherwise all system activity could be blocked; it is only held when maki=
ng
> the new policydb and sidtab active not during their allocation and setup =
-
> ideally it would be further reduced to a couple of pointer updates. Is th=
is
> scenario something you are encountering in actual practice or just a
> theoretically possible one?
>
> Thank you very much for your reply.
> Yes, we encounter this issue in our implementation.
> We have an intertion in our design that we can divide the policy into
> several parts to load separately.
> So after the red-hat linux bringing up, which has loaded the system polic=
y
> db released by redhat, we begin to load the policy released by our produc=
t
> ,
> and meanwhile someone want to start a docker container, and the runc get
> an ENOMEM error like i mentioned above.
> Should we merge all the policy into the system policy db and just load
> once?
>
>
> --
> Best Regards
> Li Kun
>
> Typically you would install your policy module when your package is
> installed and not need to do it at runtime.
>
> Would you think it's suibable to change the error code to EAGAIN=EF=BC=9F
>
>
> You likely want it to return - EINTR or -ERESTARTSYS if you want existing
> callers of setprocattr to automatically restart the call instead of
> failing.
>
> AFAIU, the EINTR & ERESTARTSYS are releated to sigpending under most
> circumstances, is it proper to use them here?
> And as i mentioned above, most apps(like runc, bind)do not retry when the=
y
> meet ENOMEM, so i think maybe EAGAIN is more suitable for the transient
> race conditions
>
>
> EINTR is already handled by the libselinux procattr code, so returning
> that will cause existing users of the libselinux interfaces to retry.
> EAGAIN is not handled since the descriptor is not marked nonblocking.
>
> Ok, i understand, thank you.
> Maybe i can send a patch to change the errno to EINTR if you think it mak=
e
> sense.
>
> --
> Best Regards
> Li Kun
>
>

--94eb2c0689d63102c90561f37586
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Try testing such a patch to see if it resolves your issue=
. However, I think if you switch to installing your policy module from your=
 package post scriptlet, you won&#39;t encounter this issue in the first pl=
ace.=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Jan 3, 2018 7:26 AM, &quot;Li Kun&quot; &lt;<a href=3D"mailto:hw.likun@hu=
awei.com">hw.likun@huawei.com</a>&gt; wrote:<br type=3D"attribution"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p><br>
    </p>
    <br>
    <div class=3D"m_-5416331567409940856moz-cite-prefix">=E5=9C=A8 2018/1/2=
 22:31, Stephen Smalley =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto"><br>
        <div class=3D"gmail_extra" dir=3D"auto"><br>
          <div class=3D"gmail_quote">On Jan 2, 2018 1:37 AM, &quot;Li Kun&q=
uot; &lt;<a href=3D"mailto:hw.likun@huawei.com" target=3D"_blank">hw.likun@=
huawei.com</a>&gt;
            wrote:<br type=3D"attribution">
            <blockquote class=3D"m_-5416331567409940856quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div bgcolor=3D"#FFFFFF" text=3D"#000000">
                <div class=3D"m_-5416331567409940856elided-text">
                  <p><br>
                  </p>
                  <br>
                  <div class=3D"m_-5416331567409940856m_7577183107687087194=
moz-cite-prefix">On
                    2018/1/2 12:16, Stephen Smalley wrote:<br>
                  </div>
                  <blockquote type=3D"cite">
                    <div dir=3D"auto">On Jan 1, 2018 8:40 PM, &quot;Li Kun&=
quot;
                      &lt;<a href=3D"mailto:hw.likun@huawei.com" target=3D"=
_blank">hw.likun@huawei.com</a>&gt;
                      wrote:
                      <div class=3D"gmail_extra" dir=3D"auto">
                        <div class=3D"gmail_quote">
                          <blockquote class=3D"m_-5416331567409940856m_7577=
183107687087194quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
                            <div bgcolor=3D"#FFFFFF" text=3D"#000000">
                              <div class=3D"m_-5416331567409940856m_7577183=
107687087194elided-text">
                                <p><br>
                                </p>
                                <br>
                                <div class=3D"m_-5416331567409940856m_75771=
83107687087194m_-6377092796483830810moz-cite-prefix">=E5=9C=A8
                                  2017/12/30 1:25, Stephen Smalley =E5=86=
=99=E9=81=93:<br>
                                </div>
                                <blockquote type=3D"cite">
                                  <div dir=3D"auto">
                                    <div>
                                      <div class=3D"gmail_extra">
                                        <div class=3D"gmail_quote">On Dec
                                          28, 2017 10:14 PM, &quot;Li Kun&q=
uot;
                                          &lt;<a href=3D"mailto:hw.likun@hu=
awei.com" target=3D"_blank">hw.likun@huawei.com</a>&gt;
                                          wrote:<br type=3D"attribution">
                                          <blockquote class=3D"m_-541633156=
7409940856m_7577183107687087194m_-6377092796483830810quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                                            <div bgcolor=3D"#FFFFFF" text=
=3D"#000000">
                                              <div class=3D"m_-541633156740=
9940856m_7577183107687087194m_-6377092796483830810elided-text">
                                                <p><br>
                                                </p>
                                                <br>
                                                <div class=3D"m_-5416331567=
409940856m_7577183107687087194m_-6377092796483830810m_-6684914453742943450m=
oz-cite-prefix">=E5=9C=A8
                                                  2017/12/28 22:57,
                                                  Stephen Smalley =E5=86=99=
=E9=81=93:<br>
                                                </div>
                                                <blockquote type=3D"cite">
                                                  <div dir=3D"ltr">
                                                    <div class=3D"gmail_ext=
ra">
                                                      <div class=3D"gmail_q=
uote">On
                                                        Sat, Dec 23,
                                                        2017 at 3:03 AM,
                                                        Li Kun <span dir=3D=
"ltr">&lt;<a href=3D"mailto:hw.likun@huawei.com" target=3D"_blank">hw.likun=
@huawei.com</a>&gt;</span>
                                                        wrote:<br>
                                                        <blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
                                                          <div bgcolor=3D"#=
FFFFFF" text=3D"#000000">
                                                          Hi all,<br>
                                                          When i start a
                                                          docker
                                                          container, the
                                                          runc will call
selinux_setprocattr to set the exec_sid before start the container.<br>
                                                          Meanwhile if i
                                                          use &quot;semodul=
e
                                                          -i&quot; to load =
a
                                                          policy pp, the
                                                          old sidtab
                                                          will be
                                                          shutdown
                                                          before switch
                                                          to the new
                                                          sidtab, and
                                                          cause <br>
sidtab_context_to_sid=C2=A0 failed with the errno -NOMEM.<br>
                                                          <br>
                                                          Error message:<br=
>
                                                          Dec 14
                                                          09:18:18
                                                          wuwenming_vudfua_=
0
                                                          docker:
time=3D&quot;2017-12-14T09:18:18.5498<wbr>62564+08:00&quot; level=3Derror m=
sg=3D&quot;Handler
                                                          for GET
                                                          /v1.23/containers=
/<a href=3D"http://192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2/json" targe=
t=3D"_blank">192.168.0.2:<wbr>9082/dfs_d:V100R013C11SPC000BC<wbr>D2/json</a=
>
                                                          returned
                                                          error: No such
                                                          container: <a hre=
f=3D"http://192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2" target=3D"_blank"=
>192.168.0.2:9082/dfs_d:V100R01<wbr>3C11SPC000BCD2</a>&quot;<br>
                                                          Dec 14
                                                          09:18:18
                                                          wuwenming_vudfua_=
0
                                                          kernel: [=C2=A0=
=C2=A0
                                                          48.463179]
                                                          SELinux:
                                                          security_context_=
to_sid(system<wbr>_u:object_r:svirt_sandbox_file<wbr>_t:s0:c290,c371)
                                                          failed for
                                                          (dev overlay,
                                                          type overlay)
                                                          errno=3D-12<br>
                                                          Dec 14
                                                          09:18:18
                                                          wuwenming_vudfua_=
0
                                                          dbus-daemon:
                                                          dbus[720]:
                                                          avc:=C2=A0 receiv=
ed
                                                          policyload
                                                          notice
                                                          (seqno=3D2)<br>
                                                          Dec 14
                                                          09:18:18
                                                          wuwenming_vudfua_=
0
                                                          dbus[720]:
                                                          avc:=C2=A0 receiv=
ed
                                                          policyload
                                                          notice
                                                          (seqno=3D2)<br>
                                                          <br>
                                                          <br>
runc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0
                                                          semodule<br>
-&gt;selinux_setprocattr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
-&gt;security_load_policy<br>
                                                          =C2=A0=C2=A0=C2=
=A0
                                                          -&gt;security_con=
text_to_sid=C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0
                                                          -&gt;sidtab_shutd=
own(oldsidtab)<br>
                                                          =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                                          -&gt;read_lock(&a=
mp;policy_rwlock);=C2=A0=C2=A0<wbr>=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0
                                                          -&gt;sidtab_map(&=
amp;oldsidtab,
                                                          clone_sid,
                                                          &amp;newsidtab);<=
br>
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 <br>
                                                          =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                                          -&gt;sidtab_conte=
xt_to_sid=C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 <br>
                                                          =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s-&gt;n=
ext_sid =3D=3D UINT_MAX || s-&gt;<font color=3D"#ff0000">shutdown</font>)
                                                          {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -<f=
ont color=3D"#ff0000">ENOMEM</font>;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....<br>
                                                          =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
                                                          =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
                                                          -&gt;read_unlock(=
&amp;policy_rwlock);<wbr>=C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 <br>
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          -&gt;write_lock_i=
rq(&amp;policy_rwloc<wbr>k);<br>
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0
                                                          -&gt;&quot;switch
                                                          to new
                                                          policydb&quot;<br=
>
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0
                                                          -&gt;write_unlock=
_irq(&amp;policy_rwl<wbr>ock);<br>
                                                          <br>
                                                          I wonder that
                                                          if this is the
                                                          intention or a
                                                          bug?<br>
                                                          If it is the
                                                          intention,
                                                          what should
                                                          the
                                                          application do
                                                          when it get
                                                          -ENOMEM
                                                          error,=C2=A0 to t=
ry
                                                          again?<br>
                                                          If it is a
                                                          bug, may the
                                                          two options
                                                          below suitable
                                                          to solve the
                                                          issue?<br>
                                                          Option1:<br>
                                                          =C2=A0=C2=A0=C2=
=A0 use
                                                          policy_rwlock
                                                          to protect the
&quot;sidtab_shutdown&quot; &amp; &quot;sidtab_map&quot; , load_policy is r=
arely to be
                                                          called after
                                                          system
                                                          bringing up,=C2=
=A0
                                                          <br>
                                                          so i think it
                                                          will not
                                                          impact much on
                                                          the
                                                          performance.<br>
                                                          Option2:<br>
                                                          =C2=A0=C2=A0=C2=
=A0 Use a temp
                                                          list to store
                                                          the sid in
                                                          oldsidtab
                                                          after it is
                                                          shutdown, and
                                                          deal with it <br>
                                                          after cloning
                                                          the major sids
                                                          from oldsidtab
                                                          to newsidtab
                                                          and getting
                                                          the
                                                          policy_rwlock.</d=
iv>
                                                        </blockquote>
                                                        <div><br>
                                                        </div>
                                                        <div>The current
                                                          logic is
                                                          intentional.=C2=
=A0
                                                          One might
                                                          argue that a
                                                          different
                                                          error code
                                                          might be more
                                                          suitable in
                                                          this situation
                                                          (e.g. EAGAIN
                                                          or something),
                                                          but ENOMEM is
                                                          already a
                                                          possible error
                                                          code when
                                                          loading policy
                                                          upon transient
                                                          OOM
                                                          conditions, so
                                                          the caller
                                                          might have to
                                                          retry
                                                          regardless.=C2=A0
                                                          The policy
                                                          write lock
                                                          must only be
                                                          held for the
                                                          minimal
                                                          critical
                                                          section as
                                                          otherwise all
                                                          system
                                                          activity could
                                                          be blocked; it
                                                          is only held
                                                          when making
                                                          the new
                                                          policydb and
                                                          sidtab active
                                                          not during
                                                          their
                                                          allocation and
                                                          setup -
                                                          ideally it
                                                          would be
                                                          further
                                                          reduced to a
                                                          couple of
                                                          pointer
                                                          updates. Is
                                                          this scenario
                                                          something you
                                                          are
                                                          encountering
                                                          in actual
                                                          practice or
                                                          just a
                                                          theoretically
                                                          possible one?=C2=
=A0
                                                          <br>
                                                        </div>
                                                      </div>
                                                    </div>
                                                  </div>
                                                </blockquote>
                                              </div>
                                              Thank you very much for
                                              your reply.<br>
                                              Yes, we encounter this
                                              issue in our
                                              implementation.<br>
                                              We have an intertion in
                                              our design that we can
                                              divide the policy into
                                              several parts to load
                                              separately. <br>
                                              So after the red-hat linux
                                              bringing up, which has
                                              loaded the system policy
                                              db released by redhat, we
                                              begin to load the policy
                                              released by our product ,
                                              <br>
                                              and meanwhile someone want
                                              to start a docker
                                              container, and the runc
                                              get an ENOMEM error like i
                                              mentioned above.<br>
                                              Should we merge all the
                                              policy into the system
                                              policy db and just load
                                              once?
                                              <div class=3D"m_-541633156740=
9940856m_7577183107687087194m_-6377092796483830810quoted-text"><br>
                                                <br>
                                                <pre class=3D"m_-5416331567=
409940856m_7577183107687087194m_-6377092796483830810m_-6684914453742943450m=
oz-signature" cols=3D"72">--=20
Best Regards
Li Kun</pre>
                                              </div>
                                            </div>
                                          </blockquote>
                                        </div>
                                        <span style=3D"font-family:sans-ser=
if">Typically
                                          you would install your policy
                                          module when your package is
                                          installed and not need to do
                                          it at runtime. </span><br>
                                      </div>
                                    </div>
                                  </div>
                                </blockquote>
                              </div>
                              Would you think it&#39;s suibable to change
                              the error code to EAGAIN=EF=BC=9F</div>
                          </blockquote>
                        </div>
                      </div>
                      <div dir=3D"auto"><br>
                      </div>
                      <div class=3D"gmail_extra" dir=3D"auto">
                        <div class=3D"gmail_quote">
                          <blockquote class=3D"m_-5416331567409940856m_7577=
183107687087194quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"> </blockquote>
                        </div>
                        <span style=3D"font-family:sans-serif">You likely
                          want it to return - EINTR or -ERESTARTSYS if
                          you want existing callers of setprocattr to
                          automatically restart the call instead of
                          failing. </span><br style=3D"font-family:sans-ser=
if">
                      </div>
                    </div>
                  </blockquote>
                </div>
                AFAIU, the EINTR &amp; ERESTARTSYS are releated to
                sigpending under most circumstances, is it proper to use
                them here?<br>
                And as i mentioned above, most apps(like runc, bind)do
                not retry when they meet ENOMEM, so i think maybe EAGAIN
                is more suitable for the transient race conditions</div>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div class=3D"gmail_extra" dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"m_-5416331567409940856quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
            </blockquote>
          </div>
          <span style=3D"font-family:sans-serif">EINTR is already handled
            by the libselinux procattr code, so returning that will
            cause existing users of the libselinux interfaces to retry.
            EAGAIN is not handled since the descriptor is not marked
            nonblocking. </span><br>
        </div>
      </div>
    </blockquote>
    Ok, i understand, thank you.<br>
    Maybe i can send a patch to change the errno to EINTR if you think
    it make sense.<br>
    <br>
    <pre class=3D"m_-5416331567409940856moz-signature" cols=3D"72">--=20
Best Regards
Li Kun</pre>
  </div>

</blockquote></div></div>

--94eb2c0689d63102c90561f37586--
