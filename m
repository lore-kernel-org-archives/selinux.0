Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03G3PlD004908
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 11:03:25 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m03G3L61022310
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 16:03:21 GMT
Subject: Re: cant SSH/Console Login and no deny/error messages
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1198704909.4073.858.camel@bluejay.goodinassociates.com>
References: <1198704909.4073.858.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 11:02:20 -0500
Message-Id: <1199376140.12626.307.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-26 at 15:35 -0600, Jeremiah Jahn wrote:
> I've trying to get SELinux strict up and running on a RHEL4-U4 box and
> not having much luck. I have one account and 3 programs that I need to
> protect from root. I was unable to get targeted to login under the user
> that I created, something about the policy always defaulting to user_u.
> So Fine, I tried to install the strict/ref policy from the tresys and
> cips. Dues to this being an x86_64 system, that didn't go well either.
> Trying plan C  I went with the FC3 strict policy. Obviously some
> improvemtns have been made since then, but this was the first strict
> policy I was able to install without completely hosing my system. sshd
> and login seem to really like having libselinux(64) around. 
> 
> 
> So my question here has to possible answers:
> 
> 1) where the heck can I find some rpms for RHEl4 -x86_64 and the most
> recent ref policy.

I don't know of any 64bit RHEL4 RPMs.  The refpolicy page has an RPM,
but its for the complete source; I presume you're asking for a compiled
policy, which we don't have.

> 2) what could possibly be causing no [avc denied] messages to be logged.
> Most of the messages I have used with audit2allow to to try and get
> everything to work. Finally I go to the point of having no more messages
> even when rebooting the machine. If I put things into passive mode
> still no more messages, this is with constant reloading of the policy to
> clear the avc cache. 

Perms that are denied by DAC (regular linux perms) don't produce
messages.  DAC is checked before MAC (SELinux), so if something is
denied by DAC, it never gets to the MAC check.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
