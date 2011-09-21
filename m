Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8LDP6Ox025902
	for <selinux@tycho.nsa.gov>; Wed, 21 Sep 2011 09:25:06 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8LDP5SS003738
	for <selinux@tycho.nsa.gov>; Wed, 21 Sep 2011 13:25:05 GMT
Message-ID: <4E79E5B0.2020402@tresys.com>
Date: Wed, 21 Sep 2011 09:25:04 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: <qingtao.cao@windriver.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>
Subject: Re: Role attribute status
References: <4E78ABC7.1090306@tresys.com> <1316547014.6710.5.camel@localhost>
In-Reply-To: <1316547014.6710.5.camel@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/20/11 15:30, Eric Paris wrote:
> On Tue, 2011-09-20 at 11:05 -0400, Christopher J. PeBenito wrote:
>> What is the status of the role attribute support?  I've got an
>> implementation for Refpolicy, but I don't want to merge it until we're
>> fairly sure the bugs have been squashed.
> 
> But we won't know about the bugs until you commit it!  Wee Catch-22.
> 
> All of the code should be in master and should be working.  I'm making
> userspace move a lot faster than it used to, if we find something wrong,
> we'll get it fixed.

Ok, its all been committed, so beware!

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
