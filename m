Subject: Re: Creating new types
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Cocker <paul.cocker@tntpost.co.uk>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <DAE2574A7F44F44ABE07381C36213DFA05BC3349@exch.cdltd.co.uk>
References: <DAE2574A7F44F44ABE07381C36213DFA05BC3349@exch.cdltd.co.uk>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 11:26:51 -0400
Message-Id: <1224257211.19562.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-17 at 15:34 +0100, Paul Cocker wrote:
> Today is my first day of working with SELinux (so forgive any
> terminology mixups), newly discovered after it blocked a disclaimer
> script I was using in conjunction with altermime to attach text to
> e-mail being processed by postfix.
> 
> Anyway, having been pointed at a very helpful HOWTO on the CentOS pages
> I was able to work through the first few flagged issues. But now I've
> run into one I want a different solution for than "add more permissions
> to existing type".
> 
> One of the elements of the script is writing to /var/spool/filter, a
> directory used for no other purpose. I believe it wishes to create
> subfolders, something SELinux is not allowing under the CentOS 5.2 type
> var_spool_t. I tried changing the type to postfix_spool_t, but this had
> the same problem.
> 
> Rather than setup a module which grants permissions that postfix_spool_t
> doesn't need, I'd like to setup a new type and assign it to this
> directory. Problem is, I haven't been able to find documentation on how
> to do this, so I'm hoping someone can point me in the right direction.

What avc messages are you getting?

Adding a type is easy enough,
policy_module(filtertype, 1.0)

type filter_spool_t;
files_type(filter_spool_t)

but making sure it is accessible to all the right domains may be another
matter.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
