Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4SGniEH002412
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 12:49:44 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4SGngTv023828
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 16:49:43 GMT
Received: by nf-out-0910.google.com with SMTP id f5so1537319nfh.4
        for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 09:49:41 -0700 (PDT)
Message-ID: <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
Date: Wed, 28 May 2008 11:42:50 -0500
From: "Joe Nall" <joe@nall.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: rbacsep: collapsing xserver
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
In-Reply-To: <1211990530.5008.127.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 28, 2008 at 11:02 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Wed, 2008-05-28 at 10:16 -0500, Joe Nall wrote:
>> On Wed, May 28, 2008 at 9:38 AM, Christopher J. PeBenito
>> <cpebenito@tresys.com> wrote:
>> > I've got to the point where I am collapsing the derived types in the
>> > xserver module.  It would be nice to collapse all of the X server
>> > domains into xserver_t, but we have xdm_xserver_t which has permissions
>> > greater than user_xserver_t, staff_server_t, etc.  However, just about
>> > everyone runs their xserver in xdm_xserver_t due to logging in via xdm.
>> > Thoughts on collapsing all of the xservers anyway?
>>
>> Why is the way the xserver gets launched important once it is running?
>
> If you log into the console and run startx, your xserver is
> user_xserver_t, staff_xserver_t, etc.  ﻿If you log in via a display
> manager, your xserver is xdm_xserver_t, since the server is started by
> xdm before a user logs in.  So you lose separation if you log in via
> xdm.

Understood.

> There have been suggestions about either restarting the xserver or
> dyntransitioning it to the correct context after logging in, but nothing
> materialized on that.
>
>> Does that change when X is an object manager?
>
> No.

Poorly worded question. _Should_ that change when X is a object manager?

What is the driver for the derived types? User preference files in
their home directory?

>
>> On a related topic, what is the type enforcement strategy for window managers?
>
> They currently run in the user's context.  The basic templates in the
> policy should still allow for separations.  The policy for X objects is
> still immature, so I'm definitely open to suggestions.

I did some brief experiments with the X server in MLS enforcing mode a
while back and it looked like a separate type would be required to
avoid giving the user silly levels of privilege. I'll try to get back
to those experiments next week.

Any opinions on spitting the display manager (gdm/xdm) policy out of
the xserver policy? The current xserver policy is quite a bit bigger
than apache and several times the average policy size (te + if).

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
