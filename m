Message-ID: <4E01082A.3010909@trentalancia.com>
Date: Tue, 21 Jun 2011 23:07:54 +0200
From: Guido Trentalancia <guido@trentalancia.com>
MIME-Version: 1.0
To: David Doria <daviddoria@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Missing configure script and instructions?
References: <BANLkTincN516XV4AkGnTPoL2yXvdenJ3zA@mail.gmail.com>
In-Reply-To: <BANLkTincN516XV4AkGnTPoL2yXvdenJ3zA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello David !

On 21/06/2011 22:03, David Doria wrote:
> I cloned the SELinux repository and I don't see any README, INSTALL,
> or configure files. There is a Makefile, but typically 'make' is not
> the first step in an installation process, right? How should I build
> SELinux?

You can just check the Makefile for very simple things such as editing 
the CFLAGS (compiler options) or editing the PREFIX and/or DESTDIR (I 
can't remember exactly now) and then just type:

$ make

to build

$ make install

to install it.

Otherwise, you could pass the same variables to make as in:

make CFLAGS="-g -O2 -march=corei7 -mtune=corei7"

make DESTDIR=/ PREFIX=/usr install

to build for example with debugging on an Intel Corei7 and install under 
/usr on root filesystem.

> Thanks,
>
> David

configure won't be strictly needed (as there are very few simple build 
options). And it's not packaged strictly according to GNU guidelines, so 
it might not carry INSTALL, README, NEWS and friends.

But in a sense you're right, one day the whole thing shall evolve 
towards being a little bit more conformant to GNU guidelines (and 
provide for example autoconf tools even if they might not appear as 
strictly needed but at least for consistency with the underlying world).

Hope it helps.

Regards,

Guido

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
