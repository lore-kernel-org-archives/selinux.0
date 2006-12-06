Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB6LfkC8005079
	for <selinux@tycho.nsa.gov>; Wed, 6 Dec 2006 16:41:46 -0500
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB6Lf6bn000627
	for <selinux@tycho.nsa.gov>; Wed, 6 Dec 2006 21:41:06 GMT
Received: by an-out-0708.google.com with SMTP id d33so6590and
        for <selinux@tycho.nsa.gov>; Wed, 06 Dec 2006 13:42:14 -0800 (PST)
Message-ID: <e294b46e0612061342k3a4d73gd1abc1e2006e870e@mail.gmail.com>
Date: Wed, 6 Dec 2006 21:42:14 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [RFC] Thunar filesystem manager policy
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1164813311.25344.50.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e294b46e0611221141v650500f7v72f83ecd3573e356@mail.gmail.com>
	 <1164637648.7490.18.camel@sgc.columbia.tresys.com>
	 <e294b46e0611280651w7e9b0f8fp8a321f8c8b40513b@mail.gmail.com>
	 <1164728200.8768.9.camel@sgc.columbia.tresys.com>
	 <e294b46e0611280826m33aaa2bkdf25270cab035c69@mail.gmail.com>
	 <1164813311.25344.50.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. PeBenito,

On 11/29/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> On Tue, 2006-11-28 at 16:26 +0000, Bradley Chapman wrote:
> > On 11/28/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > > That explains the $1_thunar_t, but what about thunar_t?  From the
> > > policy, it looks like a daemon.
> >
> > It is - it gets started by dbus-daemon from staff_dbusd_t when logging
> > into the windowing environment, and runs in the background as a
> > daemon.
>
> That daemon should be running in $1_thunar_t.  Thunar_t would be a
> system daemon.

Which is what I'm trying to do. Unfortunately, for some insane reason,
when the dbus daemon starts Thunar, the latter continues to run in
staff_dbusd_t, which means that the policy is failing to permit a
domain transition from staff_dbusd_t to staff_thunar_t.

How do I fix this?

Brad
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
