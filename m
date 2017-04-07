MIME-Version: 1.0
In-Reply-To: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
References: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
From: Tom Jones <thomasclinganjones@gmail.com>
Date: Fri, 7 Apr 2017 11:02:41 -0700
Message-ID: <CAK2Cwb50YuP=3aMvYHWofF-=KEdKyPuiCzrp4Cb4sVbjcHuB+A@mail.gmail.com>
Subject: Re: add CONFIG_SECURITY_SELINUX_LOAD_ONCE
To: Nick Kralevich <nnk@google.com>
Cc: SELinux <Selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f403045fbbae930137054c976ea1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045fbbae930137054c976ea1
Content-Type: text/plain; charset=UTF-8

I like that, but I wonder at its scope. Would an update to the OS be
allowed to update the policy? For example, Microsoft ships updates to the
Windows O/S 2 times (at least) per month. Would that type of update to
Android allow policy updates?

Another question involves the list of authoritative CSPs. That can now be
updated in most O/S available on the market. Is that still allowed to be
updated, or is that already allowed by policy?
..tom

On Fri, Apr 7, 2017 at 10:34 AM, Nick Kralevich <nnk@google.com> wrote:

> I wanted to draw people's attention to the following proposed change:
>
>   https://android-review.googlesource.com/367695
>
> In the case of Android, it's common for security policy to be loaded once,
> and never reloaded again. In that case, the locking / unlocking surrounding
> the in-kernel policy is unnecessary and can be avoided. The patch above
> turns the locks into no-ops and ensures that the kernel cannot load a
> policy more than once. End result is that locking and preemption overhead
> is avoided and there's less attack surface / code compiled into the kernel.
>
> I would appreciate comments on the change. This feels like a worthwhile
> change for the entire SELinux community.
>
> -- Nick
>
> --
> Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
> <(650)%20214-4037>
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>



-- 
..tom

--f403045fbbae930137054c976ea1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I like that, but I wonder at its scope. Would an upda=
te to the OS be allowed to update the policy? For example, Microsoft ships =
updates to the Windows O/S 2 times (at least) per month. Would=C2=A0that ty=
pe of=C2=A0update to Android allow policy updates?</div><div><br></div><div=
>Another question involves the list of authoritative CSPs. That can now be =
updated in most O/S available on the market. Is that still allowed to be up=
dated, or is that already=C2=A0allowed by policy?</div><div>..tom</div></di=
v><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Apr 7, =
2017 at 10:34 AM, Nick Kralevich <span dir=3D"ltr">&lt;<a href=3D"mailto:nn=
k@google.com" target=3D"_blank">nnk@google.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>I wanted to draw people&#=
39;s attention to the following proposed change:</div><div><br></div><div>=
=C2=A0=C2=A0<a href=3D"https://android-review.googlesource.com/367695" targ=
et=3D"_blank">https://android-review.<wbr>googlesource.com/367695</a></div>=
<div><br></div><div>In the case of Android, it&#39;s common for security po=
licy to be loaded once, and never reloaded again. In that case, the locking=
 / unlocking surrounding the in-kernel policy is unnecessary and can be avo=
ided. The patch above turns the locks into no-ops and ensures that the kern=
el cannot load a policy more than once. End result is that locking and pree=
mption overhead is avoided and there&#39;s less attack surface / code compi=
led into the kernel.</div><div><br></div><div>I would appreciate comments o=
n the change. This feels like a worthwhile change for the entire SELinux co=
mmunity.</div><span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div=
><div>-- Nick</div><div><br></div>-- <br><div class=3D"m_-71240396825135634=
11gmail_signature"><div>Nick Kralevich | Android Security | <a href=3D"mail=
to:nnk@google.com" target=3D"_blank">nnk@google.com</a> | <a href=3D"tel:(6=
50)%20214-4037" target=3D"_blank" value=3D"+16502144037">650.214.4037</a></=
div></div>
</font></span></div>
<br>______________________________<wbr>_________________<br>
Seandroid-list mailing list<br>
<a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@tycho.nsa.go=
v</a><br>
To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@tycho.=
nsa.gov">Seandroid-list-leave@tycho.<wbr>nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Seandroid-list-request@tycho.nsa.gov">Seandroid-list-request@tycho.<wbr>ns=
a.gov</a>.<br></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">..tom</div>
</div>

--f403045fbbae930137054c976ea1--
