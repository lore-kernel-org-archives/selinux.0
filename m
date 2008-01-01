Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m01Nd8Uq001256
	for <selinux@tycho.nsa.gov>; Tue, 1 Jan 2008 18:39:08 -0500
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m01Nd7cu003601
	for <selinux@tycho.nsa.gov>; Tue, 1 Jan 2008 23:39:07 GMT
Received: by fk-out-0910.google.com with SMTP id 18so9964224fkq.2
        for <selinux@tycho.nsa.gov>; Tue, 01 Jan 2008 15:39:06 -0800 (PST)
Message-ID: <84c69f3a0801011539p2cb1a13frd69baab2e7adc586@mail.gmail.com>
Date: Wed, 2 Jan 2008 05:09:06 +0530
From: "Leo Prasath" <leo.prasath@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Is SELinux support as a kernel module possible ??
In-Reply-To: <84c69f3a0801011535x94ead41wccb031783f490323@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_31144_11862867.1199230746304"
References: <84c69f3a0801011530g7b34fc19x2ff3d66989d028d1@mail.gmail.com>
	 <84c69f3a0801011535x94ead41wccb031783f490323@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_31144_11862867.1199230746304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Hi guys,
>
> I have a need to install SELinux on a sytem running with a kernel without
> SELinux built into it. However, I cannot reinstall a custom kernel with the
> SELinux built into it.
>
> So, I am looking at building a kernel module for SELinux and load it. I
> tried compiling the kernel with config option CONFIG_SECURITY_SELINUX=m and
> i got this error:
>
> .config:984:warning: symbol value 'm' invalid for SECURITY_SELINUX
>
> Is it possible to load SELinux as a kernel module ? Has anyone tried this
> ?
>
> Any help is appreciated
>
> Thanks,
> Leo
>

------=_Part_31144_11862867.1199230746304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div class="Wj3C7c"><div class="gmail_quote">Hi guys,<br><br>I have a need to install SELinux on a sytem running with a kernel without SELinux built into it. However, I cannot reinstall a custom kernel with the SELinux built into it.
<br><br>So, I am looking at building a kernel module for SELinux and load it. I tried compiling the kernel with config option CONFIG_SECURITY_SELINUX=m and i got this error:
<br><br>.config:984:warning: symbol value &#39;m&#39; invalid for SECURITY_SELINUX<br><br>Is it possible to load SELinux as a kernel module ? Has anyone tried this ?<br><br>Any help is appreciated<br><br>Thanks,<br><font color="#888888">

Leo</font></div>
</div></div></blockquote></div>

------=_Part_31144_11862867.1199230746304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
