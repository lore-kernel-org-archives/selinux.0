Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2HLr0uq023480
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 17:53:00 -0400
Received: from mail-fx0-f222.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2HLrXJW001664
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 21:53:34 GMT
Received: by fxm22 with SMTP id 22so1566198fxm.34
        for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 14:52:57 -0700 (PDT)
Message-ID: <4BA14F35.5050007@gmail.com>
Date: Wed, 17 Mar 2010 14:52:53 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: new: loads of audit messgs
References: <dd18b0c31003161804i5275304cl13256077080946c4@mail.gmail.com> <7e0fb38c1003171314v6d1ab81fv6ac7a9556dfddd1@mail.gmail.com>
In-Reply-To: <7e0fb38c1003171314v6d1ab81fv6ac7a9556dfddd1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

weird.. I load up:
vmlinuz-2.6.32-rc7-00030-g4dea955
I can see the avc's denials in dmesg,
I load the latest I just see some audit thing.

I'll bisect this, and check my configs

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
