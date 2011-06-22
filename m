Message-ID: <4E0152DC.9060506@trentalancia.com>
Date: Wed, 22 Jun 2011 04:26:36 +0200
From: Guido Trentalancia <guido@trentalancia.com>
MIME-Version: 1.0
To: David Doria <daviddoria@gmail.com>, SELinux@tycho.nsa.gov
Subject: Re: Missing configure script and instructions?
References: <BANLkTincN516XV4AkGnTPoL2yXvdenJ3zA@mail.gmail.com>	<4E01082A.3010909@trentalancia.com>	<BANLkTim5xvWcHKCFR+9iG_=Bud+u7xuCiA@mail.gmail.com>	<4E010FA2.9090809@trentalancia.com> <BANLkTikMzXsT2P6oM8QfRrrWD=7b-p=y6w@mail.gmail.com>
In-Reply-To: <BANLkTikMzXsT2P6oM8QfRrrWD=7b-p=y6w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 21/06/2011 23:45, David Doria wrote:
> On Tue, Jun 21, 2011 at 5:39 PM, Guido Trentalancia
> <guido@trentalancia.com>  wrote:
>> Hi David !
>>
>> On 21/06/2011 23:15, David Doria wrote:
>>> On Tue, Jun 21, 2011 at 5:07 PM, Guido Trentalancia
>>> <guido@trentalancia.com>    wrote:
>>>> Hello David !
>>>>
>>>> On 21/06/2011 22:03, David Doria wrote:
>>>>> I cloned the SELinux repository and I don't see any README, INSTALL,
>>>>> or configure files. There is a Makefile, but typically 'make' is not
>>>>> the first step in an installation process, right? How should I build
>>>>> SELinux?
>>>> You can just check the Makefile for very simple things such as editing
>>>> the
>>>> CFLAGS (compiler options) or editing the PREFIX and/or DESTDIR (I can't
>>>> remember exactly now) and then just type:
>>>>
>>>> $ make
>>>>
>>>> to build
>>>>
>>>> $ make install
>>>>
>>>> to install it.
>>>>
>>>> Otherwise, you could pass the same variables to make as in:
>>>>
>>>> make CFLAGS="-g -O2 -march=corei7 -mtune=corei7"
>>>>
>>>> make DESTDIR=/ PREFIX=/usr install
>>>>
>>>> to build for example with debugging on an Intel Corei7 and install under
>>>> /usr on root filesystem.
>>>>
>>>>> Thanks,
>>>>>
>>>>> David
>>>> configure won't be strictly needed (as there are very few simple build
>>>> options). And it's not packaged strictly according to GNU guidelines, so
>>>> it
>>>> might not carry INSTALL, README, NEWS and friends.
>>>>
>>>> But in a sense you're right, one day the whole thing shall evolve towards
>>>> being a little bit more conformant to GNU guidelines (and provide for
>>>> example autoconf tools even if they might not appear as strictly needed
>>>> but
>>>> at least for consistency with the underlying world).
>>>>
>>>> Hope it helps.
>>>>
>>>> Regards,
>>>>
>>>> Guido
>>>>
>>> Thanks Guido,
>>>
>>> I'm glad you agree with a transition to a more standard looking system :)
>> Yes, it could bring advantages because at the end there are "hidden" options
>> in the code (perhaps you won't understand at this stage if you've never used
>> it before, but many people on this list surely know that for example
>> authentication to be used for run_init must be configured by editing the
>> code, therefore "hidden" especially to a first-time user).
>>
>> But investments are usually made on more substantial changes and
>> improvements to the code...
>>
>>> For the moment, I tried this:
>>>
>>> ~/src/selinux$ make
>>>
>>> and got errors like this:
>>>
>>> install: cannot remove `/usr/include/sepol/sepol.h': Permission denied
>>>
>>> (NOTE: I don't have root on this machine)
>> If you haven't got root permissions on the machine, I suppose more or less
>> that is the end of the game.
>>
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
>>
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
>>
>>> Thanks,
>>>
>>> David
>>>
>> Regards,
>>
>> Guido
>>
>>
> The long story of why I am doing this is that I am am trying to build
> kdevelop. To do that, I need kdelibs. To build kdelibs, I need a
> "KAuth backend". I am trying to use polkit for this purpose. To build
> polkit, I need libpam. To build libpam, I need SELinux. So it is not
> important that SELinux "work", but rather just allow everything else
> to build.
>
> I tried to 'make' SELinux with:
> DESTDIR=/home/ddoria
> PREFIX=/
>
> and it complained that it could not write to //include

That could be a trival issue in one of the Makefiles (not honouring 
DESTDIR), although I doubt there is an issue there. But as I told you, I 
am not able to check now.

But it's rather easy to fix it by hand. Eventually is not pre-pending 
$(DESTDIR) when installing something in $(PREFIX)/include

> So then I tried with:
> DESTDIR=/home/ddoria
> PREFIX=/home/ddoria

That means install under /home/ddoria/home/ddoria (provided that both 
variables are honoured correctly by the Makefile).

> and it got farther, but then said:
>
> genhomedircon.c:37:18: error: ustr.h: No such file or directory
>
> The fun continues...

It cannot find a header file.

More specifically should be this one:

http://www.and.org/ustr/src/ustr.h

which you can get bundled with the rest of the code here:

http://www.and.org/ustr/

Can you not Google this stuff ?

And if you just need to build something else, can you not just install a 
binary version from the distribution ? Or even manually install the 
header files and the library ?

And I am not even sure that PAM needs libsemanage (should just need 
libselinux). genhomedircon.c is from libsemanage.

> David

Regards,

Guido

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
