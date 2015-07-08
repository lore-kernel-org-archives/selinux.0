Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t68I7jwa000458
 for <selinux@tycho.nsa.gov>; Wed, 8 Jul 2015 14:07:45 -0400
Received: by wgck11 with SMTP id k11so203110699wgc.0
 for <selinux@tycho.nsa.gov>; Wed, 08 Jul 2015 11:07:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <559D623D.405@schaufler-ca.com>
References: <CA+55aFxmm7THBsCK62esr=JCcHpn6nmReGKqPp0inUrhbkveuA@mail.gmail.com>
 <CAKocOOM0-uce9kUzprCW9M48_G2OTV-eWgPe4euht2qY8FdA3A@mail.gmail.com>
 <CA+55aFy-iZ2g8xKZW---LgUHaVMbqLZ_oadw=Vbg0g78dfH9PA@mail.gmail.com>
 <CA+55aFyYFhkupwb0tVLCDWQs9H1DX0kXZZkCwax_xUOUMfDgxA@mail.gmail.com>
 <559D623D.405@schaufler-ca.com>
Date: Wed, 8 Jul 2015 11:07:39 -0700
Message-ID: <CAFftDdr54GLdtZ+biC2hpbyjbHe+SKbLEbz0fbLVrK3sdBD+Vw@mail.gmail.com>
Subject: Re: Linux 4.2-rc1
From: William Roberts <bill.c.roberts@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Content-Type: multipart/alternative; boundary=f46d043c80d2b2af5f051a61031a
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@canonical.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuahkhan@gmail.com>,
 SE Linux <selinux@tycho.nsa.gov>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f46d043c80d2b2af5f051a61031a
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 8, 2015 at 10:47 AM, Casey Schaufler <casey@schaufler-ca.com>
wrote:

> On 7/8/2015 10:29 AM, Linus Torvalds wrote:
> > On Wed, Jul 8, 2015 at 10:17 AM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> Decoding the "Code:" line shows that this is the "->fw_id" dereference
> in
> >>
> >>         if (add_uevent_var(env, "FIRMWARE=%s", fw_priv->buf->fw_id))
> >>                 return -ENOMEM;
> >>
> >> and that "fw_priv->buf" pointer is NULL.
> >>
> >> However, I don't see anything that looks like it should have changed
> >> any of this since 4.1.
> > Looking at the otehr uses of "fw_priv->buf", they all check that
> > pointer for NULL. I see code like
> >
> >         fw_buf = fw_priv->buf;
> >         if (!fw_buf)
> >                 goto out;
> >
> > etc.
> >
> > Also, it looks like you need to hold the "fw_lock" to even look at
> > that pointer, since the buffer can get reallocated etc.
> >
> > So that uevent code really looks buggy. It just doesn't look like a
> > *new* bug to me. That code looks old, going back to 2012 and commit
> > 1244691c73b2.
>
> There have been SELinux changes to kernfs for 4.2. William,
> you might want to have a look here.
>

My changes were never merged AFAIK and can tell. I was still working on this
but we had some changes internally to SELinux that let us handle this,
although
we should correct this on kernfs at some point, its low priority for me
now. Also
commit fb029 makes kernfs_get_inode() public, so I need to rethink some
things.


>
> >
> > Ming Lei?
> >
> >                  Linus
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Respectfully,

William C Roberts

--f46d043c80d2b2af5f051a61031a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Jul 8, 2015 at 10:47 AM, Casey Schaufler <span dir=3D"ltr">&lt;=
<a href=3D"mailto:casey@schaufler-ca.com" target=3D"_blank">casey@schaufler=
-ca.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,2=
04,204);border-left-style:solid;padding-left:1ex">On 7/8/2015 10:29 AM, Lin=
us Torvalds wrote:<br>
&gt; On Wed, Jul 8, 2015 at 10:17 AM, Linus Torvalds<br>
&gt; &lt;<a href=3D"mailto:torvalds@linux-foundation.org">torvalds@linux-fo=
undation.org</a>&gt; wrote:<br>
&gt;&gt; Decoding the &quot;Code:&quot; line shows that this is the &quot;-=
&gt;fw_id&quot; dereference in<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (add_uevent_var(env, &quot;FIR=
MWARE=3D%s&quot;, fw_priv-&gt;buf-&gt;fw_id))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -ENOMEM;<br>
&gt;&gt;<br>
&gt;&gt; and that &quot;fw_priv-&gt;buf&quot; pointer is NULL.<br>
&gt;&gt;<br>
&gt;&gt; However, I don&#39;t see anything that looks like it should have c=
hanged<br>
&gt;&gt; any of this since 4.1.<br>
&gt; Looking at the otehr uses of &quot;fw_priv-&gt;buf&quot;, they all che=
ck that<br>
&gt; pointer for NULL. I see code like<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw_buf =3D fw_priv-&gt;buf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fw_buf)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;=
<br>
&gt;<br>
&gt; etc.<br>
&gt;<br>
&gt; Also, it looks like you need to hold the &quot;fw_lock&quot; to even l=
ook at<br>
&gt; that pointer, since the buffer can get reallocated etc.<br>
&gt;<br>
&gt; So that uevent code really looks buggy. It just doesn&#39;t look like =
a<br>
&gt; *new* bug to me. That code looks old, going back to 2012 and commit<br=
>
&gt; 1244691c73b2.<br>
<br>
There have been SELinux changes to kernfs for 4.2. William,<br>
you might want to have a look here.<br></blockquote><div><br></div><div>My =
changes were never merged AFAIK and can tell. I was still working on this</=
div><div>but we had some changes internally to SELinux that let us handle t=
his, although</div><div>we should correct this on kernfs at some point, its=
 low priority for me now. Also</div><div>commit=C2=A0fb029 makes kernfs_get=
_inode() public, so I need to rethink some things.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pad=
ding-left:1ex">
<br>
&gt;<br>
&gt; Ming Lei?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Linus<br=
>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-k=
ernel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/m=
ajordomo-info.html</a><br>
&gt; Please read the FAQ at=C2=A0 <a href=3D"http://www.tux.org/lkml/" rel=
=3D"noreferrer" target=3D"_blank">http://www.tux.org/lkml/</a><br>
&gt;<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</div></div>

--f46d043c80d2b2af5f051a61031a--
