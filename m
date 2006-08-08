Subject: Re: setexeccon vs. setfscreatecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <87u04ncqqq.fsf@rho.meyering.net>
References: <87u04ncqqq.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 11:21:02 -0400
Message-Id: <1155050462.1123.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-08 at 15:16 +0200, Jim Meyering wrote:
> I see that setexeccon sets the context to be used for next execve call.
> And then there's setfscreatecon.  I want something similar that sets
> the fscreate context for the next execve call.  Does such a function exist?
> Is there some other way to do what I want?
> 
> In case you're wondering, here's my motivation: I'm merging some
> coreutils selinux changes into upstream and noticed that they would break
> thread-safety in coreutils' copying engine, src/copy.c -- because they
> introduce calls to setfscreatecon.  From reading the man page for that
> function, I gather that the fscreate-context is a per-process attribute.
> As such (like umask and cwd), changing it affects all threads, and its
> use should be avoided in library-esque code.
> 
> What I would like to do is merge the context-printing and
> context-preserving parts of that patch, but not the context-setting
> parts (--context=CTX in cp, mkdir, mkfifo, mknod, install).  Instead,
> I'm trying to add an option to runcon that would let me also set the
> fscreate context for the process it runs.  Then, all of the individual
> context-setting options would be unnecessary.
> 
> Does this sound reasonable?  Feasible?

At present, the kernel resets the process attributes (exec, fscreate,
and more recent additions like keycreate and sockcreate) upon each
execve so that each program starts life with the default policy
behaviors for its execve and file creation calls, and follows that
behavior unless the program itself explicitly sets the attributes.

With regard to the thread issue, the kernel actually supports per-thread
attributes (per-Linux task), but libselinux doesn't presently access it
in a manner that allows you to leverage it (via /proc/self rather
than /proc/self/task/<tid>).  At present, any child thread will just
fail upon the libselinux calls since it will be viewed by the kernel as
attempting to change the attribute of the thread group leader from a
different thread, and we only allow a thread to change its own
attributes.  libselinux could be changed to use /proc/self/task/<tid>,
at which point the kernel would do the right thing, I think.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
