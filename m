MIME-Version: 1.0
In-Reply-To: <1296482354.26427.21.camel@moss-pluto>
References: <AANLkTi=4CH2zFrDp6DAnSj3pa28MtymfG+NrtQ3iW5k-@mail.gmail.com> <1296482354.26427.21.camel@moss-pluto>
From: Lucian Adrian Grijincu <lucian.grijincu@gmail.com>
Date: Mon, 31 Jan 2011 16:14:33 +0200
Message-ID: <AANLkTinMNftk8cUnGn+XfpUkwyo5axdnS2oO8Dg4k6M8@mail.gmail.com>
Subject: Re: [PATCH 2/2] RFC: selinux: sysctl: fix selinux labeling broken by
 last patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux <selinux@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 31, 2011 at 3:59 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> - Don't remove the IS_PRIVATE() test from inode_has_perm(), as other
> inodes beyond just the /proc/sys ones are marked with that flag
> (original usage was for reiserfs xattr inodes).


Are you sure? I believe it was added here:

    [PATCH] selinux: enhance selinux to always ignore private inodes

    Hmmm...turns out to not be quite enough, as the /proc/sys inodes
aren't truly
    private to the fs, so we can run into them in a variety of security hooks
    beyond just the inode hooks, such as security_file_permission (when reading
    and writing them via the vfs helpers), security_sb_mount (when
mounting other
    filesystems on directories in proc like binfmt_misc), and deeper within the
    security module itself (as in flush_unauthorized_files upon
inheritance across
    execve).  So I think we have to add an IS_PRIVATE() guard within SELinux, as
    below.  Note however that the use of the private flag here could
be confusing,
    as these inodes are _not_ private to the fs, are exposed to userspace, and
    security modules must implement the sysctl hook to get any access
control over
    them.


http://thread.gmane.org/gmane.comp.security.selinux/341/focus=519


In my patch I don't care about IS_PRIVATE, because I don't mark proc
inodes as PRIVATE any more.


This patch added S_ISPRIVATE to proc inodes:
    [PATCH] sysctl: hide the sysctl proc inodes from selinux
    86a71dbd3e81e8870d0f0e56b87875f57e58222b

This one added the IS_PRIVATE check:
    [PATCH] selinux: enhance selinux to always ignore private inodes
    bbaca6c2e7ef0f663bc31be4dad7cf530f6c4962


I'll remove the check from my patch if you say it's used in other
places too, but the original usage does not seem to be "for reiserfs
xattr inodes".

-- 
 .
..: Lucian


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
