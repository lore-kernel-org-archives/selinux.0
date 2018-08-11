Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7BHm9OH016193
 for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2018 13:48:10 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, David Howells <dhowells@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Tejun Heo <tj@kernel.org>,
 selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>,
 Li Zefan <lizefan@huawei.com>, linux-api@vger.kernel.org,
 apparmor@lists.ubuntu.com, fenghua.yu@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers@google.com>, linux-security-module@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Johannes Weiner <hannes@cmpxchg.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
 torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <87d0uqpba5.fsf@xmission.com> <20180810151606.GA6515@ZenIV.linux.org.uk>
 <87pnypiufr.fsf@xmission.com> <20180811014619.GA14368@thunk.org>
 <8736vlo6ef.fsf@xmission.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <001a1608-d0fa-84c1-9c54-ae36df95fd89@schaufler-ca.com>
Date: Sat, 11 Aug 2018 10:47:50 -0700
MIME-Version: 1.0
In-Reply-To: <8736vlo6ef.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: BUG: Mount ignores mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/10/2018 9:48 PM, Eric W. Biederman wrote:
> "Theodore Y. Ts'o" <tytso@mit.edu> writes:
>
>> On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:
>>> My complaint is that the current implemented behavior of practically
>>> every filesystem in the kernel, is that it will ignore mount options
>>> when mounted a second time.
>> The file system is ***not*** mounted a second time.
>>
>> The design bug is that we allow bind mounts to be specified via a
>> block device.  A bind mount is not "a second mount" of the file
>> system.  Bind mounts != mounts.
>>
>> I had assumed we had allowed bind mounts to be specified via the block
>> device because of container use cases.  If the container folks don't
>> want it, I would be pushing to simply not allow bind mounts to be
>> specified via block device at all.
> No it is not a container thing.

	Inigo: "Hello. My name is Inigo Montoya. You killed my father. Prepare to die."
	Rugen: "Stop saying that!"

	Eric:  "It is not a container thing."
	Casey: "Stop saying that!"

Yes, Virginia, it *is* a container thing. Your container manager expects all
filesystems to be server-client based. It makes bad assumptions. It is doing
things that we would fire a sysadmin for doing. Don't blame the filesystems
for behaving as documented. Export the filesystem using NFS and mount them
using the NFS mechanism, which is designed to do what you're asking for. The
problem is not in the mount mechanism, it's in the way you want to abuse it.

>> The only reason why we should support it is because we don't want to
>> break scripts; and if the goal is not to break scripts, then we have
>> to keep to the current semantics, however broken you think it is.
> But we don't have to support returning filesystems with mismatched mount
> options in the new fsopen api.   That is my concern.  Confusing
> userspace this way has been shown to be harmful let's not keep doing it.

It's not "userspace" that's confused. Developers of userspace code
implementing system behavior (e.g. systemd, container managers) need to
understand how the system works. The container manager needs to know
that it can't mount filesystems with different options. That's the kind
of thing "managers" do. If it has to go to the mount table and check
on how the device is already mounted before doing a mount, so be it.

Unless, of course, you want the concept of "container" introduced into
the kernel. There's a whole lot of feldercarb that container managers
have to deal with that would be lots easier to deal with down below.
I'm not advocating that, and I understand the arguments against it.
On the other hand, if you want a platform that is optimized for a
container environment ...

> Eric
