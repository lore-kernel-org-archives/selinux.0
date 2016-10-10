Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9AHoX5o021033
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 13:50:33 -0400
Received: by mail-qt0-f182.google.com with SMTP id f6so64333926qtd.2
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 10:50:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
 <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
 <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
 <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 10 Oct 2016 10:50:11 -0700
Message-ID: <CABXk95BMHF1aRJNU=xFCABAKP8Nr20ayGqSOvBixzPR3QoPDHg@mail.gmail.com>
Subject: Re: should module_load be checked on a kernel module object?
To: Dominick Grift <dac.override@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1144831e44dff3053e866472
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144831e44dff3053e866472
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 10, 2016 at 10:21 AM Dominick Grift <dac.override@gmail.com>
wrote:

> On 10/10/2016 07:16 PM, Jeffrey Vander Stoep wrote:
> > No problem. We went through a number of iterations on this patch
> > because of how confusing the target object for init_module is.
> >
> > On Android we neverallow use of init_module. Forcing userspace to use
> > finit_module allows us to enforce restrictions on kernel module
> > origin. We only allow module loading from verified-boot protected
> > partitions.
> >
> > https://android-review.googlesource.com/#/c/214021/
> >
>
> That is a nice approach. After you reminded me, i started looking at my
> policy and i actually commented it (i rarely comment in my policy):
>
>                 ; for compatibility with Linux =< 4.6
>                 (allow sys.load_kernel_module_subj_type_attribute self
> (system (module_load))))))
>
> So i suppose if i want to support Linux 4.6 then i might not have the
> option to neverallow it.
>
>
You shouldn't need this for compatibility. For kernel version <= 4.6, the
kernel hook for selinux_kernel_read_file is unused so no policy is needed,
it will already be allowed (or rather, not checked).

The issue is that modprobe uses init_module() to load a kernel module. That
would need to be updated to use finit_module() in order to disallow
init_module().

modprobe could be updated to behave more like insmod which defaults to
using finit_module and falls back to init_module for old kernels.
https://android.googlesource.com/platform/external/toybox/+/android-7.0.0_r14/toys/other/insmod.c#37

I don't know what kind of control you have over kernels, but if you want a
stable backport of the module_load patch, we backported to 4.4, 4,1, 3.18,
3.14, and 3.10:
https://android-review.googlesource.com/#/q/61d612ea731e57dc510472fb746b55cdc017f371+owner:jeffv

--001a1144831e44dff3053e866472
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon=
, Oct 10, 2016 at 10:21 AM Dominick Grift &lt;<a href=3D"mailto:dac.overrid=
e@gmail.com" target=3D"_blank">dac.override@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/10/2016 07:16 PM=
, Jeffrey Vander Stoep wrote:<br class=3D"gmail-m_-1568283336817477874gmail=
_msg">
&gt; No problem. We went through a number of iterations on this patch<br cl=
ass=3D"gmail-m_-1568283336817477874gmail_msg">
&gt; because of how confusing the target object for init_module is.<br clas=
s=3D"gmail-m_-1568283336817477874gmail_msg">
&gt;<br class=3D"gmail-m_-1568283336817477874gmail_msg">
&gt; On Android we neverallow use of init_module. Forcing userspace to use<=
br class=3D"gmail-m_-1568283336817477874gmail_msg">
&gt; finit_module allows us to enforce restrictions on kernel module<br cla=
ss=3D"gmail-m_-1568283336817477874gmail_msg">
&gt; origin. We only allow module loading from verified-boot protected<br c=
lass=3D"gmail-m_-1568283336817477874gmail_msg">
&gt; partitions.<br class=3D"gmail-m_-1568283336817477874gmail_msg">
&gt;<br class=3D"gmail-m_-1568283336817477874gmail_msg">
&gt; <a href=3D"https://android-review.googlesource.com/#/c/214021/" rel=3D=
"noreferrer" class=3D"gmail-m_-1568283336817477874gmail_msg" target=3D"_bla=
nk">https://android-review.<wbr>googlesource.com/#/c/214021/</a><br class=
=3D"gmail-m_-1568283336817477874gmail_msg">
&gt;<br class=3D"gmail-m_-1568283336817477874gmail_msg">
<br class=3D"gmail-m_-1568283336817477874gmail_msg">
That is a nice approach. After you reminded me, i started looking at my<br =
class=3D"gmail-m_-1568283336817477874gmail_msg">
policy and i actually commented it (i rarely comment in my policy):<br clas=
s=3D"gmail-m_-1568283336817477874gmail_msg">
<br class=3D"gmail-m_-1568283336817477874gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; for compatibility=
 with Linux =3D&lt; 4.6<br class=3D"gmail-m_-1568283336817477874gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (allow sys.load_ker=
nel_module_subj_<wbr>type_attribute self<br class=3D"gmail-m_-1568283336817=
477874gmail_msg">
(system (module_load))))))<br class=3D"gmail-m_-1568283336817477874gmail_ms=
g">
<br class=3D"gmail-m_-1568283336817477874gmail_msg">
So i suppose if i want to support Linux 4.6 then i might not have the<br cl=
ass=3D"gmail-m_-1568283336817477874gmail_msg">
option to neverallow it.<br class=3D"gmail-m_-1568283336817477874gmail_msg"=
><br class=3D"gmail-m_-1568283336817477874gmail_msg"></blockquote><div><br>=
</div><div>You shouldn&#39;t need this for compatibility. For kernel versio=
n &lt;=3D 4.6, the kernel hook for selinux_kernel_read_file=C2=A0is unused =
so no policy is needed, it will already be allowed (or rather, not checked)=
.<br><br>The issue is that modprobe uses init_module() to load a kernel mod=
ule. That would need to be updated to use finit_module() in order to disall=
ow init_module().</div><div><br></div><div>modprobe could be updated to beh=
ave more like insmod which defaults to using finit_module and falls back to=
 init_module for old kernels.=C2=A0<a href=3D"https://android.googlesource.=
com/platform/external/toybox/+/android-7.0.0_r14/toys/other/insmod.c#37">ht=
tps://android.googlesource.com/platform/external/toybox/+/android-7.0.0_r14=
/toys/other/insmod.c#37</a></div><div><br></div><div>I don&#39;t know what =
kind of control you have over kernels, but if you want a stable backport of=
 the module_load patch, we backported to 4.4, 4,1, 3.18, 3.14, and 3.10:=C2=
=A0<a href=3D"https://android-review.googlesource.com/#/q/61d612ea731e57dc5=
10472fb746b55cdc017f371+owner:jeffv">https://android-review.googlesource.co=
m/#/q/61d612ea731e57dc510472fb746b55cdc017f371+owner:jeffv</a></div></div><=
/div>

--001a1144831e44dff3053e866472--
