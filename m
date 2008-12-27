Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBR9JqkG006762
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 04:19:52 -0500
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBR9HNd0007655
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 09:17:23 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1328321ywa.84
        for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 01:19:52 -0800 (PST)
Message-ID: <4955F335.6030404@gmail.com>
Date: Sat, 27 Dec 2008 01:19:49 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: xing li <lixing.1006@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: when and how the selinux label all file system according to "file_contexts"?
References: <707f057d0812270055r153efe73nd5649d3bc0c4fe0c@mail.gmail.com>
In-Reply-To: <707f057d0812270055r153efe73nd5649d3bc0c4fe0c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

xing li wrote:
> I have confused by the question:
> when and how the selinux label all file system according to 
> "file_contexts"?
> and i found the clue that when we "touch /.autorelabel",the system 
> would invoke
> "fixfiles relabel" to relabel the file system. but i could't find the 
> relevant source code.
> Maybt somebody has investigated that and could share infomation? 
 From what I remember,
.autorelabel is called by a daemon,
(selinux-basic package); but am unclear with
what the name might be with the different distros.
I normally make policy; make install; make relabel;
that is if anybody uses the commands "make"
anymore.

regards;

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
