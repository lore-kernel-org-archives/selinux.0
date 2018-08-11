From: ebiederm@xmission.com (Eric W. Biederman)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Tejun Heo <tj@kernel.org>,
 selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>,
 Li Zefan <lizefan@huawei.com>, linux-api@vger.kernel.org,
 apparmor@lists.ubuntu.com, Casey Schaufler <casey@schaufler-ca.com>,
 fenghua.yu@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers@google.com>, linux-security-module@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Johannes Weiner <hannes@cmpxchg.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
 torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <87d0uqpba5.fsf@xmission.com>
 <20180810151606.GA6515@ZenIV.linux.org.uk>
Date: Fri, 10 Aug 2018 20:05:44 -0500
In-Reply-To: <20180810151606.GA6515@ZenIV.linux.org.uk> (Al Viro's message of
 "Fri, 10 Aug 2018 16:16:06 +0100")
Message-ID: <87pnypiufr.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: BUG: Mount ignores mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Fri, Aug 10, 2018 at 09:05:22AM -0500, Eric W. Biederman wrote:
>> 
>> There is a serious problem with mount options today that fsopen does not
>> address.  The problem is that mount options are ignored for block based
>> filesystems, and any other type of filesystem that follows the same
>> pattern.
>> 
>> The script below demonstrates this bug.  Showing this bug can cause the
>> ext4 "acl" "quota" and "user_xattr" options to be silently ignored.
>> 
>> fsopen has my nack until it addresses this issue.
>> 
>> I don't know if we can fix this in the context of sys_mount.  But we if
>> we are redoing the option parsing of how we mount filesystems this needs
>> to be fixed before we start worrying about bug compatibility.
>> 
>> Hopefully this report is simple and clear enough that we can at least
>> agree on the problem.
>
> Sure, it is simple.  So's the solution: MNT_USERNS_SPECIAL_SEMANTICS that
> would get passed to filesystems, so that Eric would be able to implement
> his mount(2)-incompatible behaviour at leisure, without worrying about
> compatibility issues.
>
> Does that address your complaint?

Absolutely not.

My complaint is that the current implemented behavior of practically
every filesystem in the kernel, is that it will ignore mount options
when mounted a second time.  

It is not some weird special case.

It is not some container thing.

It is that the behavior of mount(2) with practically every filesystem
type when that filesystem is already mounted somewhere else behaves
in ways no one would expect.

With the new fsopen api the easy thing to do is simply have CMD_CREATE
CMD_BIND_INTERNAL and be done with it.  CMD_CREATE guarantee that a new
superblock is created.  CMD_BIND_INTERNAL would only work with an
existing superblock.  Then root would at least know that he is
connecting to an already mounted filesystem and could look at the
options etc and fail if he didn't like what he saw.  No surprises, no
muss, no fuss simple.


But I have been told the simple solution above is somehow unacceptable.
And an option to compare the mount options and see if they are the same
was offered.  That would will work to.

I just care that we define the semantics in such a way that it is not
easy for root to get confused and do something stupid that will bite
later, and that we build the infrastructure so that all filesystems
can implement it easily.

So yes this is 100% a question about how filesystems should behave with
respect to their option when mounted for a second time.  That is what
Dave Howells patchset is addressing.

> Because one thing we are not going to do is changing mount(2)
> behaviour.

I have not asked for that.  I have asked that we get it right for
fsopen.

> Reason: userland-visible behaviour of hell knows how many local scripts.



> Another thing that
> is flat-out not feasible is some kind of blanket "compare options"
> stuff; it *can* be done as helpers to be used by filesystem when
> it sees that new flag, but it's simply not going to work at the
> fs-independent level.
>
> Trivial example with the same ext4:
> mount /dev/sda1 /mnt/a -o bsddf vs. mount /dev/sda1 /mnt/b
> ext4 can tell that these are the same.  syscall itself has no
> clue.  What's more, it's not just explicitly spelled default
> options - it's the stuff that has more than one form.  And while
> we are at it, the things like two NFS mounts of different trees
> from the same server; they might or might not get the same superblock.
> Depending upon the options.
>
> Convenience helper that would allow ext4 to compare options and reject
> the incompatible mount?  Not sure how much ext4-specific knowledge
> would have to go in it, but if you can come up with one - more power
> to you.  But the decision to use it *must* be ext4-specific.  Because
> for e.g. NFS such thing as -o fsid=..., while certainly a part of
> options, has a very different meaning - it's "use a separate fs instance"
> (and let the server deal with coherency issues on its end).
>
> Decision to use sget() (and the way it's used) is up to filesystem.
> We *can't* lift that into syscall.  Not without breaking the fuck out
> of existing behaviour.

I have never proposed that.  See above.  I may have talked in terms
of what sget does and muddied the waters.  If so I apologize.

All I proposed was that we distinguish between a first mount and an
additional mount so that userspace knows the options will be ignored.

Then the code to replicate the current behavior can look like:

	fd = fsopen(...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	fsconfig(fd, ...);
	
	if (fsconfig(fd, CMD_CREATE) == -EBUSY) {
        	fsconfig(fd, CMD_BIND_INTERNAL);
        }

But userspace would then be free to issue a warning or do something
else if CMD_CREATE returns -EBUSY.

I don't know how the above wound up being construed as asking that the
code call sget directly but that is what has happened.

> Having something like a second callback for mount_bdev() that would
> be called when we'd found an existing instance for the same block
> device?  Sure, no problem.  Having a helper for doing such comparison
> that would work in enough cases to bother, so that different fs
> could avoid boilerplate in that callback?  Again, more power to you.

Normal forms etc.  If we want to do that it just requires a wee bit of
discipline.  And if all of the option parsing is being rewritten and
retested anyway I don't see why we can't do something like that as well.
So it does not sound unreasonable to me.

It does sound like more work than what I was proposing.

Eric
