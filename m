Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6H0H2hP011198
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 20:17:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com>
 <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <1437045404.2207.5.camel@samsung.com>
Date: Thu, 16 Jul 2015 19:10:34 -0500
In-Reply-To: <1437045404.2207.5.camel@samsung.com> (Lukasz Pawelczyk's message
 of "Thu, 16 Jul 2015 13:16:44 +0200")
Message-ID: <87fv4nr6dh.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
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

Lukasz Pawelczyk <l.pawelczyk@samsung.com> writes:

> On śro, 2015-07-15 at 16:06 -0500, Eric W. Biederman wrote:
>> 
>> I am on the fence with Lukasz Pawelczyk's patches.  Some parts I 
>> liked
>> some parts I had issues with.  As I recall one of my issues was that
>> those patches conflicted in detail if not in principle with this
>> appropach.
>> 
>> If these patches do not do a good job of laying the ground work for
>> supporting security labels that unprivileged users can set than Seth
>> could really use some feedback.  Figuring out how to properly deal 
>> with
>> the LSMs has been one of his challenges.
>
> I fail to see how those 2 are in any conflict. 

Like I said.  They don't really conflict, and actually to really support
things well for smack we probably need something like your patches.

At the same time a patch written without dealing with s_user_ns is going
to going to fail to take a lot of important details into account.

Right now after fixing the mount namespace issues the top priority is to
work through the details and get s_user_ns implemented.  By that I mean
some version of patch 1 of Seth's series.

s_user_ns fundamentally changes how the concepts are represented in the
kernel in a way that is easier to secure, and that fundamentally better
matches things.  And sigh.  This review has shown we don't quite have
all of the details worked out.

> If your approach here is to treat user ns mounted filesystem as if they
> didn't support xattrs at all then my patches don't conflict here any
> more than Smack itself already does.

The end game if people developing smack choose to play, is to figure out
how to store your unmapped labels in a filesystem contained by a
user namespace and a smack label namespace root.

> If the filesystem will get a default (e.g. by smack* mount options)
> label then this label will co-work with Smack namespaces.

A default, but I don't know if it will be smack mount options that will
give that default.  The devil is in the details and there are a lot
of details.

Eric
