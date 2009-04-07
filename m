Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n37GX2RC004266
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 12:33:02 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n37GX1QR020743
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 16:33:02 GMT
Message-ID: <49DB8036.40508@redhat.com>
Date: Tue, 07 Apr 2009 12:32:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: sixiaolin0 <sixiaolin067@126.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Is there strict policy for fedora 10?
References: <17972721.991111239117863388.JavaMail.coremail@bj126app30.126.com>
In-Reply-To: <17972721.991111239117863388.JavaMail.coremail@bj126app30.126.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/07/2009 11:24 AM, sixiaolin0 wrote:
>
> hello everyone!
>    I want to ask  if there is strict policy for FC10.
>
>
>    And could you tell me where and  how I can see the policy file without using a policy tools?
>
> thank you very much!
>
F10 has Strict/Targeted policy combined so, you can use confined users 
on a targeted f10 machine.

If you remove the unconfined.pp you can get the equivalent of strict.

But what exactly are you looking for with Strict policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
