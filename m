Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u29EmQMq009551
 for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2016 09:48:26 -0500
Received: by mail-ob0-f177.google.com with SMTP id m7so48455047obh.3
 for <selinux@tycho.nsa.gov>; Wed, 09 Mar 2016 06:48:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160309141840.GC23399@ubuntu-xps13>
References: <1451930639-94331-1-git-send-email-seth.forshee@canonical.com>
 <1451930639-94331-17-git-send-email-seth.forshee@canonical.com>
 <20160309112923.GF8655@tucsk> <20160309141840.GC23399@ubuntu-xps13>
Date: Wed, 9 Mar 2016 15:48:22 +0100
Message-ID: <CAJfpegv5JmB15yHpjYxVeOYdWWkoLMftr9-e_iS93Y_7m=t4Zw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 16/18] fuse: Support fuse filesystems outside of
 init_user_ns
From: Miklos Szeredi <miklos@szeredi.hu>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 fuse-devel <fuse-devel@lists.sourceforge.net>,
 LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 9, 2016 at 3:18 PM, Seth Forshee <seth.forshee@canonical.com> wrote:
> On Wed, Mar 09, 2016 at 12:29:23PM +0100, Miklos Szeredi wrote:
>> On Mon, Jan 04, 2016 at 12:03:55PM -0600, Seth Forshee wrote:

>> > -static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev)
>> > +static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
>> > +                     struct user_namespace *user_ns)
>> >  {
>> >     char *p;
>> >     memset(d, 0, sizeof(struct fuse_mount_data));
>> >     d->max_read = ~0;
>> >     d->blksize = FUSE_DEFAULT_BLKSIZE;
>> > +   d->user_id = make_kuid(user_ns, 0);
>> > +   d->group_id = make_kgid(user_ns, 0);
>>
>> It is true that if "user_id=" or "group_id" options were omitted we used the
>> zero uid/gid values.  However, this isn't actually used by anybody AFAIK, and
>> generalizing it for userns doesn't seem to make much sense.
>>
>> So I suggest we that we instead return an error if mounting from a userns AND
>> neither "allow_other" nor both "user_id" and "group_id" are specified.
>
> But those are also used for ownership of the connection files in
> fusectl. In an allow_other mount shouldn't those files by owned by
> namespace root and not global root?

Yes.

Can't we use current_cred()->uid/gid? Or fsuid/fsgid maybe?

When we have true unprivileged mounts, the user_id/group_id options
become redundant anyway and we can just use the current credentials.

Thanks,
Miklos
