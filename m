Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4QNv8Rb000041
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 19:57:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4QNsbar023301
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 23:54:38 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
	by jazzswing.ncsc.mil  with SMTP id i4QNsbQu023294
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 23:54:37 GMT
Message-ID: <1985.68.6.187.64.1085615340.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <004901c44366$a0f3bd70$9a0c010a@columbia.tresys.com>
References: <004901c44366$a0f3bd70$9a0c010a@columbia.tresys.com>
Date: Wed, 26 May 2004 16:49:00 -0700 (PDT)
Subject: Re: FW: XP as a base for NetTop
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: mayerf@tresys.com
Cc: "'SELinux List'" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Stephen Smalley wrote:
>> Looks like Microsoft is indeed pushing an XP-based NetTop
>> called Trusted Multi-Net/Typhon XP, e.g.:
>>
>> http://www.computerweekly.com/Article123730.htm
>>
> http://download.microsoft.com/download/4/f/8/4f89f896-f020-46d1-adc0-08a18c8432d
> 5/Trusted%20Multi-Net%20for%20SSE%202003.ppt
>

Interesting.

The slides indicate that in their system threads are able to change what
context they run in.

It makes me wonder if they have some magic to prevent threads from
poluting shared data (unlikely), or if it is just a hack to avoid process
vs. thread design issues on windows.

-Chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
