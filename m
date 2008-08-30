Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7U6lwW8016464
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2008 02:47:58 -0400
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7U6lQrB022102
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2008 06:47:26 GMT
Received: by wf-out-1314.google.com with SMTP id 28so1175943wff.30
        for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 23:47:57 -0700 (PDT)
Message-ID: <d74d42a50808292347s12562f01qf6da85f50b138b46@mail.gmail.com>
Date: Sat, 30 Aug 2008 12:17:57 +0530
From: "shaunak saha" <reach.shaunak@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: semodule -i error
Cc: selinux@tycho.nsa.gov, "Joshua Brindle" <jbrindle@tresys.com>
In-Reply-To: <1220021584.5708.307.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19531_17643029.1220078877548"
References: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
	 <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290648m6a5ff5fch67e9b374ed57ecd3@mail.gmail.com>
	 <1220018351.5708.297.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290714l53ed8c4et2f51ddde98681124@mail.gmail.com>
	 <1220019856.5708.304.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290743y15209c53jda0f3cf1b2805d23@mail.gmail.com>
	 <1220021584.5708.307.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_19531_17643029.1220078877548
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  >And did you then set SELINUXTYPE=refpolicy in /etc/selinux/config,
> >touch /.autorelabel and reboot the system to bring it up under your
> >newly built policy rather than the targeted one?
>

I did that.But with this my system is not booting up.I can send you
the bootup logs.
If i go back to the targeterd policy it comes up properly.

one more question i have.If instead of refpolicy i want to use targeted
policy only then from where can i  get the source packages for that.

------=_Part_19531_17643029.1220078877548
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><br>
<div class="gmail_quote">
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div class="Wj3C7c">&gt;And did you then set SELINUXTYPE=refpolicy in /etc/selinux/config,<br>&gt;touch /.autorelabel and reboot the system to bring it up under your<br>&gt;newly built policy rather than the targeted one?</div>
</div></blockquote>
<div>&nbsp;</div>
<div>I did that.But with this my system is not booting up.I can send you the&nbsp;bootup logs.&nbsp;</div>
<div>If i go back to the targeterd policy it comes up properly.</div>
<div>&nbsp;</div>
<div>one more question i have.If instead of refpolicy i want to use targeted policy only then from where can i&nbsp; get the source packages for that.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div></div><br></div>

------=_Part_19531_17643029.1220078877548--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
