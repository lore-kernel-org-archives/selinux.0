From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Not sure the best way to handle this one.
Date: Mon, 18 Oct 2004 02:22:51 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
References: <416FCFEB.90504@redhat.com> <200410162344.56706.russell@coker.com.au> <41712F74.9020507@redhat.com>
In-Reply-To: <41712F74.9020507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410180222.51361.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 17 Oct 2004 00:25, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> >On Fri, 15 Oct 2004 23:26, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>Oct 15 08:37:55 dhcppc1 kernel: audit(1097843874.920:692545): avc:
> >>denied  { sys_module } for  pid=4338 exe=/usr/bin/nifd capability=16
> >>scontext=system_u:system_r:howl_t tcontext=system_u:system_r:howl_t
> >>tclass=capability
> >
> >What is it trying to do?  Does an strace shed any light on the matter?
>
> Can't get it to happen regularly but I would submise that it is loading
> a network driver.

I have just quickly reviewed the source to nifd and couldn't find any code to 
do any such thing.  The code isn't as clear as it might be and has no 
comments so I might have missed something, but I am reasonably sure that it's 
not trying to load a network driver.  In any case if it was trying to load a 
network driver then it would surely call system("modprobe ...") which would 
then result in insmod being the process that has the AVC message.

One problem we have with nifd is that it sends all it's log messages 
to /dev/null.  I have filed a bugzilla #136074 about this.  If it logged it's 
messages then it would be a lot easier to diagnose problems.

Also interestingly it seems that nifd has some error conditions in it's 
default configuration on my laptop, but I can only determine this with 
strace.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
