Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8KJUHl6032352
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2011 15:30:19 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8KJUHMF025826
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2011 19:30:18 GMT
Message-ID: <1316547014.6710.5.camel@localhost>
Subject: Re: Role attribute status
From: Eric Paris <eparis@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: qingtao.cao@windriver.com, SELinux Mail List <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>
Date: Tue, 20 Sep 2011 15:30:14 -0400
In-Reply-To: <4E78ABC7.1090306@tresys.com>
References: <4E78ABC7.1090306@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-20 at 11:05 -0400, Christopher J. PeBenito wrote:
> What is the status of the role attribute support?  I've got an
> implementation for Refpolicy, but I don't want to merge it until we're
> fairly sure the bugs have been squashed.

But we won't know about the bugs until you commit it!  Wee Catch-22.

All of the code should be in master and should be working.  I'm making
userspace move a lot faster than it used to, if we find something wrong,
we'll get it fixed.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
