Subject: Re: regarding privilege granting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <20070625162622.42210.qmail@web51503.mail.re2.yahoo.com>
References: <20070625162622.42210.qmail@web51503.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 13:03:11 -0400
Message-Id: <1182790991.5636.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-25 at 09:26 -0700, Steve G wrote:
> >I'm pretty surprised that you are making the argument that these method
> >of granting capabilities is harder to analyze. SELinux allows you to
> >understand exactly what domains have the capabilities in exactly which
> >situations. Since executable code is tightly bound to the domains
> >already finding executables that can run with additional capabilities it
> >not hard.
> 
> OK, what would I type at the command line to get the list of all apps with
> elevated privileges? I already showed you the 1 line in bash that finds all
> programs with elevated privileges today.

Doesn't exist today, but not hard to do as an extension to sesearch I
would think - search policy for all allow rules on cap_override class,
then find the entrypoint types for those domains, then feed that list of
types to a find command.

The fact that we don't have a one-line command line to do it today is
hardly surprising given that the kernel functionality is only just being
proposed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
