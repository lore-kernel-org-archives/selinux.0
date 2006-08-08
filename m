Subject: Re: setexeccon vs. setfscreatecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <87ejvrcj9i.fsf@rho.meyering.net>
References: <87u04ncqqq.fsf@rho.meyering.net>
	 <1155050462.1123.36.camel@moss-spartans.epoch.ncsc.mil>
	 <87ejvrcj9i.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 12:46:01 -0400
Message-Id: <1155055561.1123.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-08 at 17:57 +0200, Jim Meyering wrote:
> Thanks for the quick reply!
> 
> What you're saying seems to be at odds with setexeccon.1
> as well as with this demonstration (using 2.6.17-1.2462.fc6):
> 
>     $ id -Z
>     user_u:system_r:unconfined_t
>     $ runcon -r object_r -- ./id -Z
>     user_u:object_r:unconfined_t
> 
> since runcon's call to setexeccon does what the man page says it does
> (set exec context for subsequent execve call) and changes the role from
> system_r to object_r.  Does that mean this behavior is Red Hat/Fedora-
> specific?

No, it just means I didn't explain adequately ;)

When a task sets its exec context to a particular value, then that
context is applied to the transformed task as its current context upon
its next execve call rather than using the default policy-defined
transition (assuming that the caller is permitted by policy to
transition to the new context and the new context is permitted by policy
to use the new program as its entrypoint).  But the exec context itself
is reset by that execve, and is not applied to any execve calls made by
the new program / transformed task.  Those execve calls will then follow
the default behavior, which will either be to perform a policy-defined
transition or remain in the same context if no transition is defined.
So it might even look like the exec context is being propagated just due
to the latter inheritance of current context in the absence of a
transition, but it isn't.  Really.  Honest ;)

> Is there any hope that I could get an interface to allow something
> similar with respect to the fscreate context?
> With such a function, it would be trivial to set the context of
> files created by an arbitrary program: simply run it via e.g.,
> 
>   runcon --fs-create-context=FS_CREATE_CONTEXT -- EXEC_CONTEXT PROGRAM ARG...
> 
> Without it, most file-creating programs will have to be modified
> (manually and tediously) to accept a new option allowing the user to
> select an fs-create context.

In the case where the new program is running in a different context than
the caller, we definitely want to reset the attributes to prevent the
program from being maliciously influenced by the caller.  Otherwise, the
caller could try to trick the new program into creating files in a
context of its choosing rather than the policy defaults in order to gain
unauthorized access to the data.  In the case where the new program is
running in the same context as the caller, the issue is less clear, but
it seemed simpler for programs to always know that they start life
operating with the policy-defined behavior and that their initial
attribute state is always cleared and only they can set it.  I'd be
uneasy about breaking that assumption now.

> > With regard to the thread issue, the kernel actually supports per-thread
> > attributes (per-Linux task), but libselinux doesn't presently access it
> 
> I've heard of the Linux option to convert normally-per-process attributes
> into per-task ones.  However that seems like an overly large stick to
> shake at this problem.  Isn't it onerous, and even dangerous, for a
> library to require that a multi-threaded application flip that switch
> in Linux?  Some other library used by the application could assume
> certain attributes are per-process.

There is no switch for credentials; uids/gids and security contexts are
all per-task in Linux and not shareable even via clone.  There have been
various patches bandied about on linux-kernel over the years to permit
sharing, but nothing has been adopted.  The kernel keyring support might
actually be a step in that direction.

I think that changing libselinux to
read/write /proc/self/task/<tid>/attr/xxx would be fairly
straightforward, and the existing kernel would just work (i.e let you
set and get the per-thread state that already exists).  When we
originally wrote the libselinux functions, /proc/self/task didn't exist
and /proc/self was a reference to the per-thread state, but they
switched that on us early in 2.6, and we never had a real requirement to
motivate changing the libselinux functions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
