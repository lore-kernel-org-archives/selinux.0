Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v299rKGT020552
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 04:53:21 -0500
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
 by mxout014.mail.hostpoint.ch with esmtp (Exim 4.88 (FreeBSD))
 (envelope-from <thomas@chaschperli.ch>) id 1cluky-000ARc-8y
 for selinux@tycho.nsa.gov; Thu, 09 Mar 2017 10:53:12 +0100
Received: from 89.227.197.178.dynamic.wless.zhbmb00p-cgnat.res.cust.swisscom.ch
 ([178.197.227.89] helo=[10.179.133.26])
 by asmtp013.mail.hostpoint.ch with esmtpa (Exim 4.88 (FreeBSD))
 (envelope-from <thomas@chaschperli.ch>) id 1cluky-000ENo-55
 for selinux@tycho.nsa.gov; Thu, 09 Mar 2017 10:53:12 +0100
Date: Thu, 09 Mar 2017 10:53:10 +0100
In-Reply-To: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
References: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----48TSHCUINASCZKXDKZYSAO3OV73YB2"
Subject: Re: Custom Process Label (SElinux)
To: selinux@tycho.nsa.gov
From: Thomas <thomas@chaschperli.ch>
Message-ID: <F63C6174-2450-4D8D-A049-37BF397A6AFE@chaschperli.ch>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

------48TSHCUINASCZKXDKZYSAO3OV73YB2
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Please provide your te and fc files of this policy=2E=20

- Thomas

Am 9=2E M=C3=A4rz 2017 10:42:26 MEZ schrieb Kashif ali <kashif=2Eali=2E949=
8@gmail=2Ecom>:
>Hi,
> i have created a module for my custom service with seplogen command it
>has generated the policy module for my custom service and context for
>its
>/usr/bin/mycustomeservicedaemon which is custom_service_exec_t when i
>run
>my service it doesn't get the label of  custom_service_t where as it
>has
>the label of init_t so thats mean that the proper domain transition is
>not
>available or there is something which is i'm missing=2E
>Kindly reply me as soon i'm stuck in it=2E
>
>Thanks
>Regards
>Kashif Ali

------48TSHCUINASCZKXDKZYSAO3OV73YB2
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Please provide your te and fc files of this policy=
=2E <br>
<br>
- Thomas<br><br><div class=3D"gmail_quote">Am 9=2E M=C3=A4rz 2017 10:42:26=
 MEZ schrieb Kashif ali &lt;kashif=2Eali=2E9498@gmail=2Ecom&gt;:<blockquote=
 class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1=
px solid rgb(204, 204, 204); padding-left: 1ex;">
<div dir=3D"ltr">Hi,&nbsp;<br />&nbsp; i have created a module for my cust=
om service with seplogen command it has generated the policy module for my =
custom service and context for its /usr/bin/mycustomeservicedaemon which is=
 custom_service_exec_t when i run my service it doesn't get the label of &n=
bsp;custom_service_t where as it has the label of init_t so thats mean that=
 the proper domain transition is not available or there is something which =
is i'm missing=2E<br />Kindly reply me as soon i'm stuck in it=2E<br /><br =
/>Thanks&nbsp;<br />Regards&nbsp;<br />Kashif Ali</div>
</blockquote></div></body></html>
------48TSHCUINASCZKXDKZYSAO3OV73YB2--
