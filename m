Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8TJZu1P026728
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 15:35:56 -0400
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8TJZuix013700
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 19:35:56 GMT
Received: by yx-out-1718.google.com with SMTP id 3so360822yxi.84
        for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 12:35:56 -0700 (PDT)
Message-ID: <48E12E0A.3000604@gmail.com>
Date: Mon, 29 Sep 2008 15:35:38 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: Jason Tang <jtang@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [autotools] libselinux build system comments
References: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com> <48DE640B.10104@gmail.com> <06A6610D4F464D4EBEAFBF2C5F86911E669856@exchange2.columbia.tresys.com> <48DEEBDA.2050103@gmail.com> <06A6610D4F464D4EBEAFBF2C5F86911E669857@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E669857@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jason Tang wrote:
> From: owner-selinux@tycho.nsa.gov on behalf of Vikram Noel Ambrose
> Sent: Sat 2008-09-27 22:28
> To: SE Linux
> Subject: Re: [autotools] libselinux build system comments
>  
>   
>>> libselinux and libsepol should be installed to /lib (or /lib64).  The reason is because /usr/lib may be on a different 
>>> filesystem, but /lib (and /lib64) is nearly guaranteed to be available by the time the system will load the SELinux policy.
>>>       
>
>   
>> And ./configure --libdir=/lib64. doesnt solve this?
>>     
>
> No, because then libsemanage would be installed to the wrong location.
>
>   
Sorry I don't follow, do you mean all the sub-packages need to be 
compiled with the same configure parameters?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
