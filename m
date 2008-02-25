Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PEG2cr015065
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 09:16:02 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PEG1a4002200
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:16:01 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [refpolicy] rsyslogd, rklogd and Debian
Date: Mon, 25 Feb 2008 09:10:01 -0500
Message-ID: <1203948601.32061.48.camel@gorn>
In-Reply-To: <1203774072.2694.8.camel@vogon>
References: <1203774072.2694.8.camel@vogon>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stefan Schulze Frielinghaus" <stefan@seekline.net>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-02-23 at 14:41 +0100, Stefan Schulze Frielinghaus wrote:
> You can find rsyslogd and rklogd under /usr/sbin instead of /sbin like
> Fedora does.
> 
> Attached patch adds the file context especially for Debian. But I would
> recommend a clean up of the whole file. Because several entries exist
> for klogd in /sbin and /usr/sbin and so on. It's not really consistent.

I added the entries and did some revising.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
