Subject: [RFC] Checking the loaded policy against a policy on disk
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Steve G <linux_4ever@yahoo.com>,
   SELinux-dev@tresys.com, James Morris <jmorris@namei.org>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 08:32:17 -0400
Message-Id: <1124454737.32663.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

For the LSPP work, it has been requested that we provide a way to
perform a consistency check between the policy in memory and the policy
on disk.  We could change the SELinux module to compute a checksum over
the binary policy image when it is loaded and to export that checksum
via a new selinuxfs node.  One complicating factor is that at
present, /sbin/init and load_policy mutate the binary policy image in
memory prior to loading it in order to customize the vendor-shipped
policy with local boolean settings and user definitions, so the
checksums would not match at present for the on-disk file and the
in-memory image unless the verification tool applies the same transforms
prior to computing the checksums.  Tresys has previously suggested
shifting to a model where we regenerate the on-disk policy file for each
change to any local setting, with the generated policy file to be loaded
into the kernel stored separately from the policy file managed by rpm to
avoid creating problems for updates, which would eliminate that problem
altogether.

Any comments on this request?  Any particular preference as to the
particular checksum algorithm?  Does the algorithm need to be
configurable?

A related idea would be to also extend the binary policy format to
include a field for an arbitrary text string label that could be set
when the policy is generated, and have the kernel save that string and
export it via another new selinuxfs node.  This would allow an
identifier string to be associated with the policy image, such as the
policy package's name and version (e.g.
selinux-policy-targeted-1.17.25-3), and extracted later by userspace to
determine which particular policy the one in memory is supposed to
match.  This wouldn't replace the need for the checksum, but would
provide additional information that might be helpful to userspace.
However, this change would require a change in binary policy format,
unlike the first change.  

Any comments on this related idea?
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
