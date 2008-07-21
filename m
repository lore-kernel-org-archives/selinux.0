From: Paul Moore <paul.moore@hp.com>
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming
Date: Mon, 21 Jul 2008 09:38:31 -0400
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi> <200807210824.40003.paul.moore@hp.com> <Pine.LNX.4.64L.0807211546530.23634@ruuvi.it.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64L.0807211546530.23634@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807210938.31144.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 21 July 2008 9:08:16 am Vesa-Matti J Kari wrote:
> Hello,
>
> On Mon, 21 Jul 2008, Paul Moore wrote:
> > The kernel is a very large piece of code, which is developed and
> > maintained by literally thousands of people.  While there are rules
> > and guidelines to help maintain consistency there will _always_ be
> > inconsistent style in the Linux Kernel.
>
> Sure. But is that really a valid argument to block the changes that
> attempt to bring *at least some* unity to the code?

I obviously thought so which is why I voted "NO".  Not all change is 
good, even if the intentions are correct.  All change brings risk and 
if there is not an advantage to offset that risk then all you are doing 
is adding risk into the system.  Risk of runtime bugs, risk of 
merging/porting bugs, etc.

I don't have a problem with fixing significant style problems in the 
code; I agreed with Eric's massive whitespace cleanup earlier this year 
and I think your patch to convert to '\0' NULL terminators is a good 
one.  However, I do draw the line at patches that only rename 
variables, especially the conversion of 'idx' to 'i'.

> I mean, what you are saying is analogous to the argument, "the world
> peace can never be achieved, therefore we should not bother to settle
> local issues either".

Please stick to the argument at hand and not some overblown analogue.

> I certainly don't intend to wade through the entire kernel. I just
> want to make some changes to one particular subsystem that I am
> interested in (SELinux), to make the reading experience more
> enjoyable to me and others, and, hopefully, to somewhat improve the
> code.

A few thoughts: others did not object to those variable names when the 
patches were proposed, or at any point prior to this thread, and no one 
besides you and I has commented on this thread.  This is a sign to me 
that the 'idx' variable name is not a significant distraction to the 
community.

Another thought, if you want to help improve the code, especially 
SELinux, I would encourage you to look at the ToDo lists:

 * http://www.selinuxproject.org/page/Kernel_Development#To_Do_List
 * http://www.selinuxproject.org/page/Userspace_Development

... and attempt to work on one of the issues on those lists.  I would be 
more than happy to help if you get stuck and need a hand.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
