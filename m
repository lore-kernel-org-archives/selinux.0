Subject: Re: passwd, chfn and chsh not reporting AVC's
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4EA01D9D.8050804@redhat.com>
References: <4EA01D9D.8050804@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 Oct 2011 09:42:22 -0400
Message-ID: <1319118142.29287.31.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-10-20 at 09:09 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> In reviewing some bugs on these packages we realize we want to update
> them to use the latest tool chain.  In order to make this easier, we
> want to add a new function called selinux_check_access to libselinux.
> 
> Please review patch.

For those who are interested in more details, this is in reference to:
https://bugzilla.redhat.com/show_bug.cgi?id=518268
and has come up a few times on selinux list as a problem for users due
to the lack of any AVC audit message upon certain userspace permission
checks.  These programs were modified for SELinux before the userspace
AVC existed, and thus directly used security_compute_av().  But even
with the userspace AVC in existence, they would prefer a simpler
interface with fewer discrete calls as they are not long-lived processes
and typically only perform a single permission check.  This is an
attempt to bundle up everything into a single interface similar to
security_compute_av (but with string-based classes and permissions so
that even that lookup is handled internally) that internally uses the
ACV so that we get the benefits of auditing and permissive
mode/permissive domain handling that are not provided by
security_compute_av().  The program still has to call
selinux_set_callback() to set up the logging callback as we don't want
to tightly couple libselinux to libaudit, but otherwise is freed from
any other setup responsibility (avc_open is handled internally on first
use of the interface via __selinux_once magic).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
