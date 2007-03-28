From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy applet)
Date: Thu, 29 Mar 2007 01:11:41 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp> <200703282026.41228.russell@coker.com.au> <1175083582.3864.446.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1175083582.3864.446.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200703290011.54801.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 28 March 2007 22:06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > For such things TOMOYO might be a good option.  SE Linux is designed for
> > general purpose computers.  When you get down to an embedded device with
> > 4M of RAM and 8M of flash that only runs three or four programs then
> > TOMOYO may have an advantage.
>
> SELinux (like Linux) should scale across the full range.  If it doesn't
> presently, we should work to make it so.

For the smallest possible resource use on a machine that performs a limited 
number of tasks the best way to develop the policy is to test all permitted 
actions and then develop a policy that allows nothing else.

It would be quite possible to do this with SE Linux, however it would require 
at a minimum a separate executable for each task that is performed.

TOMOYO changes security context based on executing a path name and therefore 
you could have the program that is the main purpose of an embedded device as 
a busybox module and have only one executable in the system.

But I think that the real issue will be how long it takes for the minimum 
embedded system to become equal to my iPaQ's.  I believe that I have 
demonstrated that my iPaQ's (32M of flash and 64M of RAM) are more than 
adequate to run SE Linux, when such systems are shipped on a single chip the 
need for optimisation to smaller hardware will be removed.  I don't think 
that we have long to wait.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
