From: ebiederm@xmission.com (Eric W. Biederman)
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
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
 linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
Date: Fri, 10 Aug 2018 19:28:00 -0500
In-Reply-To: <20180810161400.GA627@thunk.org> (Theodore Y. Ts'o's message of
 "Fri, 10 Aug 2018 12:14:00 -0400")
Message-ID: <87bma9oigf.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: BUG: Mount ignores mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Fri, Aug 10, 2018 at 04:53:58PM +0100, David Howells wrote:
>> Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> 
>> > Even *with* file system support, there's no way today for the VFS to
>> > keep track of whether a pathname resolution came through one
>> > mountpoint or another, so I can't do something like this:
>> 

>> However, the case folding stuff - is that a superblockism of a mountpointism?
>
> It's a superblock-ism.  As far as I know the *only* thing that we can
> support as a mount-pointism is the ro flag, and that's handled as a
> special case, and only if the original superblock was mounted
> read/write.  ey That was my point; aside from the ro flag, we can't
> support any other mount options as a per-mount point thing, so the
> only thing we can do is to fail the mount if there are conflicting
> mount options.  And I'm not really sure it helps the container use
> case, since the whole point is they want their "guest" to be able to
> blithely run "mount /dev/sda1 -o noxattr /mnt" and not worry about the
> fact that in some other container, someone had run "mount /dev/sda1 -o
> xattr /mnt".  But having the second mount fail because of conflicting
> mount option breaks the illusion that containers are functionally as
> rich as VM's.

Ted this isn't about some container case.

It about the fact that practically every filesystem in the kernel has
the behavior I have described and it means that if root is not super
careful root will shoot himself in the foot with the shotgun we have
pointed there.

It really is about loosing acls or some other filesystem option.


Eric
