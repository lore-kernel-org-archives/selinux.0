Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8S2T1Gs025057
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 22:29:01 -0400
Received: from hs-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8S2S1Yv029754
	for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2008 02:28:01 GMT
Received: by hs-out-0708.google.com with SMTP id k27so620879hsc.2
        for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 19:29:01 -0700 (PDT)
Message-ID: <48DEEBDA.2050103@gmail.com>
Date: Sat, 27 Sep 2008 22:28:42 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [autotools] libselinux build system comments
References: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com> <48DE640B.10104@gmail.com> <06A6610D4F464D4EBEAFBF2C5F86911E669856@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E669856@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jason Tang wrote:
> From: Vikram Noel Ambrose [mailto:noel.ambrose@gmail.com]
>   
>>> 4. libselinux is being installed to $(LIBDIR).  In this case, it should default to the system library.
>>>       
>> What does that mean?
>>     
>
> libselinux and libsepol should be installed to /lib (or /lib64).  The reason is because /usr/lib may be on a different filesystem, but /lib (and /lib64) is nearly guaranteed to be available by the time the system will load the SELinux policy.
>
>   
>

And ./configure --libdir=/lib64. doesnt solve this?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
