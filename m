Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFSokl026822
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:28:50 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C6D3D215B5
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:28:47 -0400 (EDT)
Message-ID: <1332862097.15547.15.camel@lenny>
Subject: Re: [PATCH 27/73] libselinux: Enable many more gcc warnings for
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Tue, 27 Mar 2012 11:28:17 -0400
In-Reply-To: <4F71D850.20203@redhat.com>
References: <4F71D850.20203@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-27 at 11:10 -0400, Daniel J Walsh wrote:
> This patch looks good to me. acked.

It's kind of ugly to conflate warnings with the control options like
-fasynchronous-unwind-tables -funit-at-a-time

Maybe consider splitting them out?  

Incidentally from the gcc manual:



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
