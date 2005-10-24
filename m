Subject: [PATCH 0/4] features/fixes for rawhide and refpolicy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 12:58:57 -0400
Message-Id: <1130173137.15661.26.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset is several small/medium feature additions and bug fixes. These are mostly for integration with rawhide and have been minimally tested.

The Feature changes are:
- new sectioned package file format
- semodule -R will reload the policy, without changing it
- semodule -n will not reload the policy after a commit
- semodule -s <policytype> will do the requested operation on the
specified store
- libsemanage will not reload the policy if you are operating on a
different store than the active (as specified by selinux config)
- libsemanage now separates the context templates from the normal
file_contexts at link time
- libsemanage now calls genhomedircon after a commit
- semanage.conf has been moved to /etc/selinux

Bug fixes:
- fixes some NULL dereferences in the expander
- uses O_TRUNC when copying any file
- remove unsupported store type 'source'
- fix invalid free in dismod

NOTE: this will not read packages created with prior libsepols, you should clear out old modules before using this.

semodule_package still needs to be changed to accept arguments, I'll do that soon. 

Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
