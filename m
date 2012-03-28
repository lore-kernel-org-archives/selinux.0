Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2SGOsCB011192
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 12:24:54 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 17E2B21562
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 12:24:54 -0400 (EDT)
Message-ID: <1332951864.15547.29.camel@lenny>
Subject: Re: [PATCH 41/73] policycoreutils: mcstransd: write a pid file FIXME
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Wed, 28 Mar 2012 12:24:24 -0400
In-Reply-To: <4F7200C7.4060008@redhat.com>
References: <4F71E181.80300@redhat.com> <1332863630.15547.22.camel@lenny>
	 <4F7200C7.4060008@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The naming here is confusing...the C variable should be called
"daemonize" or "do_fork" or something.

+       if (foreground && daemon(0, 0)) {

Would then be:

if (!foreground && daemon(0, 0))

Right?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
