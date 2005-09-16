Date: Fri, 16 Sep 2005 14:47:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New ideas on implementation on libsetrans.
Message-ID: <20050916134738.GB9092@lkcl.net>
References: <20050914172547.14693.qmail@web51506.mail.yahoo.com> <1126720911.12299.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126720911.12299.142.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 14, 2005 at 02:01:51PM -0400, Stephen Smalley wrote:
> On Wed, 2005-09-14 at 10:25 -0700, Steve G wrote:
> > My concern which lead to consideration of the daemon approach is the performance
> > penalty imposed by dlopen & dlsym as well as parsing the configuration each time
> > a program starts up. dlopen is a heavy function call. Communication across a
> > af_unix socket is likely to be faster since there are fewer syscalls.
> 
> BTW, I'd want to see measurements there before jumping to that
> assumption.  Don't forget the socket setup 

 there are other ways: shared memory.

 samba contains _stacks_ of uses of shared memory, plus if you use the
 right google search keywords it's possible to find a library with a
 unix-domain-socket-like-looking-interface that actually uses shared
 memory behind it.

 it's a library written by sun, iirc.

> and context switch overhead.
 
 oops :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
