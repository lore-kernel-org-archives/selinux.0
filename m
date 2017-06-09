Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v59KOgqM009659
 for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2017 16:24:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id o28so5823551lfk.1
 for <selinux@tycho.nsa.gov>; Fri, 09 Jun 2017 13:24:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170606004637.GC5789@fieldses.org>
References: <20170602130918.gu22wnbd35idaurf@tonberry.usersys.redhat.com>
 <20170605154504.3659-1-smayhew@redhat.com>
 <CAHC9VhTpcZXB=9SRLHu+8Ot=ydyszc0+Qe044uVzPz8ndx4ukA@mail.gmail.com>
 <20170606004637.GC5789@fieldses.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Jun 2017 16:24:10 -0400
Message-ID: <CAHC9VhTF9_3mySBwrxUqu2-dw4S-Ci8qyX8d+vUTfOpTNs86+g@mail.gmail.com>
Subject: Re: [PATCH v3] security/selinux: allow security_sb_clone_mnt_opts to
 enable/disable native labeling behavior
To: Scott Mayhew <smayhew@redhat.com>, selinux@tycho.nsa.gov,
 linux-nfs@vger.kernel.org
Cc: "J . Bruce Fields" <bfields@fieldses.org>,
 Trond Myklebust <trondmy@primarydata.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Anna Schumaker <schumakeranna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 5, 2017 at 8:46 PM, J . Bruce Fields <bfields@fieldses.org> wrote:
> On Mon, Jun 05, 2017 at 05:21:55PM -0400, Paul Moore wrote:
>> On Mon, Jun 5, 2017 at 11:45 AM, Scott Mayhew <smayhew@redhat.com> wrote:
>> > When an NFSv4 client performs a mount operation, it first mounts the
>> > NFSv4 root and then does path walk to the exported path and performs a
>> > submount on that, cloning the security mount options from the root's
>> > superblock to the submount's superblock in the process.
>> >
>> > Unless the NFS server has an explicit fsid=0 export with the
>> > "security_label" option, the NFSv4 root superblock will not have
>> > SBLABEL_MNT set, and neither will the submount superblock after cloning
>> > the security mount options.  As a result, setxattr's of security labels
>> > over NFSv4.2 will fail.  In a similar fashion, NFSv4.2 mounts mounted
>> > with the context= mount option will not show the correct labels because
>> > the nfs_server->caps flags of the cloned superblock will still have
>> > NFS_CAP_SECURITY_LABEL set.
>> >
>> > Allowing the NFSv4 client to enable or disable SECURITY_LSM_NATIVE_LABELS
>> > behavior will ensure that the SBLABEL_MNT flag has the correct value
>> > when the client traverses from an exported path without the
>> > "security_label" option to one with the "security_label" option and
>> > vice versa.  Similarly, checking to see if SECURITY_LSM_NATIVE_LABELS is
>> > set upon return from security_sb_clone_mnt_opts() and clearing
>> > NFS_CAP_SECURITY_LABEL if necessary will allow the correct labels to
>> > be displayed for NFSv4.2 mounts mounted with the context= mount option.
>> >
>> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>> > ---
>> >  fs/nfs/super.c            | 17 ++++++++++++++++-
>> >  include/linux/lsm_hooks.h |  4 +++-
>> >  include/linux/security.h  |  8 ++++++--
>> >  security/security.c       |  7 +++++--
>> >  security/selinux/hooks.c  | 35 +++++++++++++++++++++++++++++++++--
>> >  5 files changed, 63 insertions(+), 8 deletions(-)
>>
>> Thanks for sorting this out Scott and Stephen.
>>
>> NFS folks, any objections to this patch?  If not, I'd like to pull
>> this into the SELinux tree but I'd like to have an ACK from you before
>> I do.
>
> Looks OK to me, but I think it's Trond or Anna (added to cc) that you
> want the ACK from.

It's been about four days with not comments from the NFS folks so I'm
just going to go ahead and merge this into the selinux/next branch so
we can get some more widespread testing.  NFS folks, if you want to
object please do so a week or two before the next merge window opens,
otherwise I'm going to send this patch upstream.

Thanks Scott for working on this patch, and everyone else for their
comments, testing, and review.

-- 
paul moore
www.paul-moore.com
