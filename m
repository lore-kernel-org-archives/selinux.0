Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBT1h4te014978
	for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2008 20:43:04 -0500
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBT1h3Us023048
	for <selinux@tycho.nsa.gov>; Mon, 29 Dec 2008 01:43:04 GMT
Received: by yx-out-1718.google.com with SMTP id 3so1476948yxi.84
        for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2008 17:42:59 -0800 (PST)
Message-ID: <707f057d0812281742p4591e918m6ca85399a43fc640@mail.gmail.com>
Date: Mon, 29 Dec 2008 09:42:59 +0800
From: "xing li" <lixing.1006@gmail.com>
To: "Dave Feustel" <dfeustel@mindspring.com>, selinux@tycho.nsa.gov
Subject: Re: Protect Firefox Keyboard Mappings and Font Settings
In-Reply-To: <200812272344.mBRNisPR009487@mummy.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24945_23088917.1230514979705"
References: <200812272344.mBRNisPR009487@mummy.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_24945_23088917.1230514979705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think you can define some rules to protect the font configure files.
such as define the file as firefox_configure_t,and define or restrict
special
domain to manipulate it.

2008/12/28 Dave Feustel <dfeustel@mindspring.com>

> I'm running 32-bit x86 Fedora 9 and the Firefox font settings are being
> altered somehow so that some lower case letters are being mapped to
> upper case and vice versa. Also, the arrow keys are being deactivated.
> Is there any way to protect the font settings and also the keyboard
> mappings to prevent them from being changed?
>
> Thanks.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

------=_Part_24945_23088917.1230514979705
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><br>I think you can define some rules to protect the font configure files.</div>
<div>such as&nbsp;define the file as firefox_configure_t,and define&nbsp;or&nbsp;restrict special</div>
<div>domain to manipulate it.<br>&nbsp;</div>
<div class="gmail_quote">2008/12/28 Dave Feustel <span dir="ltr">&lt;<a href="mailto:dfeustel@mindspring.com">dfeustel@mindspring.com</a>&gt;</span><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I&#39;m running 32-bit x86 Fedora 9 and the Firefox font settings are being<br>altered somehow so that some lower case letters are being mapped to<br>
upper case and vice versa. Also, the arrow keys are being deactivated.<br>Is there any way to protect the font settings and also the keyboard<br>mappings to prevent them from being changed?<br><br>Thanks.<br><font color="#888888"><br>
--<br>This message was distributed to subscribers of the selinux mailing list.<br>If you no longer wish to subscribe, send mail to <a href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>the words &quot;unsubscribe selinux&quot; without quotes as the message.<br>
</font></blockquote></div><br>

------=_Part_24945_23088917.1230514979705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
