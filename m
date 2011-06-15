Subject: Re: /etc/selinux/$P/users/local.users and system.users are they
 deprecated?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BANLkTikdwRevmnuj7Lw6Vtv=d-iFHd45Yg@mail.gmail.com>
References: <BANLkTikdwRevmnuj7Lw6Vtv=d-iFHd45Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Jun 2011 09:40:55 -0400
Message-ID: <1308145255.30526.50.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-06-14 at 10:36 -0700, Sam Gandhi wrote:
> Hello Dear Experts,
> 
> First in my environment I am not allowed to ship python, so I can't
> use wonderful tool semanage.
> 
> I admit that I am bit  confused (&intimidated) by so many files to
> manage that constitutes SELinux configuration.
> 
> Are files /etc/selinux/$P/users/local.users & system.users required
> for proper functioning of SELinux user-space libraries? Or user/roles
> defined in policy definitions sufficient?

They are not required; you can just define users in policy.  They were
an early attempt (Fedora < 5, RHEL 4) to support local customization of
users without requiring policy sources or the policy compiler on the end
systems.  They predate seusers and libsemanage, which became the
preferred approach in Fedora >= 5 and RHEL >= 5.

> I looked at the latest libselinux code it still has code to use
> local.users but didn't see code that actually uses system.users,  Aksi
> reference policy make install also installs these files.

Yes, it appears that system.users support was dropped long ago.
I think local.users support was retained for compatibility with RHEL4,
but isn't used by default.  You can ensure that it never gets used even
if present by setting SETLOCALDEFS=0 in /etc/selinux/config, but it
won't be used anyway unless a local.users file exists.

> However in the the mailing list I have seen references back in
> 2005/2006 that these files are deprecated? The latest pdf file that
> was mailed out recently also has reference to local.users but not to
> system.users.
> 
> If system.users file is still valid which definition then takes the
> precedence and doesn't this expose a security hole that someone can
> change user role after the policy was generated?

Just a matter of ensuring that you protect the integrity of the
system.users file to the same degree that you protect the kernel policy
file. A similar case exists today with the seusers file, which maps
Linux users to SELinux users and ranges.  Realistically, you have to
protect the integrity of everything under /etc/selinux.

> In my policy definitions I am defining a new user diags_u, type
> diags_t and role diags_r, essentially following statements in
> policy.conf (through macros etc)
> 
> type diags_t, domain, userdomain, unpriv_userdomain, nscd_client_domain, privfd;
> role diags_r types diags_t;
> user diags_u roles { diags_r };
> 
> Is that sufficient?  fwiw, I have been able to transition to
> diags_u:diags_r:diags_t context using the newrole command, when using
> policy that contains above statements.

That's fine for defining the domain, role, and user for the kernel.
If you want the new role to work seamlessly with userspace though, you
should also update the default_type file (specifies the default domain
type for each role, used by newrole) and the default_contexts file
(specifies the set of legal role:domain pairs for user sessions created
by various login programs and their precedence).

We have previously discussed simplifying those userspace configuration
files and the userspace logic for determining the default context for a
user session; see the list archives.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
