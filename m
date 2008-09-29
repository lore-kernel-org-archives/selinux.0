Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8TFDTWR005340
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 11:13:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m8TFCRdp025106
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 15:12:27 GMT
Message-ID: <48E0F098.9060008@manicmethod.com>
Date: Mon, 29 Sep 2008 11:13:28 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vikram Noel Ambrose <noel.ambrose@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [autotools] libselinux build system comments
References: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com> <48DE640B.10104@gmail.com> <06A6610D4F464D4EBEAFBF2C5F86911E669856@exchange2.columbia.tresys.com> <48DEEBDA.2050103@gmail.com>
In-Reply-To: <48DEEBDA.2050103@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Noel Ambrose wrote:
> Jason Tang wrote:
>> From: Vikram Noel Ambrose [mailto:noel.ambrose@gmail.com]
>>  
>>>> 4. libselinux is being installed to $(LIBDIR).  In this case, it
>>>> should default to the system library.
>>>>       
>>> What does that mean?
>>>     
>>
>> libselinux and libsepol should be installed to /lib (or /lib64).  The
>> reason is because /usr/lib may be on a different filesystem, but /lib
>> (and /lib64) is nearly guaranteed to be available by the time the
>> system will load the SELinux policy.
>>
>>  
> 
> And ./configure --libdir=/lib64. doesnt solve this?
> 

./configure (with no flags) must default to:

/lib/libsepol.so.1
/lib/libselinux.so.1
/lib/libsemanage.so.1

/usr/lib/libselinux.a
/usr/lib/libsepol.a
/usr/lib/libsemanage.a

/sbin/fixfiles
/sbin/setfiles

/etc/selinux for conf dir
/etc/pam.d for pam files

/usr/lib/python2.5/site-packages/ for all python wrappers and files

/usr/(s)?bin for utilities

...etc...

This is not optional. I'm not going to switch to a build system under everyone that requires flags to work the way it has always worked. Those who want non-standard configurations are those required to set flags. lib64 should probably be substituted for lib on 64 bit builds.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
