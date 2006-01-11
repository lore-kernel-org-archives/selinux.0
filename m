Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0BFsSXf026169
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 10:54:28 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0BFrNm0013907
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 15:53:23 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43C3C187.50502@redhat.com>
References: <43C3C187.50502@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 10:55:01 -0500
Message-Id: <1136994901.29815.149.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-10 at 09:15 -0500, Daniel J Walsh wrote:
> Lots of new kernel_read_proc_devices which was needed for the latest 
> rawhide.

Why does /proc/devices need a different type?  Its not writable, and its
content doesn't seem to warrant a new type.

> Major changes to hostname policy.  Basically I don't want anything 
> except dhcpc to transition to hostname domain.  Everything else should 
> just executed it.  You don't need the extra privs and stuff like 
> redirection causes to many problems

This is fine, but I think that the transition from init scripts should
be kept.  If there is a static IP, wouldn't the init scripts need to set
the hostname?  If we don't keep the transition in this case, we'd need
to add sys_admin to initrc_t (which was the original reason for the
hostname policy, if I remember right).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
