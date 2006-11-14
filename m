Message-ID: <4559EC69.90407@redhat.com>
Date: Tue, 14 Nov 2006 11:18:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Multiple small fixes to policycoreutils
References: <4559DB81.7060601@redhat.com> <1163520813.18181.131.camel@sgc.columbia.tresys.com>
In-Reply-To: <1163520813.18181.131.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2006-11-14 at 10:06 -0500, Daniel J Walsh wrote:
>   
>> Add -fPIE and -pie to build of restorecond.
>>     
>
>   
>> -CFLAGS ?= -g -Werror -Wall -W
>> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
>> +LDFLAGS ?= -pie
>> +CFLAGS ?= -g -Werror -Wall -W 
>> +override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE
>>     
>
> I would say that this shouldn't be added in general, especially not to
> the override.  The default flags should be pretty basic, IMO.
>
>   
How about if we change
LDFLAGS ?= ?= $(RANDLDFLAG)
override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 $(RANDCFLAG)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
