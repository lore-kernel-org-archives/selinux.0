Subject: Re: Problem with semodule mls policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "rcok >> Russell Coker" <rcoker@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44182410.1030003@redhat.com>
References: <44182410.1030003@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 10:01:41 -0500
Message-Id: <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-15 at 09:26 -0500, Daniel J Walsh wrote:
> How do I get semodule to create policy.20 at SystemHigh and everything 
> other files at SystemLow?

Options:
1) As with the devpts problem, if we had range_transitions for object
classes supported by checkpolicy and the kernel, then we could do this
via a range_transition rule, as policy.20 is created in a separate
directory.  Good idea for a kernel enhancement, not a short term option.
2) Modify libsemanage to explicitly set the context on the installed
files based on some configuration.  Using matchpathcon/file_contexts is
a potential concern for bootstrapping, although it can likely be worked
around.  Putting additional entries into semanage.conf, similar to the
existing entry for specifying the file-mode, would be another option.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
