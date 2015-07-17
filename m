Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6HADmnP011488
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 06:13:48 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRM00412N2P2N50@mailout1.w1.samsung.com> for
 selinux@tycho.nsa.gov; Fri, 17 Jul 2015 11:13:37 +0100 (BST)
Message-id: <1437128016.2240.12.camel@samsung.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 17 Jul 2015 12:13:36 +0200
In-reply-to: <87fv4nr6dh.fsf@x220.int.ebiederm.org>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com> <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <1437045404.2207.5.camel@samsung.com> <87fv4nr6dh.fsf@x220.int.ebiederm.org>
Content-type: text/plain; charset=UTF-8
MIME-version: 1.0
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On czw, 2015-07-16 at 19:10 -0500, Eric W. Biederman wrote:
> Lukasz Pawelczyk <l.pawelczyk@samsung.com> writes:
> > 
> > I fail to see how those 2 are in any conflict. 
> 
> Like I said.  They don't really conflict, and actually to really 
> support
> things well for smack we probably need something like your patches.

As far as I can see now from the discussion the best thing to do would
to be inherit label from a backing store object, or something along
this line.

> At the same time a patch written without dealing with s_user_ns is 
> going
> to going to fail to take a lot of important details into account.

I don't touch anything that would need to deal with s_user_ns. I also
don't change Smack's mounting logic in any way. My patches are
orthogonal to that.

> Right now after fixing the mount namespace issues the top priority is 
> to
> work through the details and get s_user_ns implemented.  By that I 
> mean
> some version of patch 1 of Seth's series.

My priority is to make Smack namespace work. This is a functionality
that has a perfectly valid use case now. Without it Smack in a
container is impossible to operate on.

> s_user_ns fundamentally changes how the concepts are represented in 
> the
> kernel in a way that is easier to secure, and that fundamentally 
> better
> matches things.  And sigh.  This review has shown we don't quite have
> all of the details worked out.
> 
> > If your approach here is to treat user ns mounted filesystem as if 
> > they
> > didn't support xattrs at all then my patches don't conflict here 
> > any
> > more than Smack itself already does.
> 
> The end game if people developing smack choose to play, is to figure 
> out
> how to store your unmapped labels in a filesystem contained by a
> user namespace and a smack label namespace root.

Storing an unmapped label (read: real label) in Smack namespace is
exactly the same as it is now without the namespace. I always store the
real label.

The problem here is: what real label should be "read" and eventually
stored in that filesystem (see my first comment here). Again, Smack
namespace doesn't touch that logic.

> > If the filesystem will get a default (e.g. by smack* mount options)
> > label then this label will co-work with Smack namespaces.
> 
> A default, but I don't know if it will be smack mount options that 
> will
> give that default.  The devil is in the details and there are a lot
> of details.

Now Smack gives the default. If someone will modify Smack to give a
different label because of s_user_ns support Smack namepace will not
cause any hindrance here.

Smack namespace main role is only to be able to operate Smack within a
container. All the other LSM can do that already as they don't require
caps to operate normally. Smack does. Hence it had to be namespaced in
some way to give limited capabilities in a container (user ns).

This really has nothing to do with the way Smack mounts, assigns
labels, decides what is allowed and what is not, etc.

What this discussion is about is how to modify or even bend LSM's way
of work to make unprivileged user ns mounts work under LSM (or not).
Smack namespace here is just an utility within Smack itself. And maybe
it can be used to help this at some point, but beyond that it's
orthogonal to the problem.



-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics
