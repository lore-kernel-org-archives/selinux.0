Subject: Re: Proposed patch for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41796C01.4060909@redhat.com>
References: <41782BBA.9090101@redhat.com>
	 <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041022155639.GA4986@lkcl.net>  <41796C01.4060909@redhat.com>
Content-Type: text/plain
Message-Id: <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 25 Oct 2004 10:52:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Let's step back for a moment from the implementation details and talk
about the concept/usage of this customized flag for SELinux attributes.

The file_contexts configuration and setfiles were only intended to
initialize the system, as previously noted.  After installation, one
should only do a make relabel upon a major policy upgrade, and even in
that case, it would be better to selectively relabel based on the
differences between the policies.  At runtime, the file attributes will
be set based on policy and in some cases refined by application and/or
user knowledge subject to policy (setfscreatecon(3) or setfilecon(3)),
reflecting the actual security properties of the objects.

At any given time, you can find all files that are no longer consistent
with the file_contexts configuration via setfiles -nv.  You don't need a
separate file attribute for that purpose, and the proposed flags
attribute will only show files relabeled via chcon(1).  Why should we
treat such files differently than a file whose security context was set
by any other application using setfilecon(3) or created after an
explicit setfscreatecon(3) or even created in accordance with a file
type transition rule?  Typically, we don't want any of those files to be
relabeled by a subsequent make relabel; we would only want them
relabeled if there was a policy bug or application bug that had allowed
those files to become mis-labeled in the first place at runtime, or if
there has been a change in policy that affects those files/types.

I'm inclined more towards the idea of alternatives in the file_contexts
configuration, e.g. you specify a "primary" security context to be
applied upon initialization, and you optionally specify alternatives
(either individually or via equivalence classes) that are equally
permissible.  setfiles then defaults to applying the primary context,
but will allow the file to remain unchanged if it has been set to any of
the alternatives.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
