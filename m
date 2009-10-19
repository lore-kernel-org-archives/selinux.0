Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9J5Pjeb028865
	for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2009 01:25:45 -0400
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9J5OqA8001841
	for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2009 05:24:53 GMT
Message-ID: <4ADBF832.8070001@ak.jp.nec.com>
Date: Mon, 19 Oct 2009 14:25:06 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: michel m <michel.mcgregor@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: bounds domain
References: <bb74313d0910170111r1fd7f59cl3556e59be1d2f7a8@mail.gmail.com>
In-Reply-To: <bb74313d0910170111r1fd7f59cl3556e59be1d2f7a8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

michel m wrote:
> hi,
> 
> as I was studying on how to assign different security context on
> threads defined in a process, I found that there is a concept named
> BOUNDS DOMAIN which does this for me.
> now I would like to know for implementing a userspace object manager
> that uses this mechanism for its threads, how requests for OS
> resources are protected. that is, if my single OS process changes its
> security context per thread request or I should consult AVC before any
> action taken by my threads if that action is legal.

I seems to me you are confusing about different two concepts.
The one is bounds-domain, the other is userspace object manager.

Once a thread changes its domain to the bounded one, its privileges
are more restrictive than the original domain. Then, SELinux checks
the given actions based on the restricted privileges.

> I should consult AVC before any
> action taken by my threads if that action is legal.

It goes against to the assumption of SELinux.
How do you make sure the checks are well comprehensive?
Since it is near to impossible to check and eliminate any bugs in
userspace, so we check violated accesses in kernel space.

As long as your application does not manage shared objects in userspace,
you don't need to consult userspace AVC before actions.

> is there any documentation on this topic?

You can set a new domain on the thread using setcon(3) API.
The only difference from dynamic domain transition is that
the newer domain has to be bounded by the older domain.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
