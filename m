Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8JFqRHi014499
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 11:52:27 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8JFpUWK015101
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 15:51:31 GMT
Received: by wx-out-0506.google.com with SMTP id i26so5078870wxd
        for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 08:52:25 -0700 (PDT)
Message-ID: <6a9b0ede0609190852y4fe7cffqbb97178c008abe3b@mail.gmail.com>
Date: Tue, 19 Sep 2006 21:22:25 +0530
From: "abcde efghi" <svmdcv@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: disabling selinux
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1158671354.15340.41.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <6a9b0ede0609140355i4eeb58a7na4306260bdff7d72@mail.gmail.com>
	 <1158235692.25629.25.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609142230u6db9a10fqf4f4059e7a90695e@mail.gmail.com>
	 <1158337309.18951.9.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609190031p7f7610cfy87d8c54ab90a32d4@mail.gmail.com>
	 <1158671354.15340.41.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i am running some stress tests(oracle+linux) like mem-pressure and
mem-leak(if u want i can give more detail on these tests,) on Rhel4
with selinux enabled during installation, they are working fine, if i
disable selinux during boot time or run time these tests are
failing.and if i am running same tests on same machine with selinux
disabled during installation and enabled during post-install , these
tests are failing

note: i am not doing any relabling on any filesystems whenever i am
switching from enabling to disabling and vice-versa

these tests are running fine if i am not changing selinux during runtime

i want to get clarified on two things

1) do i need to relable filesystems once i chnage selinux state from
enforce(enabled) to disable and vice-versa
2) if so what are all the filesystems i need to re-lable and how(any doc's)?

thanks
satish


On 9/19/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2006-09-19 at 13:01 +0530, abcde efghi wrote:
> > my tests are failing bcoz i have disabled selinux post-install
> > should i do any changes to filesystems then also?
> > and what other things i need to do once i disable selinux which  was
> > enabled during installation?
>
> - What tests?
> - How are they failing?
> - What makes you think it has anything to do with SELinux?
> - If you disable SELinux, then it is disabled.  End of story.  Nothing
> more to do.
> - If you want to re-enable SELinux, you will need to relabel your
> filesystems.
> - You can check the status of SELinux by running /usr/sbin/sestatus.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
