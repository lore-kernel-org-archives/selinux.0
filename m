From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?iso-8859-2?q?Magos=E1nyi=20=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: 2.6.0-test3
Date: Thu, 21 Aug 2003 23:37:59 +1000
References: <1061468940.1665.16.camel@kusturica>
In-Reply-To: <1061468940.1665.16.camel@kusturica>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200308212337.59952.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Aug 2003 22:29, Magosányi Árpád wrote:
> I have a 2.6.0-test3 kernel.
> It seems that I have compiled in selinux, and it initializes at boot,
> but I cannot use it. What did I done wrong?

The 2.6.0 kernel (and the kernel-patch I recently uploaded known as "lsm2" in 
the kernel-patch-2.4-lsm package) have a new version of SE Linux.

This new version of SE Linux does not use the sys_security system call, and 
therefore any application compiled for the old SE Linux which uses that call 
(such as avc_toggle) will fail.

Colin Walters is doing most of the work for the new SE Linux in Debian at the 
moment.  Unfortunately my 2.6.0 work has not progressed far enough for me to 
be able to advise you on how to do it right at this time.  Hopefully Colin 
will be able to help.

The #selinux channel on irc.debian.org may help you too, there are a number of 
people there who are experimenting with 2.6.0 who can probably give you some 
pointers.

Finally before anyone asks, UML and SE Linux should work with kernel 
2.6.0test3 if you use the one line patch suggested by Steve.  However for me 
it doesn't work at all, there are several different kernel bugs which get in 
the way.  I am looking forward to 2.6.0test4, test3 seems too flakey.

For the new SE Linux you are probably better off using the back-port to 
2.4.21.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
