Message-ID: <4AAC406D.40901@gmail.com>
Date: Sat, 12 Sep 2009 17:44:29 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>,
        James Morris <jmorris@namei.org>, Serge Hallyn <serue@us.ibm.com>,
        dwalsh@redhat.com, sds@tycho.nsa.gov
Subject: Re: [git bisected] 25354c4fee169710fd9da15f3bb2abaa24dcf933 is first
  bad commit
References: <dd18b0c30909121509j154e56e2h860266c53082cc2c@mail.gmail.com>	 <1252794521.13780.16.camel@dhcp231-106.rdu.redhat.com>	 <dd18b0c30909121646w3997e292k28bff1c3f2cc31bd@mail.gmail.com> <1252801749.13780.24.camel@dhcp231-106.rdu.redhat.com>
In-Reply-To: <1252801749.13780.24.camel@dhcp231-106.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Sat, 2009-09-12 at 16:46 -0700, Justin Mattock wrote:
>    
>> On Sat, Sep 12, 2009 at 3:28 PM, Eric Paris<eparis@redhat.com>  wrote:
>>      
>>> On Sat, 2009-09-12 at 15:09 -0700, Justin Mattock wrote:
>>>        
>>>> attached is dmesg of the latest
>>>> Head giving me an avc denial that
>>>> is giving me an error with checkpolicy:
>>>>
>>>> /usr/bin/checkpolicy -c 22  -U deny policy.conf -o policy.22
>>>> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
>>>> policy/modules/services/xserver.te":1138:ERROR 'permission
>>>> module_request is not defined for class system' at token ';' on line
>>>> 2904222:
>>>> allow NetworkManager_t kernel_t:system module_request;
>>>> #============= NetworkManager_t ==============
>>>> policy/modules/services/xserver.te":1141:ERROR 'permission
>>>> module_request is not defined for class system' at token ';' on line
>>>> 2904225:
>>>> #============= insmod_t ==============
>>>> allow insmod_t kernel_t:system module_request;
>>>> policy/modules/services/xserver.te":1144:ERROR 'permission
>>>> module_request is not defined for class system' at token ';' on line
>>>>          
>>> It's because you are using the -U deny.  You are telling the kernel to
>>> deny unknown permissions and then you are trying to define an unknown
>>> permission.  There is nothing wrong with the kernel.
>>>
>>> I do need to submit the policy path to define it, but that's not a good
>>> idea until we know more or all of the places it is needed.  I hoped to
>>> work on that with dwalsh in rawhide before we push the policy patch
>>> upstream.  You can help there!  In your base policy module you need to
>>> define 'request_module' in the system class in
>>> policy/flash/access_vectors rebuild and load the base policy policy
>>> module.  Then you can use the request_module permission.
>>>
>>> -Eric
>>>
>>>
>>>        
>> O.K. this was just a hit and a miss
>> (I don't know what I'm doing but am willing to try)
>> below fixes the error from checkpolicy,
>> but I'm not sure if it's correct.
>>
>>
>>  From 4095a245f8a4a75d8ab2f94d816159d8b180ed1f Mon Sep 17 00:00:00 2001
>> From: Justin P. Mattock<justinmattock@gmail.com>
>> Date: Sat, 12 Sep 2009 16:42:06 -0700
>> Subject: [PATCH] add module_request support
>>
>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>> ---
>>   policy/flask/access_vectors |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
>> index 3998b77..67ab292 100644
>> --- a/policy/flask/access_vectors
>> +++ b/policy/flask/access_vectors
>> @@ -349,6 +349,7 @@ class system
>>   	syslog_read
>>   	syslog_mod
>>   	syslog_console
>> +        module_request
>>   }
>>      
>
>
> Yes that is correct (outside of the fact you used eight spaces instead
> of a tab)
>
> But upstream should not commit this until a number of people have tried
> to run kernels with it defined and flushed out some reasonable number of
> the necessary allow rules (because just defining it will cause people
> with -U allow to start getting denials).
>
> -Eric
>
>
>    
Hey alright.(id have to say a lucky
guess on my part).

In this case either you can take the
patch(If I need to redu it I will)
sign off on it, then store it somewhere
until people start hitting this
then go from there.

As a backup I'll leave it on my facebook
account(so I don't forget and loose it).

Overall Thanks for helping me on this.


Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
