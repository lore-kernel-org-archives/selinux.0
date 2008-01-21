Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0LDRirt010659
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 08:27:44 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0LDRgQ6022106
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 13:27:42 GMT
Subject: Re: SystemHigh
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30801181312j352b60efuebb87ace244adbcb@mail.gmail.com>
References: <dd18b0c30801181312j352b60efuebb87ace244adbcb@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Jan 2008 08:26:09 -0500
Message-Id: <1200921969.4595.53.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-01-18 at 13:12 -0800, Justin Mattock wrote:
> Hello; With playing around with refpolicy everything seems good. Now
> with the help of you guys converting to mls policy and changing levels
> seems to be pretty nice.
> But after googling and reading some posts about starting the xserver
> issuing startx seems to be not an option with mls. So is there a work
> around with this. 
> from what I'm seeing  if I startx from
> sysadm_r:sysadm_t:s0-s15:c0.c255 (SystemLow-SystemHigh) most of the
> avc's are taken care of, except for
> system_u:object_r:memory_device_t:s15:c0.c255 (SystemHigh) /dev/mem.
> Then if I reboot and use newrole -r sysadm_r -l s15: c0.c255 && startx
> I receive a list of avc's that seem to not disappear even after adding
> them, Is there a boolean to configure? 
> If there is no solution to this or if mls wasn't designed for
> startingX then i'll leave it as is. 

The MLS configuration doesn't include desktop X support at the moment.
The policy was configured and tested for the LSPP certification, but a
desktop was not part of the configuration.
              
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
