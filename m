Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6KJrm8l013388
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 15:53:48 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6KJrlCi028238
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 19:53:47 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6KJrlYa020862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 15:53:47 -0400
Received: from localhost.localdomain (vpn-9-91.rdu.redhat.com [10.11.9.91])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p6KJrkSY023200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 15:53:47 -0400
Message-ID: <4E27324A.50309@redhat.com>
Date: Wed, 20 Jul 2011 15:53:46 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Incoming flood of updates to SELinux userspace
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I decided to take on as a personal challenge the effort of trying to get
everything that Fedora and Red Hat have done with SELinux userspace into
the upstream trees.  My process has been to try to pick apart the
gigantic patch that Fedora carries and break that into reasonable size
patches with descriptive and meaningful changelogs.  As I'm breaking
them up I'm also attempting to review them for appropriateness of
inclusion.  As I find that patches that I either think are wrong, or I
can't explain, or whatever, I'm also committing those to my tree, but
trying to make sure it is clear that is the case.  I would quickly like
to switch Fedora to using my tree as its 'upstream' instead of the
Tresys tree.  Remember, my tree is going to contain everything in
Fedora, even if I don't think it's a good idea or ready to be merged
with the real upstream tree.

I've asked Dan (and everyone) to start reviewing patches in my tree a
couple per day.  He is going to send an e-mail to this list stating that
he believes a patch is ready to commit.  If both Dan and I agree that
the patch in question is appropriate for upstream I will commit it to
the real upstream repo.  As I commit patches upstream every day I will
rebase my private tree.  My private tree is NOT stable.

If you would like to participate, PLEASE DO!  Reviewing patches is easy!
 All you have to do is:

git clone http://oss.tresys.com/git/selinux.git selinux-userspace
cd selinux-userspace
edit .git/config and add:

[remote "eparis"]
       fetch = +refs/heads/*:refs/remotes/eparis/*
       url = git://git.infradead.org/users/eparis/selinux-userspace.git

git remote update
git format-patch -o /tmp/patches/ origin/master..eparis/master

I'd suggest that every day you wish to review you run:

rm -rf /tmp/patches
git remote update
git format-patch -o /tmp/patches/ origin/master..eparis/master

Because my repo will be constantly rebasing and changing as I push
patches into the upstream repo.

If you have ever posted a patch for SELinux userspace and you don't find
it in my tree, in my mind it's lost forever.  Please resend it.  Just
because I put it in my tree doesn't mean it's going to go upstream, but
if I don't put it in my private tracking tree, we can rest assured it's
not headed that way!

Please let me know if anyone has any problems, thoughts, concerns,
issues, or comments about how I'm doing things!

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
