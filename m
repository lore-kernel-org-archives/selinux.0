Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8J7V0AH001945
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 03:31:00 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8J7U5xU021195
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 07:30:05 GMT
Received: by wx-out-0506.google.com with SMTP id i26so4934068wxd
        for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 00:31:00 -0700 (PDT)
Message-ID: <6a9b0ede0609190031p7f7610cfy87d8c54ab90a32d4@mail.gmail.com>
Date: Tue, 19 Sep 2006 13:01:00 +0530
From: "abcde efghi" <svmdcv@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: disabling selinux
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1158337309.18951.9.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <6a9b0ede0609140355i4eeb58a7na4306260bdff7d72@mail.gmail.com>
	 <1158235692.25629.25.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609142230u6db9a10fqf4f4059e7a90695e@mail.gmail.com>
	 <1158337309.18951.9.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

my tests are failing bcoz i have disabled selinux post-install
should i do any changes to filesystems then also?
and what other things i need to do once i disable selinux which  was
enabled during installation?


thanks
satish

On 9/15/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2006-09-15 at 11:00 +0530, abcde efghi wrote:
> > hi Stephen
> >
> > let me tell u the first basic pbm
> >
> > oracle Db(database) creation fails when selinux is enabled during run
> > time which was disabled during installation on RHEL4u4 (kernel version
> > = 2.6.9-39.ELhugemem i686 GNU/Linux )
> >
> > does enabling selinux during run time has same feature of selinux
> > enabled during installation?
>
> Keep mail on list, please, so that others can benefit and the discussion
> is archived for future queries.
>
> To answer your question though, yes, there is nothing magical about
> enabling SELinux at install time vs. turning it on later post-install.
> The only thing you need to do in the post-install case is to label the
> filesystems, which it should actually do automatically the first time
> you boot with SELinux enabled.  If not, you can touch /.autorelabel and
> reboot to force it to relabel, or boot with 'autorelabel' in the kernel
> command line.
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
