Date: Wed, 23 Jan 2013 13:15:51 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Message-ID: <286629059.3171068.1358964951492.JavaMail.root@redhat.com>
In-Reply-To: <51002308.3050709@tycho.nsa.gov>
Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when running
 on ext[234]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That diff looks to be addressing same issue, so there shouldn't
be need for another patch.

I'm guessing we are not using same repo.
$ git remote -v
origin  git://git.selinuxproject.org/~serge/selinux-testsuite.git (fetch)
origin  git://git.selinuxproject.org/~serge/selinux-testsuite.git (push)
$ git pull
Already up-to-date.
$ grep "errno" -r tests/ioctl/
$

Can you share your git uri please?

Regards,
Jan

----- Original Message -----
> From: "Stephen Smalley" <sds@tycho.nsa.gov>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
> Sent: Wednesday, 23 January, 2013 6:51:04 PM
> Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when running on ext[234]
> 
> Odd, I have the following diff locally.
> 
> 
> On 01/23/2013 11:50 AM, Jan Stancek wrote:
> >
> >
> > ----- Original Message -----
> >> From: "Stephen Smalley" <sds@tycho.nsa.gov>
> >> To: "Jan Stancek" <jstancek@redhat.com>
> >> Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
> >> Sent: Wednesday, 23 January, 2013 4:41:38 PM
> >> Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when
> >> running on ext[234]
> >>
> >> On 01/23/2013 08:27 AM, Jan Stancek wrote:
> >>> EXT2_* ioctls are likely to fail on other filesystems,
> >>> for example: xfs.
> >>>
> >>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >>> ---
> >>>    tests/ioctl/Makefile       |    6 ++++++
> >>>    tests/ioctl/test_ioctl.c   |    2 ++
> >>>    tests/ioctl/test_noioctl.c |    2 ++
> >>>    3 files changed, 10 insertions(+), 0 deletions(-)
> >>
> >> Shouldn't really be a compile-time flag but rather a runtime test
> >> of
> >> the
> >> filesystem type, right?  Otherwise it presumes you built it on the
> >> same
> >> system and in the same filesystem where you will run it.
> >
> > Correct, I assumed everyone is running it with 'make test'.
> >
> >>
> >> I thought however that your earlier patch to switch it to using
> >> FS_IOC_
> >> command values would have
> >> addressed the issue of other filesystem types already?  What error
> >> are
> >> you getting from xfs?
> >
> > ioctl(3, FS_IOC32_SETVERSION or FS_IOC_SETVERSION or
> > SONYPI_IOCGBAT1CAP, 0x7fffb5eeac24) = -1 ENOTTY (Inappropriate
> > ioctl for device)
> >
> >> The code already checks for one errno value to
> >> distinguish the not-supported case.
> >
> > I can't see any check for errno in this test:
> > $ grep "errno" -r tests/ioctl/
> > $
> >
> > Regards,
> > Jan
> >
> > --
> > This message was distributed to subscribers of the selinux mailing
> > list.
> > If you no longer wish to subscribe, send mail to
> > majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
