Subject: [RFC 0/3] libsepol enforcement hooks for policy server
From: Josh Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Tue, 01 Aug 2006 07:51:40 -0400
Message-Id: <1154433100.23513.7.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an RFC for libsepol enforcement hooks. These patches are to show
the concept and will in no way compile, I've intentionally left out
utility functions so that just the important parts are here to discuss.

The enforcement model has changed quite a bit. Rather than looping over
the policydb inside the policy server as before these hooks will make
calls back into the policy server if a decision is needed. To decide
whether a decision is needed we are essentially doing a semantic diff of
the policies. The enforcer provides the 'other' or previous linked
policy when initializing its hooks. When a callback is encountered
hooks.c will determine if an equivalent rule or symbol is present in the
other policy and if not call the callback. Only strings are passed into
the callbacks.

To accomplish the semantic diff there were significant changes to the
compiler to 1) expand the 'other' policy fully including disabled rules
and symbols (including conflicting rules) and 2) to expand the new
policy fully to do checks but then not add the disabled rules. The
disabled symbols must be added for value mapping but I push the disabled
symbols on to the end of the values so that they can be removed without
holes in the hashtable forming.

A main concern I have about the current patches is that the security_ops
struct is publically accessible by shared users of this library. This is
obviously non-ideal because of abi compatibility. Anyone with better
ideas of how to implement the callback system please speak up :)

This is still very rough around the edges so please look at the concepts
without picking on the style/plain bugs too much :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
