Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6E9YLB7010576
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2011 05:34:21 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6E9YKlu011989
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2011 09:34:20 GMT
Received: by iwn37 with SMTP id 37so37797iwn.12
        for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2011 02:34:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201107141611.41063.russell@coker.com.au>
References: <201107141611.41063.russell@coker.com.au>
Date: Thu, 14 Jul 2011 11:34:18 +0200
Message-ID: <CACLa4ptDbYinwwAjff8jq2XUmhxAcu2q8_yGd6sigq7byzM1hA@mail.gmail.com>
Subject: Re: subs_dist and libselinux releases
From: Eric Paris <eparis@parisplace.org>
To: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 14, 2011 at 8:11 AM, Russell Coker <russell@coker.com.au> wrote:
> http://userspace.selinuxproject.org/trac/browser/libselinux/src?order=date&desc=1
> http://userspace.selinuxproject.org/trac/wiki/Releases
>
> The patch for the subs_dist file was first proposed in April, when will there
> be a new upstream release that includes it?
>
> Currently we have a need for this in Debian, but it doesn't seem that there is
> an upstream release with it.  I would prefer to avoid maintaining my own patch
> set for libselinux in this regard if possible.

Russell et al.

I've started to take on trying to catch userspace up with the latest
and greatest based on what Fedora has done and not upstreamed and
patches I could find on the list.  Believe me, it's a project:

 78 files changed, 1616 insertions(+), 31867 deletions(-)

I have commit access to the upstream repo, but at the moment I haven't
really started reviewing patches closely enough to commit them and am
just trying to get a tree everyone can start to review.  (And it's the
tree I plan to make Fedora start using while I work the patches into
the upstream tree)

How about this: you help me I'll help you.  If you can find your patch
there, review it, and then review 5-10 other patches I'll move yours
and the others that you review it to the front of my 'to-merge'
upstream plans.  If you can't find your patch, resend it to me,
because I'm finished trying to fish things out of the archives....

Please everyone, I'd love for you to review patches!  It's not hard!

git clone http://oss.tresys.com/git/selinux.git selinux-userspace
cd selinux-userspace
edit .git/config and add:

[remote "eparis"]
	fetch = +refs/heads/*:refs/remotes/eparis/*
	url = git://git.infradead.org/users/eparis/selinux-userspace.git

git remote update
git format-patch -o /tmp/patches/ origin/master..eparis/master

Go wild with comments on things in /tmp/patches!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
