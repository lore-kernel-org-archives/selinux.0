Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBH203019369
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:17:02 -0400
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRK00F89VBYRQA0@mailout1.w1.samsung.com> for
 selinux@tycho.nsa.gov; Thu, 16 Jul 2015 12:16:46 +0100 (BST)
Message-id: <1437045404.2207.5.camel@samsung.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 16 Jul 2015 13:16:44 +0200
In-reply-to: <87vbdlf7vo.fsf@x220.int.ebiederm.org>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com> <87vbdlf7vo.fsf@x220.int.ebiederm.org>
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

On śro, 2015-07-15 at 16:06 -0500, Eric W. Biederman wrote:
> 
> I am on the fence with Lukasz Pawelczyk's patches.  Some parts I 
> liked
> some parts I had issues with.  As I recall one of my issues was that
> those patches conflicted in detail if not in principle with this
> appropach.
> 
> If these patches do not do a good job of laying the ground work for
> supporting security labels that unprivileged users can set than Seth
> could really use some feedback.  Figuring out how to properly deal 
> with
> the LSMs has been one of his challenges.

I fail to see how those 2 are in any conflict. Smack namespace is just
a mean of limiting the view of Smack labels within user namespace, to
be able to give some limited capabilities to processes in the namespace
to make it possible to partially administer Smack there. It doesn't
change Smack behaviour or mode of operation in any way.

If your approach here is to treat user ns mounted filesystem as if they
didn't support xattrs at all then my patches don't conflict here any
more than Smack itself already does.

If the filesystem will get a default (e.g. by smack* mount options)
label then this label will co-work with Smack namespaces.


-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics
