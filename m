Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4CM29AK026371
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 18:02:09 -0400
Received: by mail-oi0-f50.google.com with SMTP id b204so81037981oii.1
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 15:02:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=kc+bS6b6Owk-d8aiFp8sWXs1MOZ+=V9mBmgcU3QVX=iw@mail.gmail.com>
References: <CAJfZ7=kc+bS6b6Owk-d8aiFp8sWXs1MOZ+=V9mBmgcU3QVX=iw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 12 May 2017 15:02:07 -0700
Message-ID: <CAFftDdpBL2pV5RBbm-upuNZt8mU3d1dbPBE_H2au1MP7euxPgA@mail.gmail.com>
Subject: Re: Possible use after free in selabel_subs_init
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11c15cfa3f5e43054f5adbb8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c15cfa3f5e43054f5adbb8
Content-Type: text/plain; charset="UTF-8"

On Fri, May 12, 2017 at 1:26 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
wrote:

> Hi,
>
> Currently libselinux/src/label.c defines selabel_subs_init() like this [1]:
>
>     struct selabel_sub *selabel_subs_init(/* ... */)
>     {
>         /* ... */
>         while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
>             /* ... allocate and fill "sub" ... */
>             sub->next = list;
>             list = sub;
>         }
>
>         if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
>             goto err;
>
>     out:
>         fclose(cfg);
>         return list;
>     err:
>         if (sub)
>             free(sub->src);
>         free(sub);
>         goto out;
>     }
>
> When digest_add_specfile() fails, sub is freed (in the err label), but
> as list=sub, it means that the return value, list, is freed. This
> leads to a use-after-free when this value is used.
>
> What should selabel_subs_init() do (and return) when
> digest_add_specfile() fails?
>
> Nicolas
>
> [1] https://github.com/SELinuxProject/selinux/blob/
> 9cc62ce35d099acf7897b6259228479737521709/libselinux/src/label.c#L94
>
>
>From what I can tell, and I may be wrong, is that the only callers are from
init() in label_file.c. So the first two failure returns where it returns
list,
list i think would be NULL there. Which makes sense since the first
iteration, the linked list next pointer would be NULL. I think we would
want to free
the whole list and return NULL and have callers check for NULL. This seems
like a fatal error path. But I am wrong frequently :-)

--001a11c15cfa3f5e43054f5adbb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, May 12, 2017 at 1:26 PM, Nicolas Iooss <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:nicolas.iooss@m4x.org" target=3D"_blank">nicolas.iooss@m4x.=
org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
Currently libselinux/src/label.c defines selabel_subs_init() like this [1]:=
<br>
<br>
=C2=A0 =C2=A0 struct selabel_sub *selabel_subs_init(/* ... */)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ... */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (fgets_unlocked(buf, sizeof(buf) - 1, cfg=
)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ... allocate and fill &quot;su=
b&quot; ... */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sub-&gt;next =3D list;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D sub;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (digest_add_specfile(digest, cfg, NULL, sb.s=
t_size, path) &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
<br>
=C2=A0 =C2=A0 out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(cfg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return list;<br>
=C2=A0 =C2=A0 err:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sub)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(sub-&gt;src);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(sub);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
=C2=A0 =C2=A0 }<br>
<br>
When digest_add_specfile() fails, sub is freed (in the err label), but<br>
as list=3Dsub, it means that the return value, list, is freed. This<br>
leads to a use-after-free when this value is used.<br>
<br>
What should selabel_subs_init() do (and return) when<br>
digest_add_specfile() fails?<br>
<br>
Nicolas<br>
<br>
[1] <a href=3D"https://github.com/SELinuxProject/selinux/blob/9cc62ce35d099=
acf7897b6259228479737521709/libselinux/src/label.c#L94" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/<wbr>SELinuxProject/selinux/blob/<wbr>=
9cc62ce35d099acf7897b625922847<wbr>9737521709/libselinux/src/<wbr>label.c#L=
94</a><br>
<br>
</blockquote></div><br>From what I can tell, and I may be wrong, is that th=
e only callers are from init() in label_file.c. So the first two failure re=
turns where it returns list,</div><div class=3D"gmail_extra">list i think w=
ould be NULL there. Which makes sense since the first iteration, the linked=
 list next pointer would be NULL. I think we would want to free</div><div c=
lass=3D"gmail_extra">the whole list and return NULL and have callers check =
for NULL. This seems like a fatal error path. But I am wrong frequently :-)=
<br clear=3D"all"><div><br></div>
</div></div>

--001a11c15cfa3f5e43054f5adbb8--
