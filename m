From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH] newrole suid breakdown
Date: Sat, 7 Oct 2006 05:03:40 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
References: <452432FA.1060009@us.ibm.com> <200610070337.40031.russell@coker.com.au> <1160160879.20202.38.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160160879.20202.38.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610070503.44076.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 07 October 2006 04:54, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Not sure I follow.  Dan just wants to be able to build a single newrole
> binary that correctly handles both cases, and the default install to
> leave newrole non-setuid.

However the default install (being targeted policy) doesn't need newrole.

> > Without even trying I've found six setuid-root programs that are included
> > in a fairly default install of Fedora and which are never needed by the
> > vast majority of users.  I doubt that all six are as well audited as
> > newrole.
>
> Keep in mind that newrole didn't start life as a setuid program, so it
> wasn't written specifically from that perspective.   It was even fairly
> limited wrt SELinux - it couldn't transition you to an arbitrary role
> and domain, only one that you were already authorized for in the kernel
> policy (vs. su, which can serve as the gateway from any uid to any uid).
> The only real power it had was access to the tty/ptys.

Reasonable points.  However when you compare it to rsh and rcp...

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
