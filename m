From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: setexeccon vs. setfscreatecon
In-Reply-To: <1155050462.1123.36.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Tue, 08 Aug 2006 11:21:02 -0400")
References: <87u04ncqqq.fsf@rho.meyering.net>
	<1155050462.1123.36.camel@moss-spartans.epoch.ncsc.mil>
Date: Tue, 08 Aug 2006 17:57:45 +0200
Message-ID: <87ejvrcj9i.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2006-08-08 at 15:16 +0200, Jim Meyering wrote:
>> I see that setexeccon sets the context to be used for next execve call.
>> And then there's setfscreatecon.  I want something similar that sets
>> the fscreate context for the next execve call.  Does such a function exist?
>> Is there some other way to do what I want?
>>
>> In case you're wondering, here's my motivation: I'm merging some
>> coreutils selinux changes into upstream and noticed that they would break
>> thread-safety in coreutils' copying engine, src/copy.c -- because they
>> introduce calls to setfscreatecon.  From reading the man page for that
>> function, I gather that the fscreate-context is a per-process attribute.
>> As such (like umask and cwd), changing it affects all threads, and its
>> use should be avoided in library-esque code.
>>
>> What I would like to do is merge the context-printing and
>> context-preserving parts of that patch, but not the context-setting
>> parts (--context=CTX in cp, mkdir, mkfifo, mknod, install).  Instead,
>> I'm trying to add an option to runcon that would let me also set the
>> fscreate context for the process it runs.  Then, all of the individual
>> context-setting options would be unnecessary.
>>
>> Does this sound reasonable?  Feasible?
>
> At present, the kernel resets the process attributes (exec, fscreate,
> and more recent additions like keycreate and sockcreate) upon each execve

Thanks for the quick reply!

What you're saying seems to be at odds with setexeccon.1
as well as with this demonstration (using 2.6.17-1.2462.fc6):

    $ id -Z
    user_u:system_r:unconfined_t
    $ runcon -r object_r -- ./id -Z
    user_u:object_r:unconfined_t

since runcon's call to setexeccon does what the man page says it does
(set exec context for subsequent execve call) and changes the role from
system_r to object_r.  Does that mean this behavior is Red Hat/Fedora-
specific?

Is there any hope that I could get an interface to allow something
similar with respect to the fscreate context?
With such a function, it would be trivial to set the context of
files created by an arbitrary program: simply run it via e.g.,

  runcon --fs-create-context=FS_CREATE_CONTEXT -- EXEC_CONTEXT PROGRAM ARG...

Without it, most file-creating programs will have to be modified
(manually and tediously) to accept a new option allowing the user to
select an fs-create context.

> so that each program starts life with the default policy
> behaviors for its execve and file creation calls, and follows that
> behavior unless the program itself explicitly sets the attributes.
>
> With regard to the thread issue, the kernel actually supports per-thread
> attributes (per-Linux task), but libselinux doesn't presently access it

I've heard of the Linux option to convert normally-per-process attributes
into per-task ones.  However that seems like an overly large stick to
shake at this problem.  Isn't it onerous, and even dangerous, for a
library to require that a multi-threaded application flip that switch
in Linux?  Some other library used by the application could assume
certain attributes are per-process.

> in a manner that allows you to leverage it (via /proc/self rather
> than /proc/self/task/<tid>).  At present, any child thread will just
> fail upon the libselinux calls since it will be viewed by the kernel as
> attempting to change the attribute of the thread group leader from a
> different thread, and we only allow a thread to change its own
> attributes.  libselinux could be changed to use /proc/self/task/<tid>,
> at which point the kernel would do the right thing, I think.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
