Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m54EWevr005234
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 10:32:40 -0400
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m54EWdkF009504
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 14:32:39 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: NetLabel
Date: Wed, 4 Jun 2008 10:31:33 -0400
Cc: selinux@tycho.nsa.gov
References: <dd18b0c30806032355v44c0b5d2u965e3e7a65ba2e24@mail.gmail.com>
In-Reply-To: <dd18b0c30806032355v44c0b5d2u965e3e7a65ba2e24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806041031.33060.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 04 June 2008 2:55:15 am Justin Mattock wrote:
> Hello; Hopefully this is the right list to post this question,
> after looking at  NetLabel, in dmesg I couldn't help but see:
> [    0.570655] NetLabel: Initializing
> [    0.570660] NetLabel:  domain hash size = 128
> [    0.570663] NetLabel:  protocols = UNLABELED CIPSOv4
> [    0.570730] NetLabel:  unlabeled traffic allowed by default
>
> "unlabeled traffic allowed by default."
> is this similar to selinux (handle_unkown=deny, if so is there an
> option to change this to "unlabeled traffic deny."

Nope, the two are completely unrelated.  By default, NetLabel allows 
unlabeled traffic to pass (meaning the netlbl_skbuff_getattr() function 
returns an empty secattr and no error, the LSM does the actual packet 
pass/drop) so as to keep networking working for the majority of users 
who do not configure NetLabel.  If you were to disable unlabeled 
traffic using NetLabel only CIPSO and static/fallback (using 2.6.25 or 
greater) labeled traffic would be allowed into the system.

Unless you really know what you are doing I wouldn't mess with this 
setting.

> Also is there a location for this in the kernel i.g. /proc/sys/net/*
> regards;

There are some sysctl variables which offer control of the 
NetLabel/CIPSO functionality they do no toggle the unlabeled allow/deny 
behavior, for that you need the netlabel_tools package, specifically 
netlabelctl.

 * http://netlabel.sf.net

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
