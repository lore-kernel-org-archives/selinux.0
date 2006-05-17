Message-ID: <446B5E2C.6010707@gentoo.org>
Date: Wed, 17 May 2006 13:32:28 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
References: <446AFED3.9010800@redhat.com> <446B4D6C.3070605@redhat.com> <446B58E5.7030504@gentoo.org> <200605171330.05860.sgrubb@redhat.com>
In-Reply-To: <200605171330.05860.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Wednesday 17 May 2006 13:09, Joshua Brindle wrote:
>   
>>> One suggestion I have heard is to allow the administrator to turn off
>>> the cache, perhaps via /etc/selinux/config???
>>>       
>> That sounds good, will this be included in the next patch?
>>     
>
> I think if you have to parse /etc/selinux/config, you've lost all performance 
> gains from caching. May as well not have this patch and call the daemon 
> everytime.
>
>   
IIUC you'll only parse it on setrans_client startup so once per 
application, and you have to parse /etc/selinux/config at that time anyway.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
