Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n637BYV9014055
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 03:11:34 -0400
Received: from wa-out-1112.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n637CBwO026908
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 07:12:11 GMT
Received: by wa-out-1112.google.com with SMTP id k17so433833waf.18
        for <selinux@tycho.nsa.gov>; Fri, 03 Jul 2009 00:11:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7b740b700906272212hfc68318p3904174ed4d43ecb@mail.gmail.com>
References: <7b740b700906272212hfc68318p3904174ed4d43ecb@mail.gmail.com>
Date: Fri, 3 Jul 2009 13:11:32 +0600
Message-ID: <7b740b700907030011s762ef2ebwd901759e641187f9@mail.gmail.com>
Subject: Re: Building for Ubuntu 9.04 - too few arguments to
	heap_create_with_catalog error
From: Shaz <shazalive@gmail.com>
To: sepgsql@secureos.jp
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0016e64ca7d6b9e753046dc7ddfb
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e64ca7d6b9e753046dc7ddfb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2009 at 11:12 AM, Shaz <shazalive@gmail.com> wrote:

> Dear list,
>
> I am building sepgsql for Ubuntu 9.04. I am following steps provided in
> http://wiki.postgresql.org/wiki/SEPostgreSQL_Administration#Installation_=
from_source_tarball
>
> I encountered the following error:
>
> ----------
> gcc -O2 -Wall -Wmissing-prototypes -Wpointer-arith
> -Wdeclaration-after-statement -Wendif-labels -fno-strict-aliasing -fwrapv
> -I. -I../../../src/include -D_GNU_SOURCE   -c -o bootparse.o bootparse.c
> bootparse.y: In function =91boot_yyparse=92:
> bootparse.y:228: error: too few arguments to function
> =91heap_create_with_catalog=92
> make[3]: *** [bootparse.o] Error 1
> ---------
>
> Help requested in this matter.


I got it working with Fedora 11 (yum) but would love to make it work on
Ubuntu with source tarballs. Is the sepgsql@secureos.jp active?


>
>
> Thank you.
>
>
> --
> Shaz
>
>


--=20
Shaz

--0016e64ca7d6b9e753046dc7ddfb
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sun, Jun 28, 2009 at 11:12 AM, Shaz <=
span dir=3D"ltr">&lt;<a href=3D"mailto:shazalive@gmail.com">shazalive@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
Dear list,<br>
<br>
I am building sepgsql for Ubuntu 9.04. I am following steps provided in <a =
href=3D"http://wiki.postgresql.org/wiki/SEPostgreSQL_Administration#Install=
ation_from_source_tarball" target=3D"_blank">http://wiki.postgresql.org/wik=
i/SEPostgreSQL_Administration#Installation_from_source_tarball</a><br>


<br>
I encountered the following error:<br>
<br>
----------<br>
gcc -O2 -Wall -Wmissing-prototypes -Wpointer-arith
-Wdeclaration-after-statement -Wendif-labels -fno-strict-aliasing
-fwrapv -I. -I../../../src/include -D_GNU_SOURCE=A0=A0 -c -o bootparse.o
bootparse.c<br>
bootparse.y: In function =91boot_yyparse=92:<br>
bootparse.y:228: error: too few arguments to function =91heap_create_with_c=
atalog=92<br>
make[3]: *** [bootparse.o] Error 1<br>
---------<br clear=3D"all"><br>Help requested in this matter.</blockquote><=
div><br>I got it working with Fedora 11 (yum) but would love to make it wor=
k on Ubuntu with source tarballs. Is the <a href=3D"mailto:sepgsql@secureos=
.jp">sepgsql@secureos.jp</a> active?<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br><br>=
Thank you.<br><br><br>-- <br><font color=3D"#888888">Shaz<br><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Shaz<br><br>

--0016e64ca7d6b9e753046dc7ddfb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
