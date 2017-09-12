Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CNTN7A022431
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 19:29:23 -0400
Received: by mail-it0-f51.google.com with SMTP id g142so1626924ita.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 15:09:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DdP-PNB9pC7Cf-X36w=6-GchpVx8QumRrzznBA6ZqTGew@mail.gmail.com>
References: <20170911104141.2629-1-cgzones@googlemail.com>
 <CAB9W1A1s20MMUyA5cgJteNA+r4V1Wo1VvWvaDj5M-ZSyR=o-8Q@mail.gmail.com>
 <CAJ2a_DdP-PNB9pC7Cf-X36w=6-GchpVx8QumRrzznBA6ZqTGew@mail.gmail.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Tue, 12 Sep 2017 18:09:33 -0400
Message-ID: <CAB9W1A0vDX+FMxi6Qs5q5=xv2zce8rYNP56zyfYyBwGOjWi30Q@mail.gmail.com>
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a114195e25f78060559054c22"
Subject: Re: [PATCH] libselinux: log no default label warning in verbose mode
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114195e25f78060559054c22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sep 12, 2017 12:49 PM, "Christian G=C3=B6ttsche" <cgzones@googlemail.com=
>
wrote:

> This seems to revert what was an intentional change to avoid noise in
> fixfiles check output. See the mailing list discussions that preceded and
> followed the patch.


In my opinion, it's a helpful noise, which is triggered by an intended
file context `<<none>>`.
Is there any hack to get the old behavior back other than `find /run
-exec restorecon -n {} \;`?


Why is that helpful/useful? It seems counterintuitive to warn the user that
you didn't label a file that was explicitly configured to not be labeled.
The only case where it makes sense is if the user explicitly requested to
label that particular file.

--001a114195e25f78060559054c22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On Sep 12, 2017 12:49 PM, &quot;Christian G=C3=B6ttsche&quot; &lt;<a href=
=3D"mailto:cgzones@googlemail.com">cgzones@googlemail.com</a>&gt; wrote:<br=
 type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">&=
gt; This seems to revert what was an intentional change to avoid noise in<b=
r>
&gt; fixfiles check output. See the mailing list discussions that preceded =
and<br>
&gt; followed the patch.<br>
<br>
<br>
</div>In my opinion, it&#39;s a helpful noise, which is triggered by an int=
ended<br>
file context `&lt;&lt;none&gt;&gt;`.<br>
Is there any hack to get the old behavior back other than `find /run<br>
-exec restorecon -n {} \;`?<br>
</blockquote></div><br></div></div><div class=3D"gmail_extra" dir=3D"auto">=
Why is that helpful/useful? It seems counterintuitive to warn the user that=
 you didn&#39;t label a file that was explicitly configured to not be label=
ed. The only case where it makes sense is if the user explicitly requested =
to label that particular file.=C2=A0</div></div>

--001a114195e25f78060559054c22--
