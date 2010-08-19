Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7JHHwwA001326
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 13:17:58 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7JHHo9p017217
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 17:17:50 GMT
Received: by pxi5 with SMTP id 5so851297pxi.12
        for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 10:17:57 -0700 (PDT)
Message-ID: <4C6D6769.2020008@gmail.com>
Date: Thu, 19 Aug 2010 10:18:33 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Adam Jackson <ajax@nwnk.net>
CC: xorg@freedesktop.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH]include/dixaccess.h fix comment.
References: <1282236203-4267-1-git-send-email-justinmattock@gmail.com> <1282237588.17843.23388.camel@atropine>
In-Reply-To: <1282237588.17843.23388.camel@atropine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/19/2010 10:06 AM, Adam Jackson wrote:
> On Thu, 2010-08-19 at 09:43 -0700, Justin P. Mattock wrote:
>> After reading through XACE-Spec.txt, then looking through all the code
>> I found the below comment, not to make sense. I think it needs to be
>> changed to "adjust" due to the Property access mode bits giving info
>> on adjusting different modes etc..(but could be wrong).
>
> "or" as a verb is common C idiom.  DixReadAccess | DixWriteAccess ...
> the | is pronounced "or".
>
> - ajax

ahh.. I see now.. "|"  didnt see that..

cool, Thanks.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
