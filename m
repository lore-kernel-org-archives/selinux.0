Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: gdsmarshall@hushmail.com, SELinux@tycho.nsa.gov
Subject: Re: libsecure fails to compile
Date: Tue, 25 Jun 2002 13:28:01 -0400
References: <200206251543.g5PFhg451838@mailserver4.hushmail.com>
In-Reply-To: <200206251543.g5PFhg451838@mailserver4.hushmail.com>
MIME-Version: 1.0
Message-Id: <20020625172801.4DEAE3CE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Jun 2002 11:43, gdsmarshall@hushmail.com wrote:
> make -C src
> make[1]: Entering directory `/root/selinux/selinux/libsecure/src'
> cc -o arch/i386/fstat64_secure.o -c -I../include
> -I/usr/local/selinux/include arch/i386/fstat64_secure.c In file included
> from arch/i386/fstat64_secure.c:6:
> arch/i386/xstat64_conv.h: In function `xstat64_conv':
> arch/i386/xstat64_conv.h:38: structure has no member named `__st_ino'
> make[1]: *** [arch/i386/fstat64_secure.o] Error 1
> make[1]: Leaving directory `/root/selinux/selinux/libsecure/src'
> make: *** [all] Error 2
> gatekeeper:~/selinux/selinux/libsecure#
>
> I understand xstat64_conv.h is missing __st_ino, what should this be
> please?

Do you have the 2.4.18 kernel headers installed?

> I am using debian (stable)  I know Russell Coker has done lots of work with
> SELinux on debian, but I can not get to the stage of compiling the
> utilities yet.

Unfortunately I have no time to back-port this code to potato.  Maybe you 
should consider the option of upgrading to woody/testing?  Woody is closer to 
a full production release state than SE Linux...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
