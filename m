Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA05374
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 11:04:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA12303
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 15:04:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA12299
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 15:04:24 GMT
Date: Fri, 28 Jun 2002 11:04:19 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Updated OpenSSH
In-Reply-To: <Pine.GSO.4.33.0206281044590.13318-100000@raven>
Message-ID: <Pine.GSO.4.33.0206281059590.13318-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 28 Jun 2002, Stephen Smalley wrote:

> The SELinux patch that I posted should apply cleanly to the openssh-3.4p1
> tar gz file from http://www.openssh.org/portable.html.  In any event, you
> can now obtain a copy of openssh-3.4p1 with the SELinux patch merged from
> the sourceforge CVS tree, under nsa/selinux/utils/openssh-3.4p1.  I have
> also updated the selinux/utils/Makefile in that tree to use 3.4p1 instead
> of 3.1p1, and I have updated the selinux/policy/domains/program/sshd.te
> file to grant sys_chroot and to remove direct transitions to sysadm_t
> (use newrole instead).

By the way, some tips for installing:
1) Don't forget to relabel ssh and sshd after installing the new version.
You can do this quickly by just running 'make relabel' in selinux/utils.
2) Create the sshd user as described in the README.privsep file from the
openssh-3.4p1 directory.
3) Reload your policy after installing the new sshd.te.
4) After doing the above, use run_init to restart sshd.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
