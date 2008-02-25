Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PKqwE6005766
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 15:52:58 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PKqweU027912
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 20:52:58 GMT
Subject: Re: Silly audit2allows
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: w.chimiak@ieee.org, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <47C320D9.9030102@redhat.com>
References: <200802251311.09098.w.chimiak@ieee.org>
	 <47C320D9.9030102@redhat.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 15:50:26 -0500
Message-Id: <1203972626.32061.145.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-02-25 at 15:11 -0500, Daniel J Walsh wrote:
> Bill Chimiak wrote:
> > 3. Are any of these potentially dangerous (my apologies if this is a stupid 
> > request)?

> > allow fsdaemon_t urandom_device_t:chr_file read;
> fsdaemon reading /dev/urandom - Not dangerous

Right, not dangerous.  Generally it could only be a problem if you were
concerned about the domain draining all of the entropy in order to DoS
apps that use /dev/random.

> > allow groupadd_t devpts_t:chr_file { read write };
> groupadd read/write of a generice pty. Not dangerous, since what
> groupadd can do is far more dangerous.
[...]
> > allow semanage_t devpts_t:chr_file { read write };
> > allow setfiles_t devpts_t:chr_file { read write };
> > allow useradd_t devpts_t:chr_file { read write };
> All three of these are trying to read/write pty that has generic label.
>  Nothing to worry about since these domains can do much more interesting
> damage.

That's true if you look at as the domain doing malicious things to the
terminal.  Another way to look at it would be that these privileged
domains could be influenced by malicious data they read from a user's
terminal.  So if you don't care about the latter than its not a problem.
If you're running all unconfined users, then you trust the users and it
definitely isn't a problem.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
