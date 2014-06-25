Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5PNJW1v017651
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 19:19:37 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so2923764oag.21
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 16:19:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A2VnkCh3ru7ZKST0e55DnpMxPEbzDdczwDY7o0tsZdjnw@mail.gmail.com>
References: <CAEFn6A4mzF208e1s_OHEzJ-1Kq-DUGgzVNbQXrW6NbB0e8DSpQ@mail.gmail.com>
 <CAB9W1A3HhfPimsRB4Qtf91hCM8u2Ds+yzK9XBYr6eEcdDP+wWQ@mail.gmail.com>
 <58493927.vocElXfMed@sifl>
 <CAB9W1A2VnkCh3ru7ZKST0e55DnpMxPEbzDdczwDY7o0tsZdjnw@mail.gmail.com>
Date: Thu, 26 Jun 2014 08:19:39 +0900
Message-ID: <CAEFn6A7SJMG89puP-=VHdANrAUEDBHpxUqL1+Yb1q1qmPxtdxg@mail.gmail.com>
Subject: Re: Fwd: Booting time is increased after applying kernel 3.10
From: Jaejyn Shin <flagon22bass@gmail.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c2ec9a7adb9904fcb14fc0
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c2ec9a7adb9904fcb14fc0
Content-Type: text/plain; charset=UTF-8

Thank you for your comment.
Then, I will remove the calling avc_ss_reset during bootup and test my
device many times to find side-effect.


2014-06-26 4:49 GMT+09:00 Stephen Smalley <stephen.smalley@gmail.com>:

> I suspect it won't matter in practice, but the reason for it is that
> permissions or other state may have been cached during bootup prior to
> initial policy load that may no longer be valid.
>
> On Wed, Jun 25, 2014 at 3:29 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Wednesday, June 25, 2014 03:14:56 PM Stephen Smalley wrote:
> >> ---------- Forwarded message ----------
> >> From: Jaejyn Shin <flagon22bass@gmail.com>
> >> Date: Wed, Jun 25, 2014 at 4:36 AM
> >> Subject: Booting time is increased after applying kernel 3.10
> >> To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
> >>
> >>
> >>
> >> Dear SEAndroid and SELinux developer
> >> First of all, I always appreciate that I get lots of information in
> >> this e-mailing list.
> >>
> >> After applying kernel 3.10, the booting time of my device has been
> increased
> >> Especially, the selinux initializing time is increased (about 0.5s).
> >>
> >> I analized the reason, and I found that the synchronize_net function
> >> has 0.1s delay.
> >
> > I would need to give it some more thought, but since the
> netport/netnode/netif
> > caches all have their own locks it may be possible to skip the
> > synchronize_net() call.  Although, looking at this a bit closer, I
> wonder if
> > it would be possible to just skip the avc_ss_reset() call for the initial
> > policy load, or at least skip the callback processing.  Am I missing
> > something?
> >
> >> before)
> >> selinux_initialize
> >>     -> selinux_android_load_policy
> >>    -> selinux_android_reload_policy
> >>    -> security_load_policy
> >>    -> avc_ss_reset
> >>    -> sel_netport_avc_callback -> synchronize_net
> >> -> sel_netnode_avc_callback -> synchronize_net
> >> -> sel_netif_avc_callback -> synchronize_net
> >>     -> security_setenforce
> >>    -> sel_write_enforce
> >>    -> avc_ss_reset
> >> -> sel_netport_avc_callback -> synchronize_net
> >>    -> sel_netnode_avc_callback -> synchronize_net
> >> -> sel_netif_avc_callback -> synchronize_net
> >> To make fast the booting time, can I don't call the avc_ss_reset
> >> function only during initializing selinux ?
> >>
> >> after)
> >> selinux_initialize
> >>     -> selinux_android_load_policy
> >>    -> selinux_android_reload_policy
> >>    -> security_load_policy
> >>    X-> avc_ss_reset
> >>     -> security_setenforce
> >>    -> sel_write_enforce
> >>    X-> avc_ss_reset
> >>
> >> Is it possible?
> >>
> >> Thank you
> >> Best regards
> >>
> >> _______________________________________________
> >> Seandroid-list mailing list
> >> Seandroid-list@tycho.nsa.gov
> >> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> >> To get help, send an email containing "help" to
> >> Seandroid-list-request@tycho.nsa.gov.
> >
> > --
> > paul moore
> > www.paul-moore.com
> >
>

--001a11c2ec9a7adb9904fcb14fc0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for your comment.<div>Then, I will remove the ca=
lling=C2=A0<span style=3D"font-family:arial,sans-serif;font-size:14.4444446=
5637207px">avc_ss_reset during bootup and test my device many times to find=
 side-effect.</span></div>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2014-06=
-26 4:49 GMT+09:00 Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:=
stephen.smalley@gmail.com" target=3D"_blank">stephen.smalley@gmail.com</a>&=
gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I suspect it won&#39;t matter in practice, b=
ut the reason for it is that<br>
permissions or other state may have been cached during bootup prior to<br>
initial policy load that may no longer be valid.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Wed, Jun 25, 2014 at 3:29 PM, Paul Moore &lt;<a href=3D"mailto:paul@paul=
-moore.com">paul@paul-moore.com</a>&gt; wrote:<br>
&gt; On Wednesday, June 25, 2014 03:14:56 PM Stephen Smalley wrote:<br>
&gt;&gt; ---------- Forwarded message ----------<br>
&gt;&gt; From: Jaejyn Shin &lt;<a href=3D"mailto:flagon22bass@gmail.com">fl=
agon22bass@gmail.com</a>&gt;<br>
&gt;&gt; Date: Wed, Jun 25, 2014 at 4:36 AM<br>
&gt;&gt; Subject: Booting time is increased after applying kernel 3.10<br>
&gt;&gt; To: &quot;<a href=3D"mailto:seandroid-list@tycho.nsa.gov">seandroi=
d-list@tycho.nsa.gov</a>&quot; &lt;<a href=3D"mailto:seandroid-list@tycho.n=
sa.gov">seandroid-list@tycho.nsa.gov</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Dear SEAndroid and SELinux developer<br>
&gt;&gt; First of all, I always appreciate that I get lots of information i=
n<br>
&gt;&gt; this e-mailing list.<br>
&gt;&gt;<br>
&gt;&gt; After applying kernel 3.10, the booting time of my device has been=
 increased<br>
&gt;&gt; Especially, the selinux initializing time is increased (about 0.5s=
).<br>
&gt;&gt;<br>
&gt;&gt; I analized the reason, and I found that the synchronize_net functi=
on<br>
&gt;&gt; has 0.1s delay.<br>
&gt;<br>
&gt; I would need to give it some more thought, but since the netport/netno=
de/netif<br>
&gt; caches all have their own locks it may be possible to skip the<br>
&gt; synchronize_net() call. =C2=A0Although, looking at this a bit closer, =
I wonder if<br>
&gt; it would be possible to just skip the avc_ss_reset() call for the init=
ial<br>
&gt; policy load, or at least skip the callback processing. =C2=A0Am I miss=
ing<br>
&gt; something?<br>
&gt;<br>
&gt;&gt; before)<br>
&gt;&gt; selinux_initialize<br>
&gt;&gt; =C2=A0 =C2=A0 -&gt; selinux_android_load_policy<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; selinux_android_reload_policy<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; security_load_policy<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; avc_ss_reset<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; sel_netport_avc_callback -&gt; synchronize_net<=
br>
&gt;&gt; -&gt; sel_netnode_avc_callback -&gt; synchronize_net<br>
&gt;&gt; -&gt; sel_netif_avc_callback -&gt; synchronize_net<br>
&gt;&gt; =C2=A0 =C2=A0 -&gt; security_setenforce<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; sel_write_enforce<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; avc_ss_reset<br>
&gt;&gt; -&gt; sel_netport_avc_callback -&gt; synchronize_net<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; sel_netnode_avc_callback -&gt; synchronize_net<=
br>
&gt;&gt; -&gt; sel_netif_avc_callback -&gt; synchronize_net<br>
&gt;&gt; To make fast the booting time, can I don&#39;t call the avc_ss_res=
et<br>
&gt;&gt; function only during initializing selinux ?<br>
&gt;&gt;<br>
&gt;&gt; after)<br>
&gt;&gt; selinux_initialize<br>
&gt;&gt; =C2=A0 =C2=A0 -&gt; selinux_android_load_policy<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; selinux_android_reload_policy<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; security_load_policy<br>
&gt;&gt; =C2=A0 =C2=A0X-&gt; avc_ss_reset<br>
&gt;&gt; =C2=A0 =C2=A0 -&gt; security_setenforce<br>
&gt;&gt; =C2=A0 =C2=A0-&gt; sel_write_enforce<br>
&gt;&gt; =C2=A0 =C2=A0X-&gt; avc_ss_reset<br>
&gt;&gt;<br>
&gt;&gt; Is it possible?<br>
&gt;&gt;<br>
&gt;&gt; Thank you<br>
&gt;&gt; Best regards<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Seandroid-list mailing list<br>
&gt;&gt; <a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@tyc=
ho.nsa.gov</a><br>
&gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-lea=
ve@tycho.nsa.gov">Seandroid-list-leave@tycho.nsa.gov</a>.<br>
&gt;&gt; To get help, send an email containing &quot;help&quot; to<br>
&gt;&gt; <a href=3D"mailto:Seandroid-list-request@tycho.nsa.gov">Seandroid-=
list-request@tycho.nsa.gov</a>.<br>
&gt;<br>
&gt; --<br>
&gt; paul moore<br>
&gt; <a href=3D"http://www.paul-moore.com" target=3D"_blank">www.paul-moore=
.com</a><br>
&gt;<br>
</div></div></blockquote></div><br></div>

--001a11c2ec9a7adb9904fcb14fc0--
