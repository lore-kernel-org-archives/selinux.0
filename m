Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2LIeUNL030176
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2012 14:40:30 -0400
Date: Wed, 21 Mar 2012 18:40:39 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com, Jeffrey Burke <jburke@redhat.com>
Subject: Re: selinux-testsuite patches for RHEL5/6/7a
Message-ID: <20120321184039.GA23957@mail.hallyn.com>
References: <4F67040B.2000804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F67040B.2000804@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Jan Stancek (jstancek@redhat.com):
> Hi,
> 
> Couple months ago, selinux-testsuite has been removed from LTP and
> is currently hosted at:
> http://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=summary
> 
> After discussing this with Serge on LTP mailing list, he suggested
> this mailing list as likely candidate for future selinux-testsuite
> issues.
> 
> I'm attaching 7 patches. Some of these are backports from LTP, that
> didn't make it to current repo. Others are to make selinux-testsuite
> runnable in automated testing environment (beaker/rhts) for
> RHEL5/6/7a and Fedora16.
> 
> Jan Stancek (7):
>   fix hang on ppc64 and s390x
>   include test_bounds if version -ge 24
>   mkdir: look for selinuxfs
>   policy: allow to use leaked fd and console
>   rhel5: policy allow to use leaked fd and console
>   sigiotask: use pty, fix SIGIO race
>   test_global.te: add gen_require on privileged roles
> 
>  policy/Makefile                |    4 +++-
>  policy/redhat/5/test_file.te   |   13 +++++++++++++
>  policy/redhat/5/test_global.te |    5 +++++
>  policy/test_file.te            |   13 +++++++++++++
>  policy/test_global.te          |    9 +++++++++
>  policy/test_policy.if          |    5 +++++
>  tests/file/Makefile            |    1 +
>  tests/file/test_sigiotask.c    |   34 ++++++++++++++++++++++++++++------
>  tests/mkdir/test               |   17 ++++++++++++++++-
>  tests/msg/msgctl.c             |    2 +-
>  tests/msg/msgget.c             |    2 +-
>  tests/msg/msgrcv.c             |    2 +-
>  tests/msg/msgsnd.c             |    2 +-
>  tests/ptrace/wait              |    3 ++-
>  tests/sem/semctl.c             |    2 +-
>  tests/sem/semget.c             |    2 +-
>  tests/sem/semop.c              |    2 +-
>  17 files changed, 102 insertions(+), 16 deletions(-)
> 
> Regards,
> Jan


Thanks, Jan, I don't see any issues, and will push them to git.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
