Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KK4QXT010281
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 16:04:26 -0400
Received: by qcblr10 with SMTP id lr10so28514875qcb.0
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 13:04:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>, sds@tycho.nsa.gov
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
Date: Wed, 20 May 2015 16:04:21 -0400
Message-ID: <1684020.b5Ioztp7mc@sifl>
In-Reply-To: <1428616130-14570-1-git-send-email-jeffv@google.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

First off, my apologies for such a long delay in providing feedback.  The 
delay wasn't due to any fault of yours, rather just a backlog on my todo list.

Comments below ...

On Thursday, April 09, 2015 02:48:50 PM Jeff Vander Stoep wrote:
> ---- motivation ----
> Ioctls provide many of the operations necessary for device control. The
> typical driver supports a device specific set of operations accessible by
> the ioctl system call and specified by the command argument. SELinux
> provides per operation access control to many system operations e.g. chown,
> kill, setuid, ipc_lock, etc. Ioclts on the other hand are granted on a per
> file descriptor basis using the ioctl permission, meaning that the set of
> operations provided by the driver are granted on an all-or-nothing basis.

...

> ---- Design constraints ----
> Policy: Support existing policy, targeted whitelisting. The ioctls commands
> used on a system may not be completely known to a sysadmin/policywriter. It
> is not reasonable to enforce that all needed commands be known in order to
> use this feature in a targeted manner. Existing policy using the ioctl
> permission will continue to work as-is. Policy targeting a specific
> source/target/class will only be enforced on that particular
> source/target/class. E.g. continue to allow init to access all ioctls
> provided by a driver, but only allow the browser to access a subset.
> 
> Performance: Many ioctl calls are performance sensitive, and some ioctls
> have a large command set (e.g. sockets support hundreds of commands).
> Execution time on a filtered ioctl should be similar to execution time on
> an unfiltered one and not related to the number of commands being filtered.
> Performance numbers will be included in a separate document.
> 
> Command space: The ioctl command is a 32 bit number comprised of four
> fields, number - sequence number of the command. 8 bits
> type - magic number assigned to the driver. 8 bits
> size - size of the user data involved. typically 14 bits (arch dependent)
> direction - The direction of data transfer. typically 2 bits (arch
> dependent) The command is uniquely identified by the type and number, size
> and direction are considered to be arguments and are not considered for
> SELinux whitelisting.
> 
> ---- Policy format ----
> allow <source> <target>:<class> { 0x8910-0x8926 0x892A-0x8935 }
> auditallow <source> <target>:<class> 0x892A

I agree with only specifying the lower 16 bits (command,type) when specifying 
the individual ioctls, I even like the '-' shortcut, but I'm a little 
concerned about specifying a number directly in the permission field without 
any sort of qualifier.  Specifically I'm worried that it hurts the readability 
of the policy and could pose problems with future work.

I'd be much happier if we could add some sort of syntax which would qualify 
the numbers as ioctls, for example:

  allow <source> <target>:<class> { ioctl(0x8910-0x8926) ioctl(0x892A) }

The above is just an example, if you have a better idea for the syntax I'm 
open to suggestions.

> ---- Architecture ----
> policy: Ioctl operations include allow, auditallow and dontaudit
> permissions.
> 
> binary policy/avtab: Like AVC permissions, ioctl operations permissions are
> represented by set/cleared bits. Each ioctl operation avtab entry represents
> a single ioctl command type (using “type” as defined above in the “command
> space” section) and includes permissions for the 256 operations within that
> type ...

I like the work you did expanding the policy/AVC, especially since it is 
rather generic.  Sure, there are some ioctl specific quirks, e.g. the 
type/number handling, but in general, the "operations" concept could be used 
for any number of things where the existing 32 choices are too limiting.  The 
netfilter command handling is one such example.

While what you've submitted here is just fine for ioctl handling, I'd like to 
see us tweak things a bit, and move around some of the ioctl specific quirks, 
so that we can leverage some of the underlying avtab and avc code for future 
expansion (if/when we get there).

The unfortunate side effect of doing your job too well is that I ask you to do 
more ;)

> AVC: A pointer to an operations structure has been added to the avc_node
> such that general avc_lookup also returns the allowed ioctl operations.

More on this when I send my comments on the patches themselves, but I found 
the term "operations" a bit ... misleading?  Overly generic?  Odd considering 
my desire to make this more generic, I know.

How about "extops" or something similar?  I would much prefer struct/type 
names and function names that help indicate that it relates to the extended 
permissions/operations and not the original 32 permissions; "operations" 
doesn't in my mind, but "extops" or something similar helps.  Once again, if 
you have a better idea I'm open to suggestions.

Nitpicky, I know ...

> The structure flags the ioctl types that are allowed and only looks up the
> permissions within that type from the avtab when they are first used. After
> the initial lookup of a type it is added to a list of types that are
> allowed for the source/target/class being retrieved.

More on this in the individual patch comments.  I have no argument with your 
logic from an ioctl perspective, I'd just like to see some slight changes so 
we can recycle your work later.

-- 
paul moore
www.paul-moore.com
