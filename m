Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB34uNKU012207
	for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2009 23:56:23 -0500
Received: from mail-ew0-f209.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nB34waxi026501
	for <selinux@tycho.nsa.gov>; Thu, 3 Dec 2009 04:58:37 GMT
Received: by ewy1 with SMTP id 1so561092ewy.34
        for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2009 20:56:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090822093304.GA2530@notebook3.grift.internal>
References: <20090822093304.GA2530@notebook3.grift.internal>
Date: Wed, 2 Dec 2009 23:56:20 -0500
Message-ID: <a0e63a5b0912022056s550e6f74we2662b9e9283d7a6@mail.gmail.com>
Subject: Re: SELinux: Invalid object class mapping, disabling SELinux support.
	(XACE)
From: Tyler Durvik <phangbyte@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am getting the same error in my Xorg log file.



On Sat, Aug 22, 2009 at 4:33 AM, Dominick Grift <domg472@gmail.com> wrote:
> I just want to report that it seems SELinux support gets disabled with the Intel Xorg driver (in rawhide)
>
> [root@notebook3 ~]# grep -i selinux /var/log/Xorg.0.log
> (II) Loading extension SELinux
> SELinux: Invalid object class mapping, disabling SELinux support.
>
> (**) |-->Screen "Builtin Default intel Screen 0" (0)
> (**) |   |-->Device "Builtin Default intel Device 0"
> (==) No monitor specified for screen "Builtin Default intel Screen 0".
> (II) LoadModule: "intel"
> (II) Loading /usr/lib64/xorg/modules/drivers/intel_drv.so
> (II) Module intel: vendor="X.Org Foundation"
> (II) intel: Driver for Intel Integrated Graphics Chipsets: i810,
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
