Date: Wed, 24 Apr 2002 08:36:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Reino Wallin <reino@oribium.com>
cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux <SELinux@tycho.nsa.gov>
Subject: RE: SELinux RPM Version
In-Reply-To: <1019593521.4289.28.camel@matilda.oribium.com>
Message-ID: <Pine.GSO.4.33.0204240834440.17117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 23 Apr 2002, Reino Wallin wrote:

> OK. Would then /usr/share/doc/selinux/examples/policy/firewall and
> /usr/share/doc/selinux/examples/setfiles/firewall be correct paths for
> the firewall policy and its file_contexts?

The file contexts configuration has been moved under the policy directory,
within a subdirectory named file_contexts, and the Makefile rules for the
policy and relabeling have been merged into a single policy/Makefile.  The
setfiles directory in the source tree now only contains the setfiles
program sources along with a Makefile to build and install the
setfiles program when SELinux is installed, and this step occurs prior to
running 'make relabel' in the policy directory.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
