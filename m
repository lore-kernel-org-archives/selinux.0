Subject: Re: Fixfiles "undocumented feature"
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Mike Perry <mikepery@fscked.org>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <20040520174646.GA17614@fscked.org>
References: <20040520174646.GA17614@fscked.org>
Content-Type: text/plain
Message-Id: <1085143704.2789.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 May 2004 08:48:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 13:46, Mike Perry wrote:
> I'm running FC2's SELinux (w/ policycoreutils-1.11-2) and I've noticed
> that 'fixfiles relabel' has the rather annoying property (I'd call it a
> bug) of erasing *all* of /tmp. Is this necessary? It kills screen
> sessions, X11 sockets, ssh agents, esd, gconf locks, gnome IPC, and
> all sorts of other important things that make running systems not want
> to run very well anymore. 

As I recall, Dan or Russell added the purging of /tmp to avoid problems
with the types on entries such as /tmp/orbit*, /tmp/.ICE-unix,
/tmp/.X11-unix, etc by removing them upon an initial relabeling. The
files will then be re-created in the right type automatically due to
file type transition rules based on the creating domain. 
fixfiles/setfiles has no easy way to determine the right type for any
pre-existing files there.  Dan or Russell then added another target
(fixfiles restore) as an alternative that doesn't purge /tmp.

> At the very least, some sort of warning in the manpage would be nice.

Yes, I agree with that.  And perhaps the purging should be an option,
e.g. fixfiles -p relabel to purge /tmp and relabel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
