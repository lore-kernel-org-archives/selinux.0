Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h421EmI4014013
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 21:14:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h421El7R017695
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 01:14:47 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h421EhKP017692 for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 01:14:45 GMT
Date: Fri, 2 May 2003 11:14:36 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: Re: kernel crashes
Message-ID: <20030502011436.GD17896@snoopy.apana.org.au>
References: <20030501022414.GA13019@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030501022414.GA13019@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 01, 2003 at 12:24:14PM +1000, Brian May wrote:
> [1] Interesting enough, in this setup, my computer no longer seems to
> be crashing.... I have since loaded a policy and it still hasn't crashed
> yet. Hmmm.. I think I will need to track try and isolate this further.
> I wonder if it will survive a reboot...

If I boot 2.4.20 and load the SE-Linux policy *after* it boots, there
are no problems. This is after several days (if not weeks actually)
after building lots of packages, daily cron jobs, etc.

If I boot 2.4.20 *with* the SE-Linux policy it crashes after 5
to 30 minutes.

It is not a CPU starvation issue, it is more like every call to exec
results in the process hanging. The 2nd time it happens, the process
cannot be killed.

However, just to make matters more confusing, some processes do hang,
but others don't. Most noteable, was exec's would die if run via a ssh
session. I was almost about to say that it was sshd's fault, but then I
killed all copies of ssh (which correctly closed all connections), and
typed in sync, and sync hanged.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
