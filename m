Message-ID: <455B5DAE.8040408@mentalrootkit.com>
Date: Wed, 15 Nov 2006 13:34:22 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Multiple small fixes to policycoreutils
References: <4559DB81.7060601@redhat.com>	 <1163520813.18181.131.camel@sgc.columbia.tresys.com>	 <4559EC69.90407@redhat.com> <1163531945.7374.11.camel@sgc.columbia.tresys.com> <455A227E.1040403@redhat.com>
In-Reply-To: <455A227E.1040403@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
>> On Tue, 2006-11-14 at 11:18 -0500, Daniel J Walsh wrote:
>>  
>>> Christopher J. PeBenito wrote:
>>>    
>>>> On Tue, 2006-11-14 at 10:06 -0500, Daniel J Walsh wrote:
>>>>        
>>>>> Add -fPIE and -pie to build of restorecond.
>>>>>             
>>>>        
>>>>> -CFLAGS ?= -g -Werror -Wall -W
>>>>> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
>>>>> +LDFLAGS ?= -pie
>>>>> +CFLAGS ?= -g -Werror -Wall -W +override CFLAGS += 
>>>>> -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE
>>>>>             
>>>> I would say that this shouldn't be added in general, especially not to
>>>> the override.  The default flags should be pretty basic, IMO.
>>>>
>>>>         
>>> How about if we change
>>> LDFLAGS ?= ?= $(RANDLDFLAG)
>>> override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 
>>> $(RANDCFLAG)
>>>     
>>
>> Why does this need to be special?  "?=" means if the variable isn't
>> already set (setting CFLAGS to "" counts as set), then its set with the
>> right side.  This assignment won't happen if CFLAGS is set:
>>
>> CFLAGS ?= -g -Werror -Wall -W
>>
>> So in your spec file you just change your make command to `make
>> CFLAGS="-fPIE" LDFLAGS="-pie"`, then you'll get the behavior of the
>> patch above.  Keeping the makefile as is will keep the defaults safe,
>> and then distros can set things whichever way they want with CFLAGS and
>> LDFLAGS and not have extra compile/linking flags pop up.
>>
>>   
> No because this will effect all the Makefiles, not just the daemon 
> ones.  I do not want to build restorecon/setfiles etc with -fPIE.
> 

What about a top-level USE_PIE makefile variable that directs all 
sub-Makefiles to set PIE flags if appropriate for that module? By 
default it would be off. This gets the behavior you want without having 
to carry a patch and keeps the current behavior.

Karl

> 
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
