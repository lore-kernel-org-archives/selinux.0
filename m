Message-ID: <4526CC7A.8040403@us.ibm.com>
Date: Fri, 06 Oct 2006 16:36:58 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com>	 <200610060915.15441.russell@coker.com.au> <45268BD9.9050809@redhat.com>	 <200610070337.40031.russell@coker.com.au> <1160160879.20202.38.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160160879.20202.38.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2006-10-07 at 03:37 +1000, Russell Coker wrote:
>> Without even trying I've found six setuid-root programs that are included in a 
>> fairly default install of Fedora and which are never needed by the vast 
>> majority of users.  I doubt that all six are as well audited as newrole.
> 
> Keep in mind that newrole didn't start life as a setuid program, so it
> wasn't written specifically from that perspective.   It was even fairly
> limited wrt SELinux - it couldn't transition you to an arbitrary role
> and domain, only one that you were already authorized for in the kernel
> policy (vs. su, which can serve as the gateway from any uid to any uid).
> The only real power it had was access to the tty/ptys.

I have a patch (its really big, so I'll try to break it down into 
meaningful chunks) that basically restructures newrole in a more 
maintainable, and paranoid, way. If I can't break it down easily, would 
you (the reader) be ok with reading a ~1600 line patch? Like I said, 
I'll try to break it down, but the changes are very wide sweeping, and 
hopefully a large improvement of what was there.

Based on all of the previous discussion wrt checking the capabilities, 
if this is still desired, I can change the behavior to be:

call_do_priv_action
{
   if !(have_right_capabilities)
     return 0 (flag success, even though its not done anything)
   /* if we do have caps, then do actions and expect them to work */
   ...
}

That acceptable? (And is it even needed anymore due to new package?)

Mike




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
