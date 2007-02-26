Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QIGQhY014331
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 13:16:26 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QIHlPM019741
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 18:17:48 GMT
Subject: Re: smartmon needs to be able to write to physical devices.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB2DC9.40001@redhat.com>
References: <45DB2DC9.40001@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 13:18:04 -0500
Message-Id: <1172513884.22224.3.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 12:20 -0500, Daniel J Walsh wrote:
> Needs to write to SystemLow, for logs, tmp files.

I've been thinking about this for a while.  Shouldn't this instead be
running at system high since its purpose is to monitor the hard disks?
It's temp files and pid files should also be at system high, and it
doesn't have its own logs, it uses syslog.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
