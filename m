Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0LJJmKB026862
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 14:19:48 -0500
Received: from mho-01-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0LJGq90014029
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 19:16:53 GMT
Cc: SE-Linux <selinux@tycho.nsa.gov>
Message-Id: <6B394862-5019-497D-984C-92A7B936CA1F@nall.com>
From: Joe Nall <joe@nall.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
In-Reply-To: <49776DDD.6080306@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: run_init confusion
Date: Wed, 21 Jan 2009 13:19:44 -0600
References: <49776DDD.6080306@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jan 21, 2009, at 12:47 PM, Justin P. Mattock wrote:

> I'm having an issue with run_init.
> each time I try to restart alsa-utils
> I get this:
>
> name@computer:~$ newrole -r sysadm_r -- -c /usr/sbin/run_init /etc/ 
> init.d/alsa-utils restart

newrole -r sysadm_r -- -c "/usr/sbin/run_init /etc/init.d/alsa-utils  
restart"

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
