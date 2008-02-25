Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PEAEe4014697
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 09:10:14 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PEADa4000662
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:10:13 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [refpolicy] dovecot.fc.patch (resend)
Date: Mon, 25 Feb 2008 09:05:48 -0500
Message-ID: <1203948348.32061.45.camel@gorn>
In-Reply-To: <1203789897.2668.5.camel@vogon>
References: <1203789897.2668.5.camel@vogon>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stefan Schulze Frielinghaus" <stefan@seekline.net>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-02-23 at 19:04 +0100, Stefan Schulze Frielinghaus wrote:
> Dovecot needs a hard link and therefor a special label.
> 
> I resend this patch. For background have a look at this thread:
> http://marc.info/?l=selinux&m=118830456207512&w=2

This still needs the dontaudit for initrc_t that you were speaking of.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
