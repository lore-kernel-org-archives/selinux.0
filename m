Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2H4Mq3p016447
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 00:22:52 -0400
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2H4NPH9016948
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 04:23:25 GMT
Received: by qw-out-1920.google.com with SMTP id 5so146369qwc.30
        for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2010 21:22:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>
References: <482a0d8c1003100413w4b2d060fy493a72f6a76b976e@mail.gmail.com>
	 <1268235831.3678.31.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003100914j2709ab7epad0956ca4aa75081@mail.gmail.com>
	 <1268243344.3678.38.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>
Date: Wed, 17 Mar 2010 09:52:50 +0530
Message-ID: <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>
Subject: Re: working linux and busybox versions
From: Manvendra Pratap Singh <manav.emb@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016364ee308a4baf50481f77777
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364ee308a4baf50481f77777
Content-Type: text/plain; charset=ISO-8859-1

Can anyone suggest me good guide for SELinux on omap3 (beagleboard). I tried
it myself but I am not able to login after booting. On loging in root I get
a msg "Cann't get SID for root". Please help me on this issue.  Here take a
look at boot-log.


[    0.000000] Security Framework initialized
[    0.000000] SELinux:  Initializing.


beagleboard login: root
login: can't get SID for root

Embinux Linux 1.1 beagleboard ttyS2

beagleboard login:



---
Manav
Hyderabad



On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap Singh <manav.emb@gmail.com
> wrote:

> Thanks for the information. I asked about working busybox and linux kernel
> versions because when I am enabling selinux in busybox (1.13.0), it is
> giving me lot of compilation errors and I think some code is also missing.
> Although the kernel (2.6.29) which I am using is working fine. If you tell
> anything more on this then it will be a great help.
>
>
> --
> Manav
> Hyderabad
>
>
>
> On Wed, Mar 10, 2010 at 11:19 PM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On Wed, 2010-03-10 at 22:44 +0530, Manvendra Pratap Singh wrote:
>> > Hi Stephen,
>> >
>> > May be I could not make myself clear to you. My question was not about
>> > linux on omap3, it was about SELinux on omap3. Anyways thanks for your
>> > reply. I will check the links given by you.
>>
>> SELinux isn't platform-specific, and is a component of the Linux 2.6
>> kernel.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>

--0016364ee308a4baf50481f77777
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Can anyone  suggest me good guide for SELinux on omap3 (beagleboard). I tri=
ed it myself but I am not able to login after booting. On loging in root I =
get a msg &quot;Cann&#39;t get SID for root&quot;. Please help me on this i=
ssue.=A0 Here take a look at boot-log.<br>

<br><br>[=A0=A0=A0 0.000000] Security Framework initialized<br>[=A0=A0=A0 0=
.000000] SELinux:=A0 Initializing.<br><br><br>beagleboard login: root<br>lo=
gin: can&#39;t get SID for root<br><br>Embinux Linux 1.1 beagleboard ttyS2<=
br><br>beagleboard login: <br>

<br><br><br>---<br>Manav<br>Hyderabad<br><br><br><br><div class=3D"gmail_qu=
ote">On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap Singh <span dir=3D"l=
tr">&lt;<a href=3D"mailto:manav.emb@gmail.com" target=3D"_blank">manav.emb@=
gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Thanks for the in=
formation. I asked about working busybox and linux kernel versions because =
when I am enabling selinux in busybox (1.13.0), it is giving me lot of comp=
ilation errors and I think some code is also missing. Although the kernel (=
2.6.29) which I am using is working fine. If you tell anything more on this=
 then it will be a great help.<br>

<font color=3D"#888888">
<br clear=3D"all"><br>-- <br>Manav<br>Hyderabad</font><div><div></div><div>=
<br><br><br><div class=3D"gmail_quote">On Wed, Mar 10, 2010 at 11:19 PM, St=
ephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" ta=
rget=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>On Wed, 2010=
-03-10 at 22:44 +0530, Manvendra Pratap Singh wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
&gt; May be I could not make myself clear to you. My question was not about=
<br>
&gt; linux on omap3, it was about SELinux on omap3. Anyways thanks for your=
<br>
&gt; reply. I will check the links given by you.<br>
<br>
</div>SELinux isn&#39;t platform-specific, and is a component of the Linux =
2.6<br>
kernel.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div>Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>
</div></div></blockquote></div><br>

--0016364ee308a4baf50481f77777--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
