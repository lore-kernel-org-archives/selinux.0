Subject: Re: Sepol related questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <1121942551.19675.8.camel@localhost.localdomain>
References: <1121942551.19675.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 09:49:27 -0400
Message-Id: <1122385767.4470.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 06:42 -0400, Ivan Gyurdiev wrote:
> 2) What is the proper fallback user
> mls level and mls range on an mls-enabled system
> when the user hasn't configured those parameters.
> 
> What is the proper fallback mls field,
> in a context where it's missing, on an mls-enabled
> system.

IIUC, there is no planned fallback for the MLS field except for the
kernel's handling of inodes, which is needed to allow seamless upgrade
from non-MLS to MLS.  James has a patch under development to default the
MLS field of existing inodes to the MLS value of the 'file' initial SID,
as defined in policy/initial_sid_contexts, where that value would be set
to system high in a real MLS policy and just s0 in the Red Hat MCS
policy.

> 3) Is the context string as returned by 
> context_struct_to_string (services.c) supposed
> to be null terminated - and also is
> the string passed to sepol_context_to_sid 
> supposed to be null terminated. If so,
> what purpose does the buffer size serve?

Originally, context strings were always nul terminated (and the length
included the nul terminator); the separate length allowed a program to
handle the context completely opaquely if it had no need to interpret it
in any way (not even as a string) and avoided recomputation of the
length, as the constructor of the context always knows that length.
When we migrated to the xattr API and wanted to allow use of the attr
utilities (setfattr/getfattr) for SELinux attributes as well, we ran
into an issue where they do not consider the null terminator as part of
the attribute value for strings, instead just using the length, so we
had to deal with that situation both when setting a context and when
getting a context.  Thus, context_to_sid (both in kernel and in
libsepol) no longer assumes that the input value is nul-terminated, and
getfilecon no longer assumes that the value returned by the kernel (via
the xattr API) is nul-terminated (but it adds the nul terminator before
returning the context to the caller).  So applications can always assume
that the context returned by any libselinux or libsepol function will be
nul terminated.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
