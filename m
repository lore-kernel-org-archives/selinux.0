Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATFEokk018765
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 10:14:50 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kATFE8wt019791
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:14:08 GMT
Subject: Re: [RFC] Thunar filesystem manager policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Bradley Chapman <kakadu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0611280826m33aaa2bkdf25270cab035c69@mail.gmail.com>
References: <e294b46e0611221141v650500f7v72f83ecd3573e356@mail.gmail.com>
	 <1164637648.7490.18.camel@sgc.columbia.tresys.com>
	 <e294b46e0611280651w7e9b0f8fp8a321f8c8b40513b@mail.gmail.com>
	 <1164728200.8768.9.camel@sgc.columbia.tresys.com>
	 <e294b46e0611280826m33aaa2bkdf25270cab035c69@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 10:15:11 -0500
Message-Id: <1164813311.25344.50.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-28 at 16:26 +0000, Bradley Chapman wrote:
> On 11/28/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > That explains the $1_thunar_t, but what about thunar_t?  From the
> > policy, it looks like a daemon.
> 
> It is - it gets started by dbus-daemon from staff_dbusd_t when logging
> into the windowing environment, and runs in the background as a
> daemon.

That daemon should be running in $1_thunar_t.  Thunar_t would be a
system daemon.

> > >  thunar_etc_t, OTOH, was
> > > added mainly because I didn't want to give Thunar full access to /etc.
> >
> > It seems very odd to me that a user application would be writing to
> > files in /etc.
> 
> But it does - /etc/xdg/Thunar/uca.xml is the file in question.

That's unfortunate, it sounds very broken to me that a user program
writes to a global config file.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
