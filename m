Date: Fri, 10 Aug 2018 17:38:52 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
 David Howells <dhowells@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 John Johansen <john.johansen@canonical.com>, Tejun Heo <tj@kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Li Zefan <lizefan@huawei.com>, Linux API <linux-api@vger.kernel.org>,
 apparmor@lists.ubuntu.com, Casey Schaufler <casey@schaufler-ca.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers@google.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Johannes Weiner <hannes@cmpxchg.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 tomoyo-dev-en@lists.sourceforge.jp,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Message-ID: <20180811003852.GA10463@magnolia>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180810204639.GI627@thunk.org> <20180810221234.GC4211@magnolia>
 <20180810235447.GK627@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180810235447.GK627@thunk.org>
Subject: Re: BUG: Mount ignores mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Aug 10, 2018 at 07:54:47PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Aug 10, 2018 at 03:12:34PM -0700, Darrick J. Wong wrote:
> > Hey now, there was a little more nuance to it than that[1][2].  The
> > complaint in the first instance had much more to do with breaking
> > existing V4 filesystems by adding format requirements that mkfs didn't
> > know about when the filesystem was created.  Yes, you can create V4
> > filesystems that will hang the system if the log was totally unformatted
> > and metadata updates are made, but OTOH it's fairly obvious when that
> > happens, you have to be root to mount a disk filesystem, and we try to
> > avoid breaking existing users.
> 
> I wasn't thinking about syzbot reports; I've largely written them off
> as far as file system testing is concerned, but rather Wen Xu at
> Georgia Tech, who is much more reasonable than Dmitry, and has helpeyd
> me out a lot; and has complained that the XFS folks haven't been
> engaging with him.

Ahh, ok.  Yes, Wen has been easier to work with, and gives out
filesystem images.  Hm, I'll go comb the bugzilla again...

> In either case, both security researchers are fuzzing file system
> images, and then fixing the checksums, and discovering that this can
> lead to kernel crashes, and in a few cases, buffer overruns that can
> lead to potential privilege escalations.  Wen can generate reports
> faster than syzbot, but at least he gives me file system images (as
> opposed to having to dig them out of syzbot repro C files) and he
> actually does some analysis and explains what he thinks is going on.

(FWIW I tried to figure out how to add fs image dumping to syzbot and
whoah that was horrifying.

> I don't think anyone was claiming that format requirements should be
> added to ext4 or xfs file systems.  But rather, that kernel code
> should be made more robust against maliciously corrupted file system
> images that have valid checksums.  I've been more willing to work with
> Wen; Dave has expressed the opinion that these are not realistic bug
> reports, and since only root can mount file systems, it's not high
> priority.

I don't think they're high priority either, but they're at least worth
/some/ attention.

> The reason why I bring this up here is that in container land, there
> are those who believe that "container root" should be able to mount
> file systems, and if the "container root" isn't trusted, the fact that
> the "container root" can crash the host kernel, or worse, corrupt the
> host kernel and break out of the container as a result, that would be
> sad.
> 
> I was pretty sure most file system developers are on the same page
> that allowing untrusted "container roots" the ability to mount
> arbitrary block device file systems is insanity.

Agreed.

> Whether or not we try to fix these sorts of bugs submitted by security
> researchers.  :-)

and agreed. :)

--D

> 	  	       	    	       		  - Ted
