Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3NHgUkE022654
	for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2007 13:42:30 -0400
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3NHgSJ5013417
	for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2007 17:42:29 GMT
Date: Mon, 23 Apr 2007 13:42:26 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Ken YANG <spng.yang@gmail.com>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: can not boot with strict policy
In-Reply-To: <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0704231341100.3793@d.namei>
References: <462CA1F0.2000400@gmail.com> <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 23 Apr 2007, Stephen Smalley wrote:

> /lib/libsepol.so.1 should be labeled with shlib_t, not lib_t.  Under
> targeted policy, they are aliases for one another.  Under strict, they
> are separate types.
> 
> Boot with "enforcing=0 single" to come up permissive into single-user
> mode, then run /sbin/fixfiles relabel -F to forcible relabel everything,
> then reboot.

I wonder if we could automate this, so that the autorelabel is also run 
on boot if you switch between different types of policy.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
