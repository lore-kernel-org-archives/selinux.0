Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05265
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 10:54:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA22118
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 14:53:08 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA22114 for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 14:53:08 GMT
Date: Fri, 28 Jun 2002 10:54:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Updated OpenSSH
In-Reply-To: <1025274102.1597.1.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0206281044590.13318-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 28 Jun 2002, Justin Smith wrote:

> Is there a place where one can get the complete source coded of the
> updates OpenSSH? The patch doesn't work for me (no doubt because I
> haven't been keeping up with the previous patches).

The SELinux patch that I posted should apply cleanly to the openssh-3.4p1
tar gz file from http://www.openssh.org/portable.html.  In any event, you
can now obtain a copy of openssh-3.4p1 with the SELinux patch merged from
the sourceforge CVS tree, under nsa/selinux/utils/openssh-3.4p1.  I have
also updated the selinux/utils/Makefile in that tree to use 3.4p1 instead
of 3.1p1, and I have updated the selinux/policy/domains/program/sshd.te
file to grant sys_chroot and to remove direct transitions to sysadm_t
(use newrole instead).

The sourceforge CVS tree can be accessed via :

export
CVSROOT=:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux
cvs -z3 co nsa/selinux

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
