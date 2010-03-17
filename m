Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2HLGnUR021804
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 17:16:49 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2HLHNJW021598
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 21:17:24 GMT
Received: by wyf28 with SMTP id 28so768462wyf.12
        for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 14:16:48 -0700 (PDT)
Message-ID: <4BA146BC.8070700@gmail.com>
Date: Wed, 17 Mar 2010 14:16:44 -0700
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

On 03/17/2010 01:14 PM, Eric Paris wrote:
> #define AUDIT_USER_AVC          1107    /* We filter this differently */
>
> So some userspace object manager is denying something ?dbus?
>
> not sure what to tell you since you only get part of the message....
>
> -Eric
>
>

o.k. these are from nscd
if I reboot without nscd these go away.
weird thing is I cant find the avc's i.g.
Xorg.0.log shows nothing, messages, dmesg etc..

maybe my configs are wrong and/or maybe I need to
bisect glibc.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
