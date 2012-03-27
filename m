Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFvrFw029916
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:57:53 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EAFAF2074A
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:57:52 -0400 (EDT)
Message-ID: <1332863842.15547.25.camel@lenny>
Subject: Re: [PATCH 43/73] libselinux: avc_netlink_recieve handle EINTR FIXME
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Tue, 27 Mar 2012 11:57:22 -0400
In-Reply-To: <4F71E1DD.4040803@redhat.com>
References: <4F71E1DD.4040803@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-27 at 11:50 -0400, Daniel J Walsh wrote:
> This patch looks good to me. acked.
> 
> I think we should do this rather then have applications like dbus
> randomly crash, and people not notice it for years.

Handling of EINTR is a very interesting thing in operating systems.
For example, the Python interpreter relies on receiving EINTR
from system calls when you press Control-C at the toplevel.

However in this case the AVC thread is hidden from the consumer, so
it's clearly correct to retry on EINTR.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
