Subject: Re: dumb newbie questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119280879.30000.48.camel@rodan.ncc.com>
References: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
	 <1119137931.11593.53.camel@rodan.ncc.com>
	 <a1025d74050620061231e65d7d@mail.gmail.com>
	 <1119280879.30000.48.camel@rodan.ncc.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 12:20:41 -0400
Message-Id: <1119284441.24129.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-20 at 10:21 -0500, R. Steven Rainwater wrote:
> Actually, the script is one that I run from a terminal to manually
> perform certain types of maintenance on the website. It's designed to be
> called remotely through Apache or run from the command line, in which
> case it spits out status messages to stdout. That's why I wrote the
> one-liner "hello world" test script to track down the problem. Shouldn't
> the root user be able to run a script that writes to stdout?

The question is whether the script should be allowed to write to a local
pty on the server.  Naturally, you don't want that happening when it is
run by apache.  It is possible to configure policy such that the script
runs with a different set of permissions when run directly by a user
than when run by apache, but that then makes it harder to performing
testing and debugging of the script by a user under the same conditions
(policy) as when it is run by apache.

> This is totally bizarre - why would the directory location affect it? Is
> this normal or a bug in my setup? Is there a way to tell selinux that a
> user (or root) should be able to run a Perl script that uses stdout
> regardless of it's physical location? A rule like that might fix me up.
> Failing that, is there an easy way to get a list of directories where
> selinux won't allow programs using stdout to run?

SELinux doesn't care about stdout; it care about what objects you can
access.  In this case, it is preventing the script from accessing a
local pty on the server, for good reason.  But if stdout referred to a
pipe back to the apache daemon or to a socket back to the client, then
it would presumably allow the script to access it.

> Yes, this was already working in most cases. The above discovery looks
> to be the source of my problems. If I can't figure out how to fix it, I
> could move copies of the non-working scripts to a directory where
> they'll run. Or maybe use symlinks if selinux allows it. One copy in the
> /var/www tree to be run by Apache and one copy somewhere else to be run
> locally when needed. Yuck.

As noted, you can configure policy to run the script in a different
domain depending on the caller.  Or you can use runcon to force it to
run in a particular domain, e.g. runcon `id -Z` -- /path/to/script.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
