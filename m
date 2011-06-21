MIME-Version: 1.0
In-Reply-To: <4E01082A.3010909@trentalancia.com>
References: <BANLkTincN516XV4AkGnTPoL2yXvdenJ3zA@mail.gmail.com>
	<4E01082A.3010909@trentalancia.com>
Date: Tue, 21 Jun 2011 17:15:32 -0400
Message-ID: <BANLkTim5xvWcHKCFR+9iG_=Bud+u7xuCiA@mail.gmail.com>
Subject: Re: Missing configure script and instructions?
From: David Doria <daviddoria@gmail.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 21, 2011 at 5:07 PM, Guido Trentalancia
<guido@trentalancia.com> wrote:
> Hello David !
>
> On 21/06/2011 22:03, David Doria wrote:
>>
>> I cloned the SELinux repository and I don't see any README, INSTALL,
>> or configure files. There is a Makefile, but typically 'make' is not
>> the first step in an installation process, right? How should I build
>> SELinux?
>
> You can just check the Makefile for very simple things such as editing the
> CFLAGS (compiler options) or editing the PREFIX and/or DESTDIR (I can't
> remember exactly now) and then just type:
>
> $ make
>
> to build
>
> $ make install
>
> to install it.
>
> Otherwise, you could pass the same variables to make as in:
>
> make CFLAGS="-g -O2 -march=corei7 -mtune=corei7"
>
> make DESTDIR=/ PREFIX=/usr install
>
> to build for example with debugging on an Intel Corei7 and install under
> /usr on root filesystem.
>
>> Thanks,
>>
>> David
>
> configure won't be strictly needed (as there are very few simple build
> options). And it's not packaged strictly according to GNU guidelines, so it
> might not carry INSTALL, README, NEWS and friends.
>
> But in a sense you're right, one day the whole thing shall evolve towards
> being a little bit more conformant to GNU guidelines (and provide for
> example autoconf tools even if they might not appear as strictly needed but
> at least for consistency with the underlying world).
>
> Hope it helps.
>
> Regards,
>
> Guido
>

Thanks Guido,

I'm glad you agree with a transition to a more standard looking system :)

For the moment, I tried this:

~/src/selinux$ make

and got errors like this:

install: cannot remove `/usr/include/sepol/sepol.h': Permission denied

(NOTE: I don't have root on this machine)

I then I tried this:

~/src/selinux$ make PREFIX=/home/ddoria/bin

and it got farther, but eventually came to:

sed -e 's/@VERSION@/2.0.45/; s:@prefix@:/home/ddoria/bin:;
s:@libdir@:lib:; s:@includedir@:/home/ddoria/bin/include:' <
libsepol.pc.in > libsepol.pc
test -d /home/ddoria/bin/lib || install -m 755 -d /home/ddoria/bin/lib
install -m 644 libsepol.a  /home/ddoria/bin/lib
test -d /lib || install -m 755 -d /lib
install -m 755 libsepol.so.1 /lib
install: cannot remove `/lib/libsepol.so.1': Permission denied
make[2]: *** [install] Error 1
make[2]: Leaving directory `/home/ddoria/src/selinux/libsepol/src'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/ddoria/src/selinux/libsepol'
make: *** [install] Error 1

(The same problem, trying to write to /lib which I don't have
permission to write to)

What is the difference between DESTDIR and PREFIX? Should I set them
both to /home/ddoria/bin ?

Thanks,

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
