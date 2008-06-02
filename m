Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m52CCReG017945
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 08:12:27 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m52CCQwL004932
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 12:12:26 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: changing role to user_r
Date: Mon, 2 Jun 2008 08:09:46 -0400
Message-ID: <1212408586.31546.69.camel@gorn>
In-Reply-To: <dd18b0c30805302311n7daac8e9ob6d818860e545b08@mail.gmail.com>
References: <dd18b0c30805302311n7daac8e9ob6d818860e545b08@mail.gmail.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Justin Mattock" <justinmattock@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-05-31 at 06:11 +0000, Justin Mattock wrote:
> Hello, I'm running an experiment with SELinux and seem to be at a crux
> with changing roles:
> newrole -r user_r
> I get a permission denied, the allow rule is this: allow newrole_t
> user_t:process transition;
> I don't have a problem changing to sysadm_r any thoughts on what I'm missing?

Sounds like your user is staff_u or root.  Neither users are allowed
user_r.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
