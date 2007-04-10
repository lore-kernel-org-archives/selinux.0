Message-ID: <461BACF8.7000407@manicmethod.com>
Date: Tue, 10 Apr 2007 11:27:52 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp
Subject: Re: [patch] reducing size of libselnux/libsepol for embedded
References: <20070409135030.d27a3177.ynakam@hitachisoft.jp>	<461A32E0.6020102@manicmethod.com>	<1176129881.15415.95.camel@moss-spartans.epoch.ncsc.mil> <20070410100921.2c4400a6.ynakam@hitachisoft.jp>
In-Reply-To: <20070410100921.2c4400a6.ynakam@hitachisoft.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:
> On Mon, 09 Apr 2007 10:44:41 -0400
> Stephen Smalley  wrote:
>   
>> On Mon, 2007-04-09 at 08:34 -0400, Joshua Brindle wrote:
>>     
>>> Yuichi Nakamura wrote:
>>>       
>>>> <snip>
>>>>         
>>> In the future could you please inline the patch?
>>>       
>>>> 2. About patch
>>>> We prepare 2 build options in libselinux/libsepol.
>>>> 1) make EMBEDDED=1
>>>> This is for people who want to use only monolitic policy with boolean support.
>>>> * libselinux
>>>>   Files related to userland avc is not compiled
>>>> * libsepol
>>>>   libselinux uses sepol functions(such as sepol_genusers, sepol_genboolean). 
>>>>   If people do not need modular policy, we need only to compile such functions.
>>>>
>>>> 2) make DISABLE_SEPOL=1
>>>> This can be combined with "EMBEDDED=1".
>>>> This is for people who uses poor resource devices.
>>>> libsepol functions are removed from libselinux 
>>>> so libsepol can be removed.
>>>> By that, size of libse*  can be reduced more, 
>>>> but some features(such as boolean) can not be used.
>>>>
>>>>   
>>>>         
>>> I think the defines should be more descriptive, perhaps NO_AVC, NO_BOOL, 
>>> etc.
>>>       
>> Agreed.  Look to the newrole Makefile for an example, where they defined
>> AUDIT_LOG_PRIV and NAMESPACE_PRIV flags for enabling/disabling specific
>> features, and then defined a LSPP_PRIV flag that turned them both on.
>> Thus, you can create AVC=y/n, BOOLEAN=y/n flags for individual feature
>> selection, and then define EMBEDDED as turning them all off.
>>
>> This also avoids confusion, as your DISABLE_SEPOL flag turns off
>> booleans.c presently, but booleans.c doesn't appear to depend on
>> libsepol.
>>     
> Thanks for advice, I will fix like above.
>  
>   

Looking in the patch the libsepol unused sources has this:

+UNUSED_SRCS=link.c nodes.c roles.c iface_record.c module.c 
port_record.c user_record.c interfaces.c  node_record.c
 ports.c users.c

Why is link.c unused but not expand.c? Note that this will build a 
libsepol that checkpolicy cannot link against which is fine for an 
embedded environment but it needs to be explicitly stated I think. The 
options are basically going to be to turn off module support, boolean 
support, compiler support. The security server (services.c) can be 
removed also. If compiler and persistent boolean support isn't necessary 
anymore then write.c and read.c won't be necessary either.

After all that is removed I feel like libsepol won't actually exist, I'm 
not sure what the use case is right now, what are you trying to get out 
of libsepol and how fine grained can we get on taking out support.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
