Subject: Re: dumb newbie questions
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <a1025d74050620061231e65d7d@mail.gmail.com>
References: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
	 <1119137931.11593.53.camel@rodan.ncc.com>
	 <a1025d74050620061231e65d7d@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1119280879.30000.48.camel@rodan.ncc.com>
Mime-Version: 1.0
Date: Mon, 20 Jun 2005 10:21:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your comments, Trevor. I think you've helped me stumble into
the answer (or at least into the right questions).

On Mon, 2005-06-20 at 08:12, Trevor Vaughan wrote:
> Basically, it looks like you have a PERL script running
> from within the Apache context (i.e. run by Apache) and
> the script is attempting to write to a character device

Actually, the script is one that I run from a terminal to manually
perform certain types of maintenance on the website. It's designed to be
called remotely through Apache or run from the command line, in which
case it spits out status messages to stdout. That's why I wrote the
one-liner "hello world" test script to track down the problem. Shouldn't
the root user be able to run a script that writes to stdout? 

> 1. Run the script from your home directory as a
> normal user. (This should work).

Wow, amazingly, it did. I moved the script to my home directory changed
the owner to me, ran it, and it printed "hello world" with no errors. I
changed the owner back to root and ran it from my home directory - it
still works. Looks like the owner setting doesn't make any difference. I
moved the script back to within the /var/www area where it normally
lives and I could no longer run it as myself or as root.

This is totally bizarre - why would the directory location affect it? Is
this normal or a bug in my setup? Is there a way to tell selinux that a
user (or root) should be able to run a Perl script that uses stdout
regardless of it's physical location? A rule like that might fix me up.
Failing that, is there an easy way to get a list of directories where
selinux won't allow programs using stdout to run?

Not to complain but if selinux breaks (fixes?) something as universal as
the ability of a program to use stdout, there should be a big red
warning label in the docs, saying "Look out! Programs that use stdout
will not work unless you put them in certain directories!" But that's
just me...

> 2. Write a PERL script, to be run from within Apache,
> that writes a file that is inside the web directory

Yes, this was already working in most cases. The above discovery looks
to be the source of my problems. If I can't figure out how to fix it, I
could move copies of the non-working scripts to a directory where
they'll run. Or maybe use symlinks if selinux allows it. One copy in the
/var/www tree to be run by Apache and one copy somewhere else to be run
locally when needed. Yuck. 

> Also, are you running in strict or targeted mode? 

My /etc/selinux/config file says:

SELINUX=enforcing
SELINUX=targeted

Just for kicks I tried setting it to SELINUX=disabled and rebooted.
There was no discernable difference in speed. Valdis indicated the error
messages should die down after a few days, so maybe permissive is the
way to go. I'll keep beating on it today and maybe I can get things
working with selinux. If not, I can use permissive as Plan B.

-Steve



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
