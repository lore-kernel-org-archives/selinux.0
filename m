Message-ID: <4784D902.6000802@manicmethod.com>
Date: Wed, 09 Jan 2008 09:24:02 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [patch 7/7] Use -Werror
References: <200801072047.m07KlXAs026116@cadmus.columbia.tresys.com> <1199884164.9393.210.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880153F432@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880153F432@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> Stephen Smalley wrote:
>   
>> On Mon, 2008-01-07 at 15:47 -0500, Todd C. Miller wrote:
>>     
>>> Stephen Smalley wrote:
>>>
>>>       
>>>> A bit overzealous though - some of them already had -Werror in
>>>> CFLAGS. Also need to make sure that -Werror gets included by make
>>>> DEBUG=1. 
>>>>         
>>> Updated patch without the duplicated -Werror and adds it for
>>> the DEBUG=1 cases.
>>>       
>> This breaks make pywrap in libselinux, or install-pywrap from top.
>>     
>
> I always forget that pywrap is not built by the default target.
> I'll commit a fix to filter out -Werror for pywrap.
>   

Also with DEBUG=1 there is another warning in newrole.c about a shadowed 
var.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
