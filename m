Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8F0M0jj015868
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2012 20:22:00 -0400
Received: by vbbfc21 with SMTP id fc21so6072962vbb.12
        for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2012 17:21:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
References: <CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
Date: Fri, 14 Sep 2012 17:21:58 -0700
Message-ID: <CABoba9L=N7PGJZXFO75tR4enW7X4JmxVtc6JtzwrbzycjJRgJg@mail.gmail.com>
Subject: Re: clean up in android.c
From: Kenny Root <kroot@google.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7bdc992c56cdb404c9b2873a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7bdc992c56cdb404c9b2873a
Content-Type: text/plain; charset=UTF-8

It might just be better to provide the information directly. Right now
getpwnam's implementation is in bionic/libc/bionic/stubs.cpp, but perhaps
it's worth it to just include
system/core/include/private/android_filesystem_config.h when available.
Does this get compiled on non-Android platforms? I'd rather have it just
get what it needs directly instead of parsing a string.

On Fri, Sep 14, 2012 at 5:09 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> Would anyone object to me cleaning up the setcon and setfilecon2 code that
> does the mls level stuff:
>
> Currently the below code is duplicated:
>
> pw = getpwuid(uid);
>  if (!pw)
> goto err;
> username = pw->pw_name;
>
> if (!strncmp(username, "app_", 4)) {
> id = strtoul(username + 4, NULL, 10);
>  if (id >= MLS_CATS)
> goto err;
> } else if (username[0] == 'u' && isdigit(username[1])) {
>  unsigned long unused;
> unused = strtoul(username+1, &end, 10);
> if (end[0] != '_')
>  goto err;
> id = strtoul(end + 2, NULL, 10);
> if (id >= MLS_CATS/2)
>  goto err;
> if (end[1] == 'i')
> id += MLS_CATS/2;
>  else if (end[1] != 'a')
> goto err;
> /* use app_ for matching on the user= field */
>  username = "app_";
> }
>
> I want to break it up into two functions.
>
> 1. that gets the normalized username
> 2. that computes the id, takes username, returns -1 on error
>
>
> This way of the username stuff changes again in the future, we can
> normalize it one spot. The one that computes the id doesn't gain much by
> putting it in a function, but I think it will make the code more readable.
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 

Kenny Root

--047d7bdc992c56cdb404c9b2873a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

It might just be better to provide the information directly. Right now getp=
wnam&#39;s implementation is in bionic/libc/bionic/stubs.cpp, but perhaps i=
t&#39;s worth it to just include system/core/include/private/android_filesy=
stem_config.h when available. Does this get compiled on non-Android platfor=
ms? I&#39;d rather have it just get what it needs directly instead of parsi=
ng a string.<br>
<br><div class=3D"gmail_quote">On Fri, Sep 14, 2012 at 5:09 PM, William Rob=
erts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" targ=
et=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
Would anyone object to me cleaning up the setcon and setfilecon2 code that =
does the mls level stuff:<div><br></div><div>Currently the below code is du=
plicated:</div><div><br></div><div><div><span style=3D"white-space:pre-wrap=
">	</span>pw =3D getpwuid(uid);</div>

<div><span style=3D"white-space:pre-wrap">	</span>if (!pw)</div><div><span =
style=3D"white-space:pre-wrap">		</span>goto err;</div><div><span style=3D"=
white-space:pre-wrap">	</span>username =3D pw-&gt;pw_name;</div>
<div><br></div><div><span style=3D"white-space:pre-wrap">	</span>if (!strnc=
mp(username, &quot;app_&quot;, 4)) {</div><div><span style=3D"white-space:p=
re-wrap">		</span>id =3D strtoul(username + 4, NULL, 10);</div>
<div><span style=3D"white-space:pre-wrap">		</span>if (id &gt;=3D MLS_CATS)=
</div><div><span style=3D"white-space:pre-wrap">			</span>goto err;</div><d=
iv><span style=3D"white-space:pre-wrap">	</span>} else if (username[0] =3D=
=3D &#39;u&#39; &amp;&amp; isdigit(username[1])) {</div>

<div><span style=3D"white-space:pre-wrap">		</span>unsigned long unused;</d=
iv><div><span style=3D"white-space:pre-wrap">		</span>unused =3D strtoul(us=
ername+1, &amp;end, 10);</div><div><span style=3D"white-space:pre-wrap">		<=
/span>if (end[0] !=3D &#39;_&#39;)</div>

<div><span style=3D"white-space:pre-wrap">			</span>goto err;</div><div><sp=
an style=3D"white-space:pre-wrap">		</span>id =3D strtoul(end + 2, NULL, 10=
);</div><div><span style=3D"white-space:pre-wrap">		</span>if (id &gt;=3D M=
LS_CATS/2)</div>

<div><span style=3D"white-space:pre-wrap">			</span>goto err;</div><div><sp=
an style=3D"white-space:pre-wrap">		</span>if (end[1] =3D=3D &#39;i&#39;)</=
div><div><span style=3D"white-space:pre-wrap">			</span>id +=3D MLS_CATS/2;=
</div>
<div><span style=3D"white-space:pre-wrap">		</span>else if (end[1] !=3D &#3=
9;a&#39;)</div><div><span style=3D"white-space:pre-wrap">			</span>goto err=
;</div><div><span style=3D"white-space:pre-wrap">		</span>/* use app_ for m=
atching on the user=3D field */</div>

<div><span style=3D"white-space:pre-wrap">		</span>username =3D &quot;app_&=
quot;;</div><div><span style=3D"white-space:pre-wrap">	</span>}</div></div>=
<div><br></div><div>I want to break it up into two functions.</div>
<div><br></div><div>1. that gets the normalized username</div><div>2. that =
computes the id, takes username, returns -1 on error</div><div><br></div><d=
iv><div><br></div><div>This way of the username stuff changes again in the =
future, we can normalize it one spot. The one that computes the id doesn&#3=
9;t gain much by putting it in a function, but I think it will make the cod=
e more readable.</div>
<span class=3D"HOEnZb"><font color=3D"#888888">
<div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><br>Kenny Ro=
ot<br>

--047d7bdc992c56cdb404c9b2873a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
