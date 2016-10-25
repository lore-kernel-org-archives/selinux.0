Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9PGQKO9011984
 for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2016 12:26:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id c78so26935859wme.0
 for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2016 09:26:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrPRK==xJaXoLq10nLS2k9wxe3WmqSjHFJAGu0+mYvL0A@mail.gmail.com>
References: <CAFftDdrPRK==xJaXoLq10nLS2k9wxe3WmqSjHFJAGu0+mYvL0A@mail.gmail.com>
From: Nick Kralevich <nnk@google.com>
Date: Tue, 25 Oct 2016 09:26:16 -0700
Message-ID: <CAFJ0LnFJGcy1o2AZ6rDoeEojH8GqaErJt3ScFQE7dkXzmax=Mg@mail.gmail.com>
Subject: Re: Android Fork Dies on AOSP
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Jeff Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=047d7bae4242c9755d053fb2f725
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bae4242c9755d053fb2f725
Content-Type: text/plain; charset=UTF-8

yes, thank you!

-- Nick

On Tue, Oct 25, 2016 at 9:12 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> In this commit, external/libselinux goes away:
> https://android-review.googlesource.com/#/c/293506
>
> Now, AOSP is using upstream selinux in external/selinux plus the following:
> src/android
> include/selinux/android.h
>
> More details can be found here:
> https://android.googlesource.com/platform/external/selinux/
> +/master/README.android
>
> This essentially closes a lot of the headaches updating libselinux on
> Android, but granted, the title of this email is a misnomer, a
> technical fork still exists, but for libselinux, it is all self
> contained in stand alone files, and thus no merge headaches on
> updates.
>
> A big thanks goes to Jeff V for finalizing my work and getting it
> merged, thanks Jeff!
>
> --
> Respectfully,
>
> William C Roberts
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--047d7bae4242c9755d053fb2f725
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">yes, thank you!<div><br></div><div>-- Nick</div></div><div=
 class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Oct 25, 2016 =
at 9:12 AM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.=
roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">In this commit, external/libseli=
nux goes away:<br>
<a href=3D"https://android-review.googlesource.com/#/c/293506" rel=3D"noref=
errer" target=3D"_blank">https://android-review.<wbr>googlesource.com/#/c/2=
93506</a><br>
<br>
Now, AOSP is using upstream selinux in external/selinux plus the following:=
<br>
src/android<br>
include/selinux/android.h<br>
<br>
More details can be found here:<br>
<a href=3D"https://android.googlesource.com/platform/external/selinux/+/mas=
ter/README.android" rel=3D"noreferrer" target=3D"_blank">https://android.go=
oglesource.<wbr>com/platform/external/selinux/<wbr>+/master/README.android<=
/a><br>
<br>
This essentially closes a lot of the headaches updating libselinux on<br>
Android, but granted, the title of this email is a misnomer, a<br>
technical fork still exists, but for libselinux, it is all self<br>
contained in stand alone files, and thus no merge headaches on<br>
updates.<br>
<br>
A big thanks goes to Jeff V for finalizing my work and getting it<br>
merged, thanks Jeff!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
______________________________<wbr>_________________<br>
Seandroid-list mailing list<br>
<a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@tycho.nsa.go=
v</a><br>
To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@tycho.=
nsa.gov">Seandroid-list-leave@tycho.<wbr>nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Seandroid-list-request@tycho.nsa.gov">Seandroid-list-request@tycho.<wbr>ns=
a.gov</a>.<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div>Ni=
ck Kralevich | Android Security | <a href=3D"mailto:nnk@google.com" target=
=3D"_blank">nnk@google.com</a> | 650.214.4037</div></div>
</div>

--047d7bae4242c9755d053fb2f725--
