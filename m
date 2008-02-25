Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PJOIAZ022342
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:24:18 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PJOEqv015121
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 19:24:14 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [refpolicy] dovecot.fc.patch (resend)
Date: Mon, 25 Feb 2008 14:20:23 -0500
Message-ID: <1203967223.32061.92.camel@gorn>
In-Reply-To: <1203950973.5535.11.camel@vogon>
References: <1203789897.2668.5.camel@vogon> <1203948348.32061.45.camel@gorn> <1203950973.5535.11.camel@vogon>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stefan Schulze Frielinghaus" <stefan@seekline.net>
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-02-25 at 15:49 +0100, Stefan Schulze Frielinghaus wrote:
> Yeah I forgot to attach the other patches. Now all three patches should
> be included. If they get accepted I will open a bugzilla entry to get
> them backported to RHEL5.
> 
> On Mon, 2008-02-25 at 09:05 -0500, Christopher J. PeBenito wrote:
> > On Sat, 2008-02-23 at 19:04 +0100, Stefan Schulze Frielinghaus wrote:
> > > Dovecot needs a hard link and therefor a special label.
> > > 
> > > I resend this patch. For background have a look at this thread:
> > > http://marc.info/?l=selinux&m=118830456207512&w=2
> > 
> > This still needs the dontaudit for initrc_t that you were speaking of.

I tweaked the interface name, otherwise, merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
