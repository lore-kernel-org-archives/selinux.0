Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v341spX4003266
 for <selinux@tycho.nsa.gov>; Mon, 3 Apr 2017 21:54:51 -0400
Received: by mail-oi0-f43.google.com with SMTP id r203so147466085oib.3
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 18:54:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 3 Apr 2017 18:54:48 -0700
Message-ID: <CAFftDdrVEKxgp69KrUrfyzD8hPuYOBtKgGhb_JWKCKrmd2PqhQ@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: Rahmadi Trimananda <rtrimana@uci.edu>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f40304354d8490bc3b054c4d8fb3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f40304354d8490bc3b054c4d8fb3
Content-Type: text/plain; charset=UTF-8

Do you see any "avc: denied" messages in dmesg/syslog? If so send them.

On Apr 3, 2017 16:28, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:

> Hi All,
>
> I am trying to run javac and java on my Raspbian while SELinux is enabled.
> However, I keep getting "Segmentation fault", even when I just run "javac"
> or "java". This happens in enforcing mode, but it doesn't happen with
> "gcc". I am wondering why, because both are in /usr/bin directory and both
> binaries have the same context.
>
> Can somebody please help?
>
> Thank you so much!
>
> Regards,
> Rahmadi
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--f40304354d8490bc3b054c4d8fb3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Do you see any &quot;avc: denied&quot; messages in dmesg/=
syslog? If so send them.</div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Apr 3, 2017 16:28, &quot;Rahmadi Trimananda&quot; &lt;<a hr=
ef=3D"mailto:rtrimana@uci.edu">rtrimana@uci.edu</a>&gt; wrote:<br type=3D"a=
ttribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi All,<div><br=
></div><div>I am trying to run javac and java on my Raspbian while SELinux =
is enabled. However, I keep getting &quot;Segmentation fault&quot;, even wh=
en I just run &quot;javac&quot; or &quot;java&quot;. This happens in enforc=
ing mode, but it doesn&#39;t happen with &quot;gcc&quot;. I am wondering wh=
y, because both are in /usr/bin directory and both binaries have the same c=
ontext.</div><div><br></div><div>Can somebody please help?</div><div><br></=
div><div>Thank you so much!</div><div><br></div><div>Regards,</div><div>Rah=
madi</div><div class=3D"gmail_extra"><br>
</div></div>
<br>______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div></div>

--f40304354d8490bc3b054c4d8fb3--
