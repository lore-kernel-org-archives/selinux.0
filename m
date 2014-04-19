Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3JIIjgU011175
 for <selinux@tycho.nsa.gov>; Sat, 19 Apr 2014 14:18:45 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so2502184wes.20
 for <selinux@tycho.nsa.gov>; Sat, 19 Apr 2014 11:18:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOFt0CSMUc6EOAnCR6EQgj0884iAgaMaa8M1QC81+Gc1n7-iQA@mail.gmail.com>
References: <1397793520.8610.3.camel@akshay-desktop>
 <53501640.7070809@tycho.nsa.gov>
 <CAOFt0CSMUc6EOAnCR6EQgj0884iAgaMaa8M1QC81+Gc1n7-iQA@mail.gmail.com>
Date: Sat, 19 Apr 2014 20:18:43 +0200
Message-ID: <CAOFt0CSj9SXXvSurtLNm2wgFfJ-L=DCChXVRdzACeQN5j-HWQA@mail.gmail.com>
Subject: Re: Regarding call security_compute_av()
From: Kernel freak <kernelfreak@gmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f46d04428c98e71bba04f7694bc0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f46d04428c98e71bba04f7694bc0
Content-Type: text/plain; charset=UTF-8

Hello,
       I have also modified one more function, test is underway. Please
find the code attached. It is taking a bit more time to compile. Thank you
for your patience.

static noinline int avc_denied(u32 ssid, u32 tsid,
             u16 tclass, u32 requested,
             unsigned flags,
             struct av_decision *avd)
{
    if (flags & AVC_STRICT)
        return 0;
        //return -EACCES;

    if (selinux_enforcing && !(avd->flags & AVD_FLAGS_PERMISSIVE))
        return 0;
        //return -EACCES;

    avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
                tsid, tclass, avd->seqno);
    return 0;
}


On Sat, Apr 19, 2014 at 8:06 PM, Kernel freak <kernelfreak@gmail.com> wrote:

> Hello,
>         As discussed in the thread before, avc_has_perm() and its variants
> are responsible to check if access is there in cache. If missing, then the
> policy is queried. What I did in the avc.c file(file is attached), I
> returned rc=0 all the time. Still there are AVC denials. Can anyone tell me
> how it is possible and where the denials are coming from. I am pasting some
> log also below. Please check out. Thank you for your time.
>
> AVC log :
> type=SYSCALL msg=audit(1397930313.086:269925): arch=c000003e syscall=2
> success=yes exit=12 a0=8918e0 a1=0 a2=1b6 a3=7f9450d02ed0 items=0 ppid=1390
> pid=1556 auid=4294967295 uid=1000 gid=1000 euid=1000 suid=1000 fsuid=1000
> egid=1000 sgid=1000 fsgid=1000 ses=4294967295 tty=(none)
> comm="unity-panel-ser" exe="/usr/lib/unity/unity-panel-service"
> subj=system_u:system_r:initrc_t:s0 key=(null)
> type=AVC msg=audit(1397930313.086:269925): avc:  denied  { read } for
> pid=1556 comm="unity-panel-ser" name="network-transmit-receive.svg"
> dev="sdb1" ino=4860464 scontext=system_u:system_r:initrc_t:s0
> tcontext=system_u:object_r:usr_t:s0 tclass=file
> ----
> time->Sat Apr 19 19:58:33 2014
> type=SYSCALL msg=audit(1397930313.086:269926): arch=c000003e syscall=21
> success=no exit=-2 a0=15bbe1c a1=0 a2=0 a3=0 items=0 ppid=1390 pid=1545
> auid=4294967295 uid=1000 gid=1000 euid=1000 suid=1000 fsuid=1000 egid=1000
> sgid=1000 fsgid=1000 ses=4294967295 tty=(none) comm="hud-service"
> exe="/usr/lib/x86_64-linux-gnu/hud/hud-service"
> subj=system_u:system_r:initrc_t:s0 key=(null)
> type=AVC msg=audit(1397930313.086:269926): avc:  denied  { search } for
> pid=1545 comm="hud-service" name="indicator-appmenu" dev="sdb1" ino=393355
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
> type=AVC msg=audit(1397930313.086:269926): avc:  denied  { search } for
> pid=1545 comm="hud-service" name=".cache" dev="sdb1" ino=393223
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
> ----
> time->Sat Apr 19 19:58:33 2014
> type=SYSCALL msg=audit(1397930313.086:269927): arch=c000003e syscall=21
> success=no exit=-2 a0=15bbe5f a1=0 a2=0 a3=0 items=0 ppid=1390 pid=1545
> auid=4294967295 uid=1000 gid=1000 euid=1000 suid=1000 fsuid=1000 egid=1000
> sgid=1000 fsgid=1000 ses=4294967295 tty=(none) comm="hud-service"
> exe="/usr/lib/x86_64-linux-gnu/hud/hud-service"
> subj=system_u:system_r:initrc_t:s0 key=(null)
> type=AVC msg=audit(1397930313.086:269927): avc:  denied  { search } for
> pid=1545 comm="hud-service" name="indicator-appmenu" dev="sdb1" ino=393355
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
> type=AVC msg=audit(1397930313.086:269927): avc:  denied  { search } for
> pid=1545 comm="hud-service" name=".cache" dev="sdb1" ino=393223
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
> ----
> time->Sat Apr 19 19:58:33 2014
> type=SYSCALL msg=audit(1397930313.086:269928): arch=c000003e syscall=21
> success=no exit=-2 a0=15bbe1c a1=0 a2=0 a3=0 items=0 ppid=1390 pid=1545
> auid=4294967295 uid=1000 gid=1000 euid=1000 suid=1000 fsuid=1000 egid=1000
> sgid=1000 fsgid=1000 ses=4294967295 tty=(none) comm="hud-service"
> exe="/usr/lib/x86_64-linux-gnu/hud/hud-service"
> subj=system_u:system_r:initrc_t:s0 key=(null)
> type=AVC msg=audit(1397930313.086:269928): avc:  denied  { search } for
> pid=1545 comm="hud-service" name="indicator-appmenu" dev="sdb1" ino=393355
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
> type=AVC msg=audit(1397930313.086:269928): avc:  denied  { search } for
> pid=1545 comm="hud-service" name=".cache" dev="sdb1" ino=393223
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
> ----
> time->Sat Apr 19 19:58:33 2014
> type=SYSCALL msg=audit(1397930313.086:269929): arch=c000003e syscall=21
> success=no exit=-2 a0=15bbe5f a1=0 a2=0 a3=0 items=0 ppid=1390 pid=1545
> auid=4294967295 uid=1000 gid=1000 euid=1000 suid=1000 fsuid=1000 egid=1000
> sgid=1000 fsgid=1000 ses=4294967295 tty=(none) comm="hud-service"
> exe="/usr/lib/x86_64-linux-gnu/hud/hud-service"
> subj=system_u:system_r:initrc_t:s0 key=(null)
> type=AVC msg=audit(1397930313.086:269929): avc:  denied  { search } for
> pid=1545 comm="hud-service" name="indicator-appmenu" dev="sdb1" ino=393355
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
> type=AVC msg=audit(1397930313.086:269929): avc:  denied  { search } for
> pid=1545 comm="hud-service" name=".cache" dev="sdb1" ino=393223
> scontext=system_u:system_r:initrc_t:s0
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
>
>
>
> On Thu, Apr 17, 2014 at 7:58 PM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> FWIW, I unsubscribed and banned bochen from the list for that completely
>> off-topic reply to this thread.  Don't respond to it, please.
>>
>>
>>
>

--f46d04428c98e71bba04f7694bc0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br></div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
I have also modified one more function, test is underway. Please find the c=
ode attached. It is taking a bit more time to compile. Thank you for your p=
atience.<br><br>static noinline int avc_denied(u32 ssid, u32 tsid,<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0u16 tclass, =
u32 requested,<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0unsigned flags,<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0struct av_decision *avd)<br>{<br>=C2=A0=C2=A0=C2=A0 if (flags =
&amp; AVC_STRICT)<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 0;<br>=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 //return -EACCES;<br><br>=C2=A0=C2=A0=C2=
=A0 if (selinux_enforcing &amp;&amp; !(avd-&gt;flags &amp; AVD_FLAGS_PERMIS=
SIVE))<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 0;<br>=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 //return -EACCES;<br><br>=C2=A0=C2=A0=C2=A0 avc_update_node=
(AVC_CALLBACK_GRANT, requested, ssid,<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tsid, tclass, avd-&gt;seqno);<br>=
=C2=A0=C2=A0=C2=A0 return 0;<br>}<br></div><div class=3D"gmail_extra"><br><=
br>
<div class=3D"gmail_quote">On Sat, Apr 19, 2014 at 8:06 PM, Kernel freak <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:kernelfreak@gmail.com" target=3D"_bla=
nk">kernelfreak@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<div dir=3D"ltr"><div><div>Hello,<br></div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 As discussed in the thread before, avc_has_perm() and its vari=
ants are responsible to check if access is there in cache. If missing, then=
 the policy is queried. What I did in the avc.c file(file is attached), I r=
eturned rc=3D0 all the time. Still there are AVC denials. Can anyone tell m=
e how it is possible and where the denials are coming from. I am pasting so=
me log also below. Please check out. Thank you for your time.<br>

<br></div>AVC log :<br>type=3DSYSCALL msg=3Daudit(1397930313.086:269925): a=
rch=3Dc000003e syscall=3D2 success=3Dyes exit=3D12 a0=3D8918e0 a1=3D0 a2=3D=
1b6 a3=3D7f9450d02ed0 items=3D0 ppid=3D1390 pid=3D1556 auid=3D4294967295 ui=
d=3D1000 gid=3D1000 euid=3D1000 suid=3D1000 fsuid=3D1000 egid=3D1000 sgid=
=3D1000 fsgid=3D1000 ses=3D4294967295 tty=3D(none) comm=3D&quot;unity-panel=
-ser&quot; exe=3D&quot;/usr/lib/unity/unity-panel-service&quot; subj=3Dsyst=
em_u:system_r:initrc_t:s0 key=3D(null)<br>

type=3DAVC msg=3Daudit(1397930313.086:269925): avc:=C2=A0 denied=C2=A0 { re=
ad } for=C2=A0 pid=3D1556 comm=3D&quot;unity-panel-ser&quot; name=3D&quot;n=
etwork-transmit-receive.svg&quot; dev=3D&quot;sdb1&quot; ino=3D4860464 scon=
text=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:usr_t:s0 =
tclass=3Dfile<br>

----<br>time-&gt;Sat Apr 19 19:58:33 2014<br>type=3DSYSCALL msg=3Daudit(139=
7930313.086:269926): arch=3Dc000003e syscall=3D21 success=3Dno exit=3D-2 a0=
=3D15bbe1c a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1390 pid=3D1545 auid=3D429=
4967295 uid=3D1000 gid=3D1000 euid=3D1000 suid=3D1000 fsuid=3D1000 egid=3D1=
000 sgid=3D1000 fsgid=3D1000 ses=3D4294967295 tty=3D(none) comm=3D&quot;hud=
-service&quot; exe=3D&quot;/usr/lib/x86_64-linux-gnu/hud/hud-service&quot; =
subj=3Dsystem_u:system_r:initrc_t:s0 key=3D(null)<br>

type=3DAVC msg=3Daudit(1397930313.086:269926): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;ind=
icator-appmenu&quot; dev=3D&quot;sdb1&quot; ino=3D393355 scontext=3Dsystem_=
u:system_r:initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tcla=
ss=3Ddir<br>

type=3DAVC msg=3Daudit(1397930313.086:269926): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;.ca=
che&quot; dev=3D&quot;sdb1&quot; ino=3D393223 scontext=3Dsystem_u:system_r:=
initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tclass=3Ddir<br=
>

----<br>time-&gt;Sat Apr 19 19:58:33 2014<br>type=3DSYSCALL msg=3Daudit(139=
7930313.086:269927): arch=3Dc000003e syscall=3D21 success=3Dno exit=3D-2 a0=
=3D15bbe5f a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1390 pid=3D1545 auid=3D429=
4967295 uid=3D1000 gid=3D1000 euid=3D1000 suid=3D1000 fsuid=3D1000 egid=3D1=
000 sgid=3D1000 fsgid=3D1000 ses=3D4294967295 tty=3D(none) comm=3D&quot;hud=
-service&quot; exe=3D&quot;/usr/lib/x86_64-linux-gnu/hud/hud-service&quot; =
subj=3Dsystem_u:system_r:initrc_t:s0 key=3D(null)<br>

type=3DAVC msg=3Daudit(1397930313.086:269927): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;ind=
icator-appmenu&quot; dev=3D&quot;sdb1&quot; ino=3D393355 scontext=3Dsystem_=
u:system_r:initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tcla=
ss=3Ddir<br>

type=3DAVC msg=3Daudit(1397930313.086:269927): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;.ca=
che&quot; dev=3D&quot;sdb1&quot; ino=3D393223 scontext=3Dsystem_u:system_r:=
initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tclass=3Ddir<br=
>

----<br>time-&gt;Sat Apr 19 19:58:33 2014<br>type=3DSYSCALL msg=3Daudit(139=
7930313.086:269928): arch=3Dc000003e syscall=3D21 success=3Dno exit=3D-2 a0=
=3D15bbe1c a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1390 pid=3D1545 auid=3D429=
4967295 uid=3D1000 gid=3D1000 euid=3D1000 suid=3D1000 fsuid=3D1000 egid=3D1=
000 sgid=3D1000 fsgid=3D1000 ses=3D4294967295 tty=3D(none) comm=3D&quot;hud=
-service&quot; exe=3D&quot;/usr/lib/x86_64-linux-gnu/hud/hud-service&quot; =
subj=3Dsystem_u:system_r:initrc_t:s0 key=3D(null)<br>

type=3DAVC msg=3Daudit(1397930313.086:269928): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;ind=
icator-appmenu&quot; dev=3D&quot;sdb1&quot; ino=3D393355 scontext=3Dsystem_=
u:system_r:initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tcla=
ss=3Ddir<br>

type=3DAVC msg=3Daudit(1397930313.086:269928): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;.ca=
che&quot; dev=3D&quot;sdb1&quot; ino=3D393223 scontext=3Dsystem_u:system_r:=
initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tclass=3Ddir<br=
>

----<br>time-&gt;Sat Apr 19 19:58:33 2014<br>type=3DSYSCALL msg=3Daudit(139=
7930313.086:269929): arch=3Dc000003e syscall=3D21 success=3Dno exit=3D-2 a0=
=3D15bbe5f a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1390 pid=3D1545 auid=3D429=
4967295 uid=3D1000 gid=3D1000 euid=3D1000 suid=3D1000 fsuid=3D1000 egid=3D1=
000 sgid=3D1000 fsgid=3D1000 ses=3D4294967295 tty=3D(none) comm=3D&quot;hud=
-service&quot; exe=3D&quot;/usr/lib/x86_64-linux-gnu/hud/hud-service&quot; =
subj=3Dsystem_u:system_r:initrc_t:s0 key=3D(null)<br>

type=3DAVC msg=3Daudit(1397930313.086:269929): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;ind=
icator-appmenu&quot; dev=3D&quot;sdb1&quot; ino=3D393355 scontext=3Dsystem_=
u:system_r:initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tcla=
ss=3Ddir<br>

type=3DAVC msg=3Daudit(1397930313.086:269929): avc:=C2=A0 denied=C2=A0 { se=
arch } for=C2=A0 pid=3D1545 comm=3D&quot;hud-service&quot; name=3D&quot;.ca=
che&quot; dev=3D&quot;sdb1&quot; ino=3D393223 scontext=3Dsystem_u:system_r:=
initrc_t:s0 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tclass=3Ddir<br=
>

<br></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra=
"><br><br><div class=3D"gmail_quote">On Thu, Apr 17, 2014 at 7:58 PM, Steph=
en Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" targe=
t=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">FWIW, I unsubscribed and banned bochen from =
the list for that completely<br>
off-topic reply to this thread. =C2=A0Don&#39;t respond to it, please.<br>
<br>
<br>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--f46d04428c98e71bba04f7694bc0--
