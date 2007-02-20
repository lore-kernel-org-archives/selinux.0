Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KKmleF012786
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:48:47 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KKo4Qc000523
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 20:50:04 GMT
Subject: Re: apache.fc references undefined user_cron_spool_t when using
	the strict policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0702181646u72b958cei7ada50920711f9ea@mail.gmail.com>
References: <e739902b0702181646u72b958cei7ada50920711f9ea@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 20:50:17 +0000
Message-Id: <1172004617.20576.241.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-02-18 at 16:46 -0800, Ryan Bradetich wrote:
> Hello all,
> 
> The apache module does not compile in the in the strict policy because
> it references the following type: user_cron_spool_t which does not
> appear to exist any longer.   Since I am not using apache, I just
> commented out the block .. but thought I should pass this information
> on in case someone else has a better fix.
> 
> I have attached a patch with the commented out block for reference.

Its a bug, that line should have been in cron.fc.  I question if that
was the right way to label that file anyway.  So it might be better to
remove it altogether.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
