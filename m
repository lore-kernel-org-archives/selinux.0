Date: Thu, 18 Apr 2002 10:54:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Dale Amon <amon@vnl.com>
cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        Russell Coker <russell@coker.com.au>, <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020415160842.GA15960@vnl.com>
Message-ID: <Pine.GSO.4.33.0204181045360.5560-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I wanted to raise a few other issues with regard to this topic and
how/whether it should affect the upstream distribution of SELinux.
At present, our installation procedure doesn't install the policy or file
contexts sources at all, just the compiled policy and the created
persistent label mappings.  If we want to change the upstream
distribution, I have a few questions and concerns aside from the
location in the filesystem hierarchy:

1) When installing the policy and file contexts sources, do we want to
keep them in separate directories as in the distribution (policy,
setfiles), or do we want to merge them together as in Russell Coker's
Debian selinux package?  I'd prefer to keep them separate, especially
since we have now partitioned file contexts into many files as well.
They can live under a common top-level directory, but I'd like to keep
each within its own subdirectory.  Does that seem reasonable?

2) For policy, we can simply copy the policy directory and its Makefile,
and the Makefile targets should work fine after relocation, since the
build and install of checkpolicy is already separated under the 'module'
directory due to its dependencies on the SELinux module.  However, the
setfiles directory contains both the setfiles program sources and the file
contexts configuration, and the Makefile targets build setfiles and
the file_contexts file and then run setfiles on file_contexts.  Hence, at
present, the setfiles program is "private" to the setfiles directory and
is not installed at all.  If we install the file contexts sources, I
would expect us to install the .fc configuration files and a Makefile that
runs an installed setfiles program on them.  This will require something
other than just copying the setfiles directory (i.e. omit the setfiles
program source files and replace the Makefile with a different one),
unless we restructure it within our own distribution to isolate the
program from the configuration (e.g. have separate setfiles and file_contexts
directories, 'make install' in setfiles will build and install the
setfiles program, 'make relabel' in file_contexts will build the file
contexts configuration and run the installed setfiles program on it).
Does the latter change seem reasonable?

3) At present, our installation procedure always builds and installs the
distribution policy and file contexts configurations.  Howard mentioned
always building and installing the local policy, which might be a link
to the example policy or might be a locally-customized policy.  However,
I think we typically want people to merge any customizations into the
distribution policy and install it when upgrading SELinux from the
upstream distribution, as there may be incompatible changes.  At present,
almost everyone uses some kind of locally-customized policy at least to
set up policy/users (and often to enable X support or add new domains), so
if we merely check to see whether they have made _any_ local
customizations, we will almost always use their local policy, which may
not be a good thing.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
