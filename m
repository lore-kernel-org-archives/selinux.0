Message-ID: <4A771300.8060900@gmail.com>
Date: Mon, 03 Aug 2009 09:40:32 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: best way to comile userspace to use lib64 for x86_64
References: <4A770542.3050103@gmail.com> <1249315769.9193.2.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1249315769.9193.2.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2009-08-03 at 08:41 -0700, Justin P. Mattock wrote:
>    
>> As an experimanet I'm building an x86_64 system, in doing so
>> I'm noticing I need to have the libs point to /lib64 and /usr/lib64
>> what is the easiest way to do this for the
>> userspace from git. looking at the Makefiles seems a bit confusing,
>> using LIBDIR=/lib64 does make /usr/lib64 but does not  make /lib64.
>>
>> any ideas?
>>      
>
> make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
>    
ahhh..
Thank you so much for that.

Seems I needed to do this:

make DESTDIR=/home/justin/test LIBDIR=/home/justin/test/usr/lib64 \
SHLIBDIR=/home/justin/test/lib64 install

or else the libs would be put in /lib64 /usr/lib64 of the host system.

Anyways seems more of a pain to build such a system due to the
multilib thing.
(but what the heck might as well)

Thanks again.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
