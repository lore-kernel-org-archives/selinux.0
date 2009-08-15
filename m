To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>, gregkh@suse.de,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	<4A84EF1D.8060408@schaufler-ca.com> <m1my62xde6.fsf@fess.ebiederm.org>
	<4A861291.1030404@schaufler-ca.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 14 Aug 2009 19:15:01 -0700
In-Reply-To: <4A861291.1030404@schaufler-ca.com> (Casey Schaufler's message of "Fri\, 14 Aug 2009 18\:42\:41 -0700")
Message-ID: <m1tz09j00q.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs files, directories, and symlinks.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> writes:

> Actually, I see that as a justification for the special purpose
> scheme rather than a real issue. The real attribute data is going
> to take up the same amount of space regardless of how it gets
> managed. And Stephen is correct in thinking that is most cases
> where there are xattrs there will be only one. I don't see that
> a mechanism more elaborate than a list is going to gain much in
> real life. On the other hand, if you wanted to take the ball and
> run with it, I have a window manager to deal with.

If you look at things from the point of view of a single inode I would
have to agree that the storage costs are roughly the same however they
get managed.

My understanding is that in most inodes all get a label from
a very small set of possible labels.

If that is true.  It makes sense to store the set of used labels
separately from the inodes.  Then on the inode just store a pointer
to the label.

Saying this in lisp parlance we should be able to use atoms instead of
strings.

At which point we have (I believe) an implementation that is as practically
as efficient as what was originally proposed but as general and as maintainable
as your version.

What I don't know is if the set of labels applied to a filesystem is actually
small, despite having a large number of labels applied.

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
