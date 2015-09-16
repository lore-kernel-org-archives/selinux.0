MIME-Version: 1.0
References: <CABXk95A9ge6asZf0oFemLLxLG3Y5VxfYQkpchgM0Ae1f1tRN+g@mail.gmail.com>
 <55F9B780.7010105@tycho.nsa.gov>
In-Reply-To: <55F9B780.7010105@tycho.nsa.gov>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Wed, 16 Sep 2015 19:54:57 +0000
Message-ID: <CABXk95DyvjBTHA42pBWVsipsNTwHw5zE2KqSLutcTN2sVqMKVg@mail.gmail.com>
Subject: Re: ftruncate triggering open denial
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <Selinux@tycho.nsa.gov>,
 eparis@redhat.com
Content-Type: multipart/alternative; boundary=001a11c036a4e931ab051fe2ac82
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c036a4e931ab051fe2ac82
Content-Type: text/plain; charset=UTF-8

>
> If we don't allow isolated_app app_data_file:dir search;, then we don't
> actually need to restrict open; you can't use open (or truncate or link
> or chmod) on a file by pathname without search access to its parent.
>

Thanks Stephen. Proposed change in AOSP:
https://android-review.googlesource.com/#/c/171182/

--001a11c036a4e931ab051fe2ac82
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
If we don&#39;t allow isolated_app app_data_file:dir search;, then we don&#=
39;t<br>
actually need to restrict open; you can&#39;t use open (or truncate or link=
<br>
or chmod) on a file by pathname without search access to its parent.<br></b=
lockquote><div><br></div></div><div dir=3D"ltr"><div class=3D"gmail_quote">=
<div>Thanks Stephen. Proposed change in AOSP:=C2=A0<a href=3D"https://andro=
id-review.googlesource.com/#/c/171182/">https://android-review.googlesource=
.com/#/c/171182/</a></div><div><br></div></div></div></div>

--001a11c036a4e931ab051fe2ac82--
