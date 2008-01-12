Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0C19Lbv028537
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2008 20:09:21 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0C19KEi016074
	for <selinux@tycho.nsa.gov>; Sat, 12 Jan 2008 01:09:20 GMT
Cc: selinux@tycho.nsa.gov
Message-Id: <196211F4-D91D-474C-A632-70BEDDD4DA34@nall.com>
From: Joe Nall <joe@nall.com>
To: "Justin Mattock" <justinmattock@gmail.com>
In-Reply-To: <dd18b0c30801111529w78b3e558wdd3a0f788ff2380d@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: newrole -l s3
Date: Fri, 11 Jan 2008 19:09:04 -0600
References: <dd18b0c30801111529w78b3e558wdd3a0f788ff2380d@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jan 11, 2008, at 5:29 PM, Justin Mattock wrote:

> Hello does anybody know a solution to this problem: with issueing  
> newrole -l s3 I receive a Error: you are not allowed to change  
> levels on a non secure terminal.
> I've tried changing the runlevel and still same error, any help  
> would be appreciated,
> regards;

ls -Z `tty`

add the resulting type (user_devpts_t ...) to

/etc/selinux/mls/contexts/securetty_types

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
