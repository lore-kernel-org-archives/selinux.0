Date: Tue, 29 Jan 2002 11:48:53 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Paul Krumviede <pwk@acm.org>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: file labeling (was Re: applications and ports)
In-Reply-To: <95876102.1012292319@localhost>
Message-ID: <Pine.GSO.4.33.0201291132000.11892-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 Jan 2002, Paul Krumviede wrote:

> i would emphasize this last sentence, as i've confused myself by
> failing to track manually labeled files in file_contexts only to have
> policy changes fail to work unexpectedly after i'd relabel the
> file system.

It might be nice to have a tool that traverses the filesystem, compares
the file labels with the existing file_contexts configuration, and
generates an updated file_contexts based on the current state.  This could
be implemented as an option to the existing setfiles program.

At present, you could generate a complete mapping of the current state
using the modified ls or find programs, but that would lack the
conciseness and generality of the file_contexts configuration.


> as an aside, the default install for file-utils in the latest release
> doesn't seem to install the chcon man page, so i didn't find
> the option to not dereference symbolic links for a bit.

Sorry.  As a side note, the --help option often works.  Also, there are
the simple chsid and lchsid test programs.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
