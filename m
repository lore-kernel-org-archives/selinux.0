Subject: Re: After talking to some people at Red Hat, they feal the
	translation library should be plugable
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4325A695.8050802@redhat.com>
References: <4325A695.8050802@redhat.com>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 12:21:58 -0400
Message-Id: <1126542118.2999.153.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 12:02 -0400, Daniel J Walsh wrote:
> Also it should be based off policy.  So this patch to libselinux will 
> use the policy type to find the translation library.  Also libsetrans 
> will now be in /lib/selinux.
> 
> I have modified the libsetrans library to link libtargeted.so.0 and 
> libstrict.so.0 to libsetrans.so.0.   MLS Policy would obviously install 
> their own policy for MITRE Librarie or whatever.

- If we go down this route, we should allow for other per-policy
libraries, and have a /lib/selinux/$SELINUXTYPE directory.  The library
should still be named libsetrans.so.* under it.

- Is there any issue with emulation support, e.g. on x86_64?

- Normally, shared library goes in /lib and symlink goes in /usr/lib,
and dlopen should actually occur on the symlink I would think to avoid
version-specificity?

- Is this preferable to using the alternatives mechanism?

- IMHO, "type" is too overloaded a term (e.g. Type Enforcement types),
so selinux_gettype seems rather ambiguous.  selinux_getpolicytype?

- The usual hidden declarations are needed for the new function as we
don't need to allow interposition on it within the library itself.

> Next step to get MCS will be to change libselinux get_default_context to 
> use pluggable module to get categories for a user.  Should we use same 
> library?
> 
> Currenly MCS policy defaults all users to s0-s0:c0.c127, we need to 
> allow admin to specify users categories.

I thought we were going to introduce a Linux user -> { SELinux user,
<context data> } mapping and deal with the mapping outside of libselinux
entirely, in pam_selinux or wherever appropriate.  So pam_selinux would
perform the lookup and pass the resulting pair to an extended version of
get_default_context, which would generate the final context based on the
inputs and the policy.  The <context data> could include a default role
and a MLS range, but would just be an opaque string as far as
pam_selinux is concerned.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
