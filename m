Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NI3IxK023313
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 13:03:18 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NI4b0Z011522
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 18:04:37 GMT
Subject: Re: apache.fc references undefined user_cron_spool_t when using
	the strict policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0702201948k5d7d998enc2f2ca1c794a4d68@mail.gmail.com>
References: <e739902b0702181646u72b958cei7ada50920711f9ea@mail.gmail.com>
	 <1172004617.20576.241.camel@sgc.columbia.tresys.com>
	 <e739902b0702201948k5d7d998enc2f2ca1c794a4d68@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 13:04:52 -0500
Message-Id: <1172253892.15371.67.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 19:48 -0800, Ryan Bradetich wrote:
> I have updated my patch to remove the entry from the apache.fc file.

Thanks, merged.

> On 2/20/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > Its a bug, that line should have been in cron.fc.  I question if that
> > was the right way to label that file anyway.  So it might be better to
> > remove it altogether.
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
