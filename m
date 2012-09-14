MIME-Version: 1.0
In-Reply-To: <1347647563.11029.80.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdpCZGKGMGK9-G69SL1apEBWgfE57FpcMf0AS7tsGJCOeg@mail.gmail.com>
	<1347647563.11029.80.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 14 Sep 2012 11:41:40 -0700
Message-ID: <CAFftDdrP0C9SAd_mGgFbBO3KnOsjTNLsZw3Tdx6XWe_hndShPA@mail.gmail.com>
Subject: Re: dev ion
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b2ee6e756ffd904c9adc6f5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b2ee6e756ffd904c9adc6f5
Content-Type: text/plain; charset=ISO-8859-1

I didn't either, but that article used a four letter word "sharing" and I
thought I was missing something, (Which is usually the case ;-) )

On Fri, Sep 14, 2012 at 11:32 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-09-14 at 11:24 -0700, William Roberts wrote:
> > Based on this article and "sharing
> > buffers", http://lwn.net/Articles/480055/
> >
> >
> > We may need to instrument LSM hooks for ION.
> >
> >
> > Thoughts?
>
> Possibly, but I don't see any DAC checks or capable calls in the current
> ion driver code.  If the only way to share is by passing open fds, then
> we already control that via the existing SELinux hooks.
>
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--047d7b2ee6e756ffd904c9adc6f5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I didn&#39;t either, but that article used a four letter word &quot;sharing=
&quot; and I thought I was missing something, (Which is usually the case ;-=
) )<br><br><div class=3D"gmail_quote">On Fri, Sep 14, 2012 at 11:32 AM, Ste=
phen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" tar=
get=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, 2012-09-14 at 11:2=
4 -0700, William Roberts wrote:<br>
&gt; Based on this article and &quot;sharing<br>
&gt; buffers&quot;, <a href=3D"http://lwn.net/Articles/480055/" target=3D"_=
blank">http://lwn.net/Articles/480055/</a><br>
&gt;<br>
&gt;<br>
&gt; We may need to instrument LSM hooks for ION.<br>
&gt;<br>
&gt;<br>
&gt; Thoughts?<br>
<br>
</div>Possibly, but I don&#39;t see any DAC checks or capable calls in the =
current<br>
ion driver code. =A0If the only way to share is by passing open fds, then<b=
r>
we already control that via the existing SELinux hooks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>

--047d7b2ee6e756ffd904c9adc6f5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
