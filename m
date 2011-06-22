Message-ID: <4E0218CF.9090709@trentalancia.com>
Date: Wed, 22 Jun 2011 18:31:11 +0200
From: Guido Trentalancia <guido@trentalancia.com>
MIME-Version: 1.0
To: David Doria <daviddoria@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Missing configure script and instructions?
References: <BANLkTincN516XV4AkGnTPoL2yXvdenJ3zA@mail.gmail.com>	<4E01082A.3010909@trentalancia.com>	<BANLkTim5xvWcHKCFR+9iG_=Bud+u7xuCiA@mail.gmail.com>	<4E010FA2.9090809@trentalancia.com> <BANLkTikMzXsT2P6oM8QfRrrWD=7b-p=y6w@mail.gmail.com>
In-Reply-To: <BANLkTikMzXsT2P6oM8QfRrrWD=7b-p=y6w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 21/06/2011 23:45, David Doria wrote:

[cut]

>>> I then I tried this:
>>>
>>> ~/src/selinux$ make PREFIX=/home/ddoria/bin
>>>
>>> and it got farther, but eventually came to:
>>>
>>> sed -e 's/@VERSION@/2.0.45/; s:@prefix@:/home/ddoria/bin:;
>>> s:@libdir@:lib:; s:@includedir@:/home/ddoria/bin/include:'<
>>> libsepol.pc.in>    libsepol.pc
>>> test -d /home/ddoria/bin/lib || install -m 755 -d /home/ddoria/bin/lib
>>> install -m 644 libsepol.a  /home/ddoria/bin/lib
>>> test -d /lib || install -m 755 -d /lib
>>> install -m 755 libsepol.so.1 /lib
>>> install: cannot remove `/lib/libsepol.so.1': Permission denied
>>> make[2]: *** [install] Error 1
>>> make[2]: Leaving directory `/home/ddoria/src/selinux/libsepol/src'
>>> make[1]: *** [install] Error 2
>>> make[1]: Leaving directory `/home/ddoria/src/selinux/libsepol'
>>> make: *** [install] Error 1
>>>
>>> (The same problem, trying to write to /lib which I don't have
>>> permission to write to)
>>>
>>> What is the difference between DESTDIR and PREFIX? Should I set them
>>> both to /home/ddoria/bin ?
>> Usually they are given a different meaning. If you are not installing under
>> the root filesystem (as in your case), then you should be able to use
>> DESTDIR.
>>
>> In your case:
>>
>> DESTDIR=/home/ddoria
>> PREFIX=/

You could also try DESTDIR=/home/ddoria and the other one empty as in 
PREFIX=

or not setting PREFIX at all, as suggested by Stephen, although that 
would likely end up being set by the Makefile to /usr, which you did not 
appear to have under your home (from the logs I think).
>> provided that under your home directory you haven't got /usr.
>>
>> But you should double-check everything as I do not have the Makefile handy
>> at the moment. I am not 100% sure that DESTDIR is supported by the Makefile
>> there.
>>
>> In any case, you should refer to the administrator of your system. SELinux
>> is a security framework that integrates with the underlying operating
>> system, so it's not going to be used as an application that the user can
>> install into his/her home directory.
>>
>> And because of the above it needs kernel support. If you are not the
>> administrator of that system, you cannot install kernel support for SELinux.

[cut]

> The long story of why I am doing this is that I am am trying to build
> kdevelop. To do that, I need kdelibs. To build kdelibs, I need a
> "KAuth backend". I am trying to use polkit for this purpose. To build
> polkit, I need libpam. To build libpam, I need SELinux. So it is not
> important that SELinux "work", but rather just allow everything else
> to build.

And if the system you are using is not SELinux-enabled, you won't even 
need to compile PAM with SELinux support.

Least but not last, if you do not have administrative privileges on that 
system, I doubt you'll ever get very far with then eventually running of 
all this on that same system. As already explained, you should probably 
refer to the system administrator for better chances of success in what 
you are trying to achieve.

> I tried to 'make' SELinux with:
> DESTDIR=/home/ddoria
> PREFIX=/

See above.

> and it complained that it could not write to //include
>
> So then I tried with:
> DESTDIR=/home/ddoria
> PREFIX=/home/ddoria
>
> and it got farther, but then said:
>
> genhomedircon.c:37:18: error: ustr.h: No such file or directory
>
> The fun continues...
>
> David
>

Regards,

Guido

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
