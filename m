Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6U69BTb013921
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 02:09:11 -0400
Received: by obnw1 with SMTP id w1so23831005obn.3
 for <selinux@tycho.nsa.gov>; Wed, 29 Jul 2015 23:09:08 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <1438101513-37783-4-git-send-email-ykhodorkovskiy@tresys.com>
References: <1438101513-37783-1-git-send-email-ykhodorkovskiy@tresys.com>
 <1438101513-37783-4-git-send-email-ykhodorkovskiy@tresys.com>
Date: Thu, 30 Jul 2015 08:09:08 +0200
Message-ID: <CAPzO=Nw5wZP8NUeAEnkkyp0Kj8A8xx_jXFsNY=SrhF0TrtpQUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] policycoreutils/semodule: update semodule to allow
 extracting modules
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1134b45a93472e051c118a28
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1134b45a93472e051c118a28
Content-Type: text/plain; charset=UTF-8

On Jul 28, 2015 6:51 PM, "Yuli Khodorkovskiy" <ykhodorkovskiy@tresys.com>
wrote:
>
> Add --extract/-E, --cil/-c, and --hll/-H to extract modules. If -c/-H
> are not provided, the module will be output as HLL by default. Only
> --cil or --hll (which will use the lang_ext in the semodule store) are
valid
> options to use with -E. The module is written to the current working
directory
> as <module_name>.<lang_ext>.
>
> If a module exists as HLL and is exported as CIL, it will first compile
into
> CIL and cache to the module store. Once compiled, exporting will
> continue.
>

Do we need an interface (CLI) for this? What is wrong with capturing the
info from /var/lib/selinux?

I can't confirm from my phone, but I thought that semodule runs in its own
domain. Support for writing files would mean that the domain needs
additional writing privileges as well, possibly to a whole set of
directories as you work with the current working directory.

Wkr,
  Sven Vermeulen

--001a1134b45a93472e051c118a28
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jul 28, 2015 6:51 PM, &quot;Yuli Khodorkovskiy&quot; &lt;<a href=3D"mail=
to:ykhodorkovskiy@tresys.com">ykhodorkovskiy@tresys.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add --extract/-E, --cil/-c, and --hll/-H to extract modules. If -c/-H<=
br>
&gt; are not provided, the module will be output as HLL by default. Only<br=
>
&gt; --cil or --hll (which will use the lang_ext in the semodule store) are=
 valid<br>
&gt; options to use with -E. The module is written to the current working d=
irectory<br>
&gt; as &lt;module_name&gt;.&lt;lang_ext&gt;.<br>
&gt;<br>
&gt; If a module exists as HLL and is exported as CIL, it will first compil=
e into<br>
&gt; CIL and cache to the module store. Once compiled, exporting will<br>
&gt; continue.<br>
&gt;</p>
<p dir=3D"ltr">Do we need an interface (CLI) for this? What is wrong with c=
apturing the info from /var/lib/selinux? </p>
<p dir=3D"ltr">I can&#39;t confirm from my phone, but I thought that semodu=
le runs in its own domain. Support for writing files would mean that the do=
main needs additional writing privileges as well, possibly to a whole set o=
f directories as you work with the current working directory.</p>
<p dir=3D"ltr">Wkr,<br>
=C2=A0 Sven Vermeulen</p>

--001a1134b45a93472e051c118a28--
