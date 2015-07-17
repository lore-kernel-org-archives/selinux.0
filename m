Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6HESafF029239
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 10:28:36 -0400
Date: Fri, 17 Jul 2015 09:28:32 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150717142832.GA23235@mail.hallyn.com>
References: <87615k7pyu.fsf@x220.int.ebiederm.org>
 <20150716135947.GC77715@ubuntu-hedt>
 <55A7C920.7090206@schaufler-ca.com>
 <20150716185750.GB51751@ubuntu-hedt>
 <55A8253E.3000407@schaufler-ca.com>
 <CALCETrW6NpwY0CXNXWBcqx6JPyAqr6XP-BKexO1HFdpxnQUJrQ@mail.gmail.com>
 <55A8398A.3000802@schaufler-ca.com>
 <CALCETrXA94MBrJ7Dni7RW68Wn3MxcxSmr082hG=haWWncL=feg@mail.gmail.com>
 <55A85041.2070301@schaufler-ca.com>
 <CALCETrUTgfRzzdk3T0wZASSE+KC9S+kmyZbD6-xStS2RRaGiBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUTgfRzzdk3T0wZASSE+KC9S+kmyZbD6-xStS2RRaGiBw@mail.gmail.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 16, 2015 at 05:59:22PM -0700, Andy Lutomirski wrote:
> On Thu, Jul 16, 2015 at 5:45 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 7/16/2015 4:29 PM, Andy Lutomirski wrote:
> >> I really don't see the benefit of making up extra rules that apply to
> >> users outside a userns who try to access specifically a filesystem
> >> with backing store.  They wouldn't make sense for filesystems without
> >> backing store.
> >
> > Sure it would. For Smack, it would be the label a file would be
> > created with, which would be the label of the process creating
> > the memory based filesystem. For SELinux the rules are more a
> > touch more sophisticated, but I'm sure that Paul or Stephen could
> > come up with how to determine it.
> >
> > The point, looping all the way back to the beginning, where we
> > were talking about just ignoring the labels on the filesystem,
> > is that if you use the same Smack label on the files in the
> > filesystem as the backing store file has, we'll all be happy.
> > If that label isn't something user can write to, he won't be
> > able to write to the mounted objects, either. If there is no
> > backing store then use the label of the process creating the
> > filesystem, which will be the user, which will mean everything
> > will work hunky dory.
> >
> > Yes, there's work involved, but I doubt there's a lot. Getting
> > the label from the backing store or the creating process is
> > simple enough.
> >
> 
> So what if Smack used the label of the user creating the filesystem
> even for filesystems with backing store?  IMO this ought to be doable

The more usual LSM-ish way to handle this would be to ask the LSM, at
mount time, with a new security_mount_bdev_in_userns() hook, passing
it the user's label and the backing store's label (if any), and storing
the label to be used for the files.  Even more LSM-ish (though risking
performance hit) would be to then have the LSM at each inode_init_security
decide whether to use that label or trust what's in the fs anyway (or
do something else).  That could allow the LSM to use policy to decide
that.

Because I don't know that for all LSMs it makes sense for a 'subject'
label to be assigned to an object.

> with the LSM hooks -- it certainly seems reasonable for the LSM to be
> aware of who created a filesystem.  In fact, I'd argue that if Smack
> can't do this with the proposed LSM hooks, then the hooks are
> insufficient.
> 
> Presumably Smack could also figure out what was mounted, but keep in
> mind that there are filesystems like ntfs-3g out there.  While ntfs-3g
> logically has backing store, I don't think the kernel actually knows
> about it.
> 
> >
> >>>>> If you can mount a filesystem such that the labels are ignored you
> >>>>> are effectively specifying that the Smack label on the files be
> >>>>> determined by the defaulting rules. With CAP_MAC_ADMIN that's fine.
> >>>>> Without it, it's not.
> >>>> Can you explain what the threat model is here?  I don't see what it is
> >>>> that you're trying to prevent.
> >>> Um, OK.
> >>> The filesystem has files with a hundred different Smack labels on it.
> >>> I mount it as an unlabeled filesystem and everything is readable by
> >>> everyone. Bad jojo.
> >> I still don't understand.  If it's a filesystem backed by a file that
> >> Seth has RW access to, then Seth can read everything on it, full stop.
> >> The security labels in the filesystem are irrelevant.
> >
> > Well, they can't be trusted, if that's what you mean.
> > That's why I'm saying that the objects exposed by mounting
> > this backing store need to be treated with the same security
> > attributes as the backing store. Fudge it for DAC if you are
> > so inclined, but I think it's the right way to go for MAC.
> >
> >> This is like saying that, if you put restrictive labels in the
> >> filesystem that lives on /dev/sda2 and give Seth ownership of
> >> /dev/sda2, then you expect Seth to be unable to bypass the policy
> >> specifies by your labels.
> >
> > Consider the Smack label on /dev/sda2. Smack does not care
> > who owns it, just what the Smack label is. Just like on
> > ~/seth/myfs. The backing store "object" is /dev/sda2 in the
> > one case, ~/seth/myfs in the other, and something in the ether
> > for a memory based filesystem. So long as the labels of the
> > files exposed on the mount point match those of the backing
> > store "object", Smack is going to be happy. Since you're
> > running without privilege, you can't change the labels on
> > the files.
> >
> > Now Seth, being the sneaky person that he is, could change
> > the Smack labels on the files in the backing store while it's
> > offline. Since he has access to the backing store, he can't
> > give himself more access by changing the labels within the
> > filesystem. He can give himself less, but I'm OK with that.
> >
> >> Or maybe I'm misunderstanding you.
> >
> > Probably, but I'm undoubtedly doing the same.
> >
> > If you're going to be at LinuxCon in Seattle we should
> > continue this discussion over the beverage of your choice.
> 
> There's a small but not quite zero chance I'll be there.  I'll
> probably be in Seoul.  It's too bad that LSS and KS are in different
> places this year.

FWIW I'll be there and happy to discuss.

-serge
