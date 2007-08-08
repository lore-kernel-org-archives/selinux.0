Subject: Re: A QUESTION FROM SUN VALLEY, CA
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Robert Adams <whatifwe@ix.netcom.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <000001c7d9ea$5e28b810$6501a8c0@INCA>
References: <000001c7d9ea$5e28b810$6501a8c0@INCA>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 15:14:21 -0400
Message-Id: <1186600461.6916.333.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-08 at 11:31 -0700, Robert Adams wrote:
> Hello
> 
>  
> 
> Some time ago, you informed me that resultant SELinux operating system
> would be subjected to a Common Criteria Test by Red Hat.

First, to clarify, SELinux is just an implementation of flexible MAC for
Linux, not its own distinct operating system, and SELinux by itself has
not and will not be evaluated - one would evaluate a complete system
that might include SELinux.  Products that incorporate SELinux have
undergone evaluation, see http://niap-ccevs.org for information on
validated products and products in evaluation.  It is those products
that are evaluated/validated, not SELinux per se, although the product's
evaluation may have included coverage of the SELinux functionality.

> The concept of open-source provides the user access to the source code
> for purposes of correcting errors and making needed modifications.
> 
>  
> 
> Isn't the concept of open-source and the common criteria test somewhat
> inconsistent?  Is the certification provided by common-criteria
> nullified when the user makes a change to the SELinux operating
> system?

The certification is invalidated if a security-relevant change is made,
yes, although there is a process for maintaining a certificate as
changes are made, e.g. for updates.

The user is still free to make modifications, but unsurprisingly the
modified result is not covered by a prior certification.  That's no
different than the fact that a user is free to make modifications but
doing so may invalidate his warranty/support agreement with the Linux
vendor and may invalidate certification by ISVs that their applications
will run on the system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
