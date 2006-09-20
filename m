Subject: Re: disabling selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: abcde efghi <svmdcv@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6a9b0ede0609190852y4fe7cffqbb97178c008abe3b@mail.gmail.com>
References: <6a9b0ede0609140355i4eeb58a7na4306260bdff7d72@mail.gmail.com>
	 <1158235692.25629.25.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609142230u6db9a10fqf4f4059e7a90695e@mail.gmail.com>
	 <1158337309.18951.9.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609190031p7f7610cfy87d8c54ab90a32d4@mail.gmail.com>
	 <1158671354.15340.41.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609190852y4fe7cffqbb97178c008abe3b@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 14:36:23 -0400
Message-Id: <1158777383.15340.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-19 at 21:22 +0530, abcde efghi wrote:
> i am running some stress tests(oracle+linux) like mem-pressure and
> mem-leak(if u want i can give more detail on these tests,) on Rhel4
> with selinux enabled during installation, they are working fine, if i
> disable selinux during boot time or run time these tests are
> failing.and if i am running same tests on same machine with selinux
> disabled during installation and enabled during post-install , these
> tests are failing
> 
> note: i am not doing any relabling on any filesystems whenever i am
> switching from enabling to disabling and vice-versa
> 
> these tests are running fine if i am not changing selinux during runtime
> 
> i want to get clarified on two things
> 
> 1) do i need to relable filesystems once i chnage selinux state from
> enforce(enabled) to disable and vice-versa

Only when changing from disabled to enabled.  To cause a relabel,
touch /.autorelabel and boot with selinux enabled.  It is done from
rc.sysinit.  Or you can do it manually by running fixfiles relabel.

> 2) if so what are all the filesystems i need to re-lable and how(any doc's)?

The fixfiles script will handle it for you; just run fixfiles relabel,
or touch /.autorelabel and reboot.

But I don't understand why such tests would fail with SELinux disabled.
With SELinux enabled and unlabeled files, you could run into permission
denials that would prevent them from running properly, but with SELinux
disabled, there should be no effect.  Again, what do you mean by
"failing"?  What output do you get from them?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
