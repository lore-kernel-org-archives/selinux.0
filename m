Subject: Re: how to cope with file renames?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20100311182826.GF24034@myhost.felk.cvut.cz>
References: <20100311182826.GF24034@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Thu, 11 Mar 2010 14:08:31 -0500
Message-Id: <1268334511.16780.93.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-11 at 19:28 +0100, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > SELinux isn't name-based. 
> 
> This is not so much about names but about relationship to the parent
> container. I don't care if the file is called foo or bar, but if its
> parent dir has foo_t or bar_t context. There already is some coupling
> between the file and its directory. For example, to actually do the
> rename you need file as well as directory permissions.
> 
> So in that regard, why an additional type transition in that operation
> would be harmful?

Type transitions take place when new subjects or objects are created,
not during their existence.  What you want is relabeling /
non-tranquility, and that is something to be minimized, carefully
controlled, and explicitly identified in the system, not an implicit
side effect of another operation.

> > rename() doesn't change your file mode or ACLs either.
> 
> Yes, that's why I said it's an old problem. I hoped that someone would
> have solved it in a systemic way.

Some of us view it as correct behavior, not as a problem.  In any event,
"solving it" in the kernel would require cooperation from the filesystem
code in order to provide an atomic rename+setxattr operation, just as we
required filesystem cooperation to provide an atomic create+setxattr
operation.  So it goes well beyond the scope of the SELinux code.

> 
> Daniel J Walsh wrote:
> > Just need to walk the tree adding watches for ever directory and any
> > time a a new directory shows up you would add it to the watch list.
> > I am not sure how much inotify can handle.  We might get in trouble
> > with the amount of resoures used.
> 
> See the -r in man inotifywait (http://linux.die.net/man/1/inotifywait).
> Actually you can use that tool and restorecon in a simple shell script
> to make a restorecond of your own. But having this in hand, you don't
> need neither inheritance nor type transitions for files. You could just
> make any new file with default_t and wait until restorecon labels it.

The Warning section on that option is a bit worrisome.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
