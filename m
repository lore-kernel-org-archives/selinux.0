Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFsLc5029669
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:54:21 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BE79E20CC8
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:54:20 -0400 (EDT)
Message-ID: <1332863630.15547.22.camel@lenny>
Subject: Re: [PATCH 41/73] policycoreutils: mcstransd: write a pid file FIXME
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Tue, 27 Mar 2012 11:53:50 -0400
In-Reply-To: <4F71E181.80300@redhat.com>
References: <4F71E181.80300@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-27 at 11:49 -0400, Daniel J Walsh wrote:
> This patch looks good to me. acked.
> 
> systemd expects a pid file to be written by unit services.

It doesn't if the service is non-forking.  In fact moving to
non-forking services that don't write pid files is a major
improvement that systemd brings over sysvinit, because the
state is 100% reliable.  Pid files create the possibility
of desynchronization if the service crashes, but the pid
file remains.

So a better fix would be to change mcstransd to have a
--no-fork option, and update the unit file to use it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
