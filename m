Subject: Re: Unable to disable SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Cocker <paul.cocker@tntpost.co.uk>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk>
References: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk>
Content-Type: text/plain
Date: Fri, 13 Mar 2009 08:42:39 -0400
Message-Id: <1236948159.9747.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-03-13 at 12:25 +0000, Paul Cocker wrote:
> Running SELinux on a CentOS 5.2 box, Im trying to temporarily disable
> SELinux via one of the following methods:
>  
> 1. sudo echo 0 > /selinux/enforce

Typically one would run the setenforce 0 command, but that is equivalent
to what you are doing above.

> 2. sudo vim /selinux/enforce
>  
> The first comes back with
>  
> -bash: /selinux/enforce: Permission denied

This means that your SELinux policy prevented you from changing the
enforcing status.  What context are you operating in (id -Z)?  What
context is sudo running the command in (sudo id -Z)?

> The second comes back with
>  
> Could not set security context for /home/paulc/enforcz~
>  
> Could not set security context for /home/paulc/enforcz~
> "enforce" E667: Fsync failed
> Press ENTER or type command to continue

/selinux/enforce isn't a real file; it is a pseudo file exported by the
kernel as an interface.  So you shouldn't be editing it.  In this case,
vi is complaining because it is trying to preserve the context of the
original pseudo file on its backup copy, and that context isn't valid
for a file on a real filesystem.

> I believe the first method has worked for me before, but it's possible I
> have made changes since then. It was some time ago. What's the cause of
> this issue?

It's a policy denial - SELinux is preventing whatever context you are
running in from switching the enforcing status.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
