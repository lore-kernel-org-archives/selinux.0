Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1OFxCxQ023507
	for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2007 10:59:12 -0500
Received: from wr-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1OG0VOS004830
	for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2007 16:00:32 GMT
Received: by wr-out-0506.google.com with SMTP id i21so1054155wra
        for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2007 08:00:31 -0800 (PST)
Message-ID: <e739902b0702240800i31d0eff3xa50540dfa1e952c2@mail.gmail.com>
Date: Sat, 24 Feb 2007 08:00:30 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: PATCH: Remove redundant role statement from the apache.te file.
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1172247845.15371.58.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702181540r3734cb6bh7c68ed1f9f323d1e@mail.gmail.com>
	 <1172247845.15371.58.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Chris,

Fair enough.  I will reverse this patch from my local tree as well.

Thanks!

- Ryan


On 2/23/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> On Sun, 2007-02-18 at 15:40 -0800, Ryan Bradetich wrote:
> > I am working on writing a policy for the Boa web server.  I am using
> > the SELinux by example book and the apache modules for guidance.
> > Going through the apache.te file I noticed the following entry is
> > redundant:
> >
> >     role system_r types httpd_t;
> >
> > This statement is provided as part of the init_daemon_domain interface
> > in the modules/system/init.if interface file.  Here is the line in the
> > init_daemon_domain interface function:
> >
> >    role system_r types $1;
> >
> > I have attached a patch to remove role entry from the apache.te file.
>
> Since this doesn't hurt anything, I'd rather just leave it since its all
> over the policy right now.  The issue is that if you rely on the
> interface to allow the role the daemon type, you still have to allow the
> role to any subdomains of the daemon (like httpd_sys_script_t)
> explicitly.  This makes the handling of the primary domain and sub
> domains of a daemon slightly inconsistent.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
