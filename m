Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8U4Z6rT021197
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 00:35:06 -0400 (EDT)
Received: from mail.rollinghorse.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8U4Z4og008860
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 04:35:05 GMT
Message-Id: <5.2.1.1.2.20040929213557.06cc1010@Shire>
Date: Wed, 29 Sep 2004 21:39:14 -0700
To: Tom Anderson <granite217@yahoo.com>, selinux@tycho.nsa.gov
From: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
Subject: Re: purpose of the staff_r role?
In-Reply-To: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At 18:38 29-09-04, Tom Anderson wrote:
>Can anyone explain the purpose/benefit of having an account under the
>staff_r role?  I thought it was to allow limited administrative
>functions, but I've discovered that it doesn't even allow reading the
>logfiles under /var/log/.  What purpose does it serve, other than to
>limit who can transition to sysadm_r?
>
>SE Linux appears to be quite powerful, but dear $deity it's confusing.
>I'd sell my soul for a nice, readable O'Reilly Press title covering
>this stuff!

There is one in the works.  I saw a draft copy at LinuxWorld in San 
Francisco early August.  The title is "SELINUX: NSA's Open Source Security 
Enhanced Linux" and the author is Bill McCarty.

Now, do I get your soul or does O'Reilly?


--
Rolling Horse Ranch Technical Services                 Carsten P. Gehrke
          Custom software solutions using open source technology
http://tech.RollingHorse.com/                   Carsten@RollingHorse.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
