Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2UG06YE028512
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 11:00:06 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2UFwLwL009661
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 15:58:21 GMT
Subject: Re: Latest policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442AEEF3.70406@redhat.com>
References: <442AEEF3.70406@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 11:00:15 -0500
Message-Id: <1143734415.13732.51.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-29 at 15:32 -0500, Daniel J Walsh wrote:
> Added restorecond policy
> fixed samba_selinux man page
> logwatch looks for mounted files system on /mnt
> file context for yumex
> groupadd and useradd need to read nsswitch
> hplib_port_t needed for 9100
> add 6000 as valid xserver port
> pam console needs to getattr/setattr usb_dev
> bluetooth tools want to read resolver
> hplib_t fixes to work with additional devices (Usb  printers
> dovecot wants to talk to postgresql and use inotify
> hal needs to comunicate with ntp
> pegasus needs to connect to random non reserved ports
> privoxy wants to use nscd and communicate with tor
> xfs needs to read fonts in usr_t
> fstools need to be able to work with blk devices.  (fsck)
> libmpg123 is moving
> mount using some certificates stored in usr_t

Merged.

> setfiles needs trans_lock

I dropped this; I'm pretty sure its related to the leaked file
descriptors in semodule too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
