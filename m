Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84I9Dgc006888
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 14:09:13 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m84I8Zmp009451
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 18:08:36 GMT
Message-ID: <48C02447.9030507@manicmethod.com>
Date: Thu, 04 Sep 2008 14:09:11 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vikram Noel Ambrose <noel.ambrose@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][autotools] libselinux/load_policy.o compile error
References: <48BF58E7.4030806@gmail.com> <48BFFFC6.6090100@manicmethod.com> <48C011FD.8080603@gmail.com>
In-Reply-To: <48C011FD.8080603@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Noel Ambrose wrote:
> Joshua Brindle wrote:
>> Vikram Noel Ambrose wrote:
>>  
>>> Here's the fix to that libselinux ld error you were getting.
>>>
>>>     
>>
>> Ok, applied and built fine. One interesting thing is that even without
>> building the swig wrappers (--disable-swig) it still installs
>> lib/python2.5/site-packages/selinux, which obviously wouldn't work
>> without the accompanying .so file.
>>
>>   
> 
> I'll have a look at that, thanks.
> 
>> Also, it looks like any library that installs to /lib will also put
>> their python stuff in /lib/python2.5. I don't know if python even
>> knows to look there, and even if it does there is really no reason to
>> put them there. libselinux.so and libsepol.so will need to go to /lib
>> but the python stuff should go to /usr/lib and I don't see a different
>> argument for the python stuff (only --libdir).
>>
>>
>>   
> Here you are referring to libpy*.so? if so then, Yes, python does know
> to look for it in its site-packages/$pkg/ folder.
> 

I know that, I mean no python .so files or .py files are put in /lib/python2.5, they are all put in /usr/lib/python2.5. However, since libselinux.so and libsepol.so (the real libs) have to be in /lib/ there is no way to tell configure to split those up (since they both use libdir)

> 
> And in regards to the AUTHORS file, it obviously would be in source
> control and as the persons in question patch the tree, they could
> obviously patch the file with their names as well, its not set in stone
> or anything.
> 
> 
> Vikram
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
