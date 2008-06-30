Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UCP38Y002799
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 08:25:03 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5UCP36k026383
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:25:03 GMT
Subject: Re: mls support for xserver
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30806281523h6263237sfdb9061a13f8e167@mail.gmail.com>
References: <dd18b0c30806281523h6263237sfdb9061a13f8e167@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 30 Jun 2008 08:23:40 -0400
Message-Id: <1214828620.5242.27.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-06-28 at 22:23 +0000, Justin Mattock wrote:
> Hello; after seeing all of these posts about xserver I couldn't help
> but to try MLS policy.
> As the same results a few months back it seems there isn't any support
> for this policy yet to work with xserver is there?
> i.g. from what I see after allowing most of the avc's, I'm left with
> these that seem to keep appearing upon a reboot:
> 
> allow insmod_t kernel_t:process setsched;
> allow kernel_t bluetooth_t:socket write;
> allow sysadm_sudo_t devpts_t:dir search;
> allow sysadm_xserver_t memory_device_t:chr_file { read write };
> <------  I can't start X without this one here.
> allow syslogd_t var_log_t:file append;
> 
> I think it's the same with hid2hci --tohci upon wakeup, the ioctl or
> node is changed resulting in a new avc's for that device.
> Is there going to be support to use MLS in the future or is it too
> much of a security risk.(xserver).

The X server only has relatively well tested TE policy right now, and
only in the non object manager sense.  The object manager TE policy is
still early and needs more time to mature.  The MLS policy for the X
server is being looked at now, but still has a ways to go.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
