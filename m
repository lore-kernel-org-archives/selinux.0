Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7DGnN71032085
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 12:49:23 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 985432174E
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 16:49:15 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id g1-v6so14869463wru.2
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 09:49:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180813173502.1a7a1d9c@alans-desktop>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180813173502.1a7a1d9c@alans-desktop>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 13 Aug 2018 09:48:53 -0700
Message-ID: <CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Subject: Re: BUG: Mount ignores mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 13, 2018 at 9:35 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> If the same block device is visible, with rw access, in two different
>> containers, I don't see any anything good can happen.  Sure, with the
>
> At the raw level there are lots of use cases involving high performance
> data capture, media streaming and the like.
>
> At the file system layer you can use GFS2 for example.

Ugh.  I even thought of this case, and I should have been a bit more precise:

I would consider the GFS2 case to be essentially equivalent to the NFS
case.  I think we can probably divide all the filesystems into three
or four types:

pseudo file systems: Multiple instantiations of the same fs driver
pointing at the same backing store give separate filesystems.  (Same
backing store includes the case where there isn't any backing store.)
tmpfs is an example.  This isn't particularly interesting.

network-like file systems: Multiple instantiations of the same fs
driver pointing at the same backing store are expected.  This includes
NFS, GFS2, AFS, CIFS, etc.  This is only really interesting to the
extent that, if the fs driver internally wants to share state between
multiple instantiations, it should be smart enough to make sure the
options are compatible or that it can otherwise handle mismatched
options correctly.  NFS does this right.

non-network-like filesystems: There are complicated ones like btrfs
and ZFS and simple ones like ext4.  In either case, multiple totally
separate instantiations of the driver sharing the backing store will
lead to corruption.  In cases like ext4, we seem to support it for
legacy reasons, because we're afraid that there are scripts that try
to mount the same block device more than once, and I think the new API
has no need to support this.  In cases like btrfs, we also seem to
support multiple user requests for "mounts" with the same underlying
block devices because we need it for full functionality.  But I think
this is because our API is wrong.

Are there cases I'm missing?  It sounds like the API could be improved
to fully model the last case, and everything will work nicely.
