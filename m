From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, Michael Reilly <michaelr@cisco.com>
Subject: Re: Yet another question - newrole and xterm's
Date: Fri, 17 Oct 2003 02:16:37 +1000
Cc: SELinux@tycho.nsa.gov
References: <20031015191716.5478c74b.michaelr@cisco.com> <1066307222.24561.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066307222.24561.7.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310170216.37933.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Oct 2003 22:27, Stephen Smalley wrote:
> > changing the dontaudit line to this and reloading the policy
> > allow newrole_t proc_t:dir search;
>
> This is peculiar, as newrole.te also includes:
> 	can_setexec(newrole_t)
>
> and can_setexec() includes:
> 	allow $1 proc_t:dir search;

Yes, the idea is that you can use the same policy on old or new SE Linux.  If 
you use it on the old SE Linux then /proc is unavailable.  If you use it on 
the new SE Linux then can_setexec() covers it.

Michael, are you running old or new SE Linux?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
