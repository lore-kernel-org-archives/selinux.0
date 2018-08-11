From: David Howells <dhowells@redhat.com>
In-Reply-To: <87pnyphf8i.fsf@xmission.com>
References: <87pnyphf8i.fsf@xmission.com> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 11 Aug 2018 08:29:46 +0100
Message-ID: <30365.1533972586@warthog.procyon.org.uk>
Subject: Re: BUG: Mount ignores mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Eric W. Biederman <ebiederm@xmission.com> wrote:

> > Yes, I agree it would be nice to have, but it *doesn't* really need
> > supporting right this minute, since what I have now oughtn't to break the
> > current behaviour.
> 
> I am really reluctant to endorse anything that propagates the issues of
> the current interface in the new mount interface.

Do realise that your problem cannot be solved through fsopen() until every
filesystem is converted to the new fs_context-based sget() since the flag has
to make it from the VFS through the filesystem to sget().

I'm reluctant to add this flag till that point until that time unless we error
out if the flag is set against a legacy filesystem.

David
