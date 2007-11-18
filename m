Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAIBfRn3007537
	for <selinux@tycho.nsa.gov>; Sun, 18 Nov 2007 06:41:28 -0500
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAIBfPKJ021025
	for <selinux@tycho.nsa.gov>; Sun, 18 Nov 2007 11:41:26 GMT
Message-ID: <474024DB.3030803@kaigai.gr.jp>
Date: Sun, 18 Nov 2007 20:41:15 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: "semanage login -l" is working on F8?
References: <f71a82820711180001n24228f18x55410b882f38c98f@mail.gmail.com>
In-Reply-To: <f71a82820711180001n24228f18x55410b882f38c98f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You can avoid this problem with "env LANG=C".

I guess somewhere in semanage depends on the locale.

Shintaro Fujiwara wrote:
> I typed "semanage login -l" on F8.
> I got
> 
> /usr/sbin/semanage: ascii
> 
> What's this ?
> 
> I want to manage SELinux user...
> 


-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
