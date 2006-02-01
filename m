From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: labeling of compilers etc
Date: Thu, 2 Feb 2006 10:27:07 +1100
Cc: SELinux-dev@tresys.com, SELinux List <selinux@tycho.nsa.gov>
References: <200601291156.13076.russell@coker.com.au> <200601311847.56015.russell@coker.com.au> <1138801545.18268.32.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138801545.18268.32.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602021027.16336.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 02 February 2006 00:45, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2006-01-31 at 18:47 +1100, Russell Coker wrote:
> > If the shell can read two files but should only "execute" one of them
> > then it's something that can only be enforced by the shell itself.
>
> Except that domain transitions don't occur when you run the shell
> directly, so we are only talking about an execve on a script, where the
> kernel can adjudicate whether the script file is a valid entrypoint for
> the domain.  Running bash on the same script won't yield the domain
> transition.

I probably should have split this discussion into two messages.  There are two 
issues here, that of domain_auto_trans() on shell scripts and that of general 
execution of shell code.

You are correct that there is no domain transition related to the script when 
the shell is executed directly.  However it's still desirable to enforce 
access control over which files can be executed.

> > Naturally we would not break them.  My proposal would still support such
> > things with a little extra policy.
> >
> > Below the line "domain_auto_trans(init_t,initrc_exec_t,initrc_t)" we
> > would merely have to add "domain_trans(init_t, shell_exec_t, initrc_t)". 
> > The policy changes would be introduced before the changes to shells so no
> > breakage would occur.
>
> This is not exactly equivalent, see above.  Also, it should be possible
> to eliminate the kernel race condition on interpreted scripts; Solaris
> does this by pre-opening the script file and passing /dev/fd/<n> to the
> interpreter so that there is second lookup of the script file.  This
> still wouldn't make setuid/setgid bash scripts a good idea, but other
> scripting languages may be more resilient to caller influence.

That is a really good idea.  You are correct that setuid and 
domain_auto_trans() shell scripts are still a really bad idea (the shell is 
far too dependent on environment variables etc).  But anything that makes 
hostile action more difficult is a good thing.

> > open_exec() is not used when bash decides to execute a script:
> > # cat > /dev/sda1
> > echo test
> > exit 1
> > ^D
> > # chmod 644 /dev/sda1
> > #
> >
> > $ bash /dev/sda1
> > test
> > $
> >
> > I executed code on a block device.
>
> Yes, but such execution will never cause a domain transition; you have
> to do that via an execve of the script file, which has to be a regular
> file.

True.  As mentioned above there are two issues related to shells.  One is 
domain_auto_trans(), the other is execution of code from hostile sources.


PS  I was inspired to start this discussion by a report of a real attack on a 
web server that was thwarted by the lack of a compiler, the attack would have 
succeeded otherwise.  Having no compiler installed on web servers is not the 
solution as the hostile code in question could have been written as a shell 
script, in Perl or in Python (which are all required to be installed on Red 
Hat systems and all but Python are required on almost every Linux system).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
