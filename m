Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h69I3AHa025332
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 14:03:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h69I39H5013713
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 18:03:09 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h69I39RX013710 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 18:03:09 GMT
Subject: Re: context trouble with 2.5 bits
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1057769928.28674.134.camel@columbia>
References: <1057701768.25921.53.camel@columbia>
	 <1057752105.13738.10.camel@moss-huskers.epoch.ncsc.mil>
	 <1057769928.28674.134.camel@columbia>
Content-Type: text/plain
Message-Id: <1057773788.13738.181.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jul 2003 14:03:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-07-09 at 12:58, Colin Walters wrote:
> On Wed, 2003-07-09 at 08:01, Stephen Smalley wrote:
> 
> > Did you remember to mount selinuxfs on /selinux, as described in the
> > selinux-doc README?  Otherwise, the daemons cannot obtain security
> > policy decisions from the kernel, such as the new label for the tty.
> 
> Yes, I've done that.

Try running the compute_relabel utility from libselinux, e.g.:

$ compute_relabel root:sysadm_r:sysadm_t system_u:object_r:tty_device_t chr_file

It should display something like:
root:object_r:sysadm_tty_device_t

If that works, then check what login is actually passing to
security_compute_relabel, e.g. is the user context a valid context?  is
the tty context that is being passed correct?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
