Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9AHVPE7024787
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2013 13:31:25 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so2924166wes.20
        for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2013 10:31:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
References: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
Date: Thu, 10 Oct 2013 13:31:20 -0400
Message-ID: <CAFftDdoR+9KXqZzVSYbXHUTYTb=YBomgUQQpYwo87tjfR3O3cg@mail.gmail.com>
Subject: Re: MLS over loopback interface
From: William Roberts <bill.c.roberts@gmail.com>
To: "Langland, Blake" <blangland@integrity-apps.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec53d5b4bb8def304e8665e73
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec53d5b4bb8def304e8665e73
Content-Type: text/plain; charset=ISO-8859-1

set it as:  s2,s3 (if you can even do that not sure if it works like cats)


On Thu, Oct 10, 2013 at 1:12 PM, Langland, Blake <
blangland@integrity-apps.com> wrote:

>  All,****
>
> ** **
>
> I have two web servers running on an SELinux machine, one running at s2
> and one at s3. Both webservers have two webapps each that are attempting to
> communicate over the loopback interface. The communication is strictly s2
> <-> s2 and s3 <-> s3. The problem I am having is setting the MLS level of
> the loopback interface. If I have it set below s3, the s3 webapps cannot
> send over the interface; If I have it set higher than s2, the s2 webapps
> cannot receive over the interface. Any suggestions?****
>
> ** **
>
> Thanks,****
>
> Blake****
>
> ** **
>



-- 
Respectfully,

William C Roberts

--bcaec53d5b4bb8def304e8665e73
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">set it as:=A0 s2,s3 (if you can even do that not sure if i=
t works like cats)<br></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Thu, Oct 10, 2013 at 1:12 PM, Langland, Blake <span dir=
=3D"ltr">&lt;<a href=3D"mailto:blangland@integrity-apps.com" target=3D"_bla=
nk">blangland@integrity-apps.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div link=3D"blue" vlink=3D"purple" lang=3D"EN-US">
<div>
<p class=3D"MsoNormal">All,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
<p class=3D"MsoNormal">I have two web servers running on an SELinux machine=
, one running at s2 and one at s3. Both webservers have two webapps each th=
at are attempting to communicate over the loopback interface. The communica=
tion is strictly s2 &lt;-&gt; s2 and s3
 &lt;-&gt; s3. The problem I am having is setting the MLS level of the loop=
back interface. If I have it set below s3, the s3 webapps cannot send over =
the interface; If I have it set higher than s2, the s2 webapps cannot recei=
ve over the interface. Any suggestions?<u></u><u></u></p>

<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
<p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
<p class=3D"MsoNormal">Blake<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><br>-- <br>Respectfully,<br><br>Wi=
lliam C Roberts<br><br>
</div>

--bcaec53d5b4bb8def304e8665e73--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
