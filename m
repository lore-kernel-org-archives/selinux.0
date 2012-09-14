MIME-Version: 1.0
In-Reply-To: <CAFftDdrP0C9SAd_mGgFbBO3KnOsjTNLsZw3Tdx6XWe_hndShPA@mail.gmail.com>
References: <CAFftDdpCZGKGMGK9-G69SL1apEBWgfE57FpcMf0AS7tsGJCOeg@mail.gmail.com>
	<1347647563.11029.80.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdrP0C9SAd_mGgFbBO3KnOsjTNLsZw3Tdx6XWe_hndShPA@mail.gmail.com>
Date: Fri, 14 Sep 2012 11:48:56 -0700
Message-ID: <CAFftDdqn26hRz5uau3nnWzSK9ceK954yDtcJQ1FqEGB4gRoP2g@mail.gmail.com>
Subject: Re: dev ion
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf307c9fd84df2bf04c9ade0f2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf307c9fd84df2bf04c9ade0f2
Content-Type: text/plain; charset=ISO-8859-1

Nevermind, the sharing happens in the kernel not userspace.

On Fri, Sep 14, 2012 at 11:41 AM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> I didn't either, but that article used a four letter word "sharing" and I
> thought I was missing something, (Which is usually the case ;-) )
>
>
> On Fri, Sep 14, 2012 at 11:32 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On Fri, 2012-09-14 at 11:24 -0700, William Roberts wrote:
>> > Based on this article and "sharing
>> > buffers", http://lwn.net/Articles/480055/
>> >
>> >
>> > We may need to instrument LSM hooks for ION.
>> >
>> >
>> > Thoughts?
>>
>> Possibly, but I don't see any DAC checks or capable calls in the current
>> ion driver code.  If the only way to share is by passing open fds, then
>> we already control that via the existing SELinux hooks.
>>
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 
Respectfully,

William C Roberts

--20cf307c9fd84df2bf04c9ade0f2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nevermind, the sharing happens in the kernel not userspace.<br><br><div cla=
ss=3D"gmail_quote">On Fri, Sep 14, 2012 at 11:41 AM, William Roberts <span =
dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blan=
k">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I didn&#39;t either, but that article used a=
 four letter word &quot;sharing&quot; and I thought I was missing something=
, (Which is usually the case ;-) )<div class=3D"HOEnZb">
<div class=3D"h5"><br><br><div class=3D"gmail_quote">On Fri, Sep 14, 2012 a=
t 11:32 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tyc=
ho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Fri, 2012-09-14 at 11:24 -0700, Will=
iam Roberts wrote:<br>
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
<span><font color=3D"#888888"><br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div></div=
></div><div class=3D"HOEnZb"><div class=3D"h5">-- <br>Respectfully,<br><br>=
William C Roberts<br><br><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>

--20cf307c9fd84df2bf04c9ade0f2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
