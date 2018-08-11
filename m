Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7BGVaGZ005865
 for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2018 12:31:38 -0400
Received: by mail-pl0-f54.google.com with SMTP id t17-v6so5234770ply.13
 for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2018 09:31:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <30365.1533972586@warthog.procyon.org.uk>
Date: Sat, 11 Aug 2018 09:31:29 -0700
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, viro@zeniv.linux.org.uk,
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
Message-Id: <9B6E2781-484B-4C42-95F5-F900EA36CEA5@amacapital.net>
References: <87pnyphf8i.fsf@xmission.com> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <30365.1533972586@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Subject: Re: BUG: Mount ignores mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> On Aug 11, 2018, at 12:29 AM, David Howells <dhowells@redhat.com> wrote:
> 
> Eric W. Biederman <ebiederm@xmission.com> wrote:
> 
>>> Yes, I agree it would be nice to have, but it *doesn't* really need
>>> supporting right this minute, since what I have now oughtn't to break the
>>> current behaviour.
>> 
>> I am really reluctant to endorse anything that propagates the issues of
>> the current interface in the new mount interface.
> 
> Do realise that your problem cannot be solved through fsopen() until every
> filesystem is converted to the new fs_context-based sget() since the flag has
> to make it from the VFS through the filesystem to sget().
> 
> I'm reluctant to add this flag till that point until that time unless we error
> out if the flag is set against a legacy filesystem.
> 
> 

I don’t see why we need all this fancy “do the options match” stuff.  For the handful of filesystems (like NFS) that do something intelligent when multiple non-bind mount requests against the same underlying storage happen,  we can keep that behavior in the new API. For other filesystems that don’t have this feature, we should simply fail the request.

IOW I see so compelling reason to call sget() at all from the new API.  The only sort-of-legit use case I can think of is mounting more than one btrfs subvolume. But even that should probably not be done by asking the kernel to separately instantiate the filesystem.

As another way of looking at it: for a network filesystem, mounting the same target ip and path from two different Linux machines works, so mounting it twice from the same machine should also work.  But mounting the same underlying ext4 block device from two different Linux machines (using nbd, iscsi, etc) would be a catastrophe, so I see no reason that it needs to be supported if it’s two mounts from one machine.

The case folding example is interesting, and I think it should probably have a slightly different API. A program could open_tree a nocasefold mount and then make a request to create what is functionally a bind mount but with different options.

mount(8) will presumably just keep using mount(2).
