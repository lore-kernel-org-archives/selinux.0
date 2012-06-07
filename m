MIME-Version: 1.0
In-Reply-To: <2008897.ahYGsh5Elr@sifl>
References: <1339003731-6743-1-git-send-email-cpebenito@tresys.com>
	<2470358.yNoEqIjIIh@sifl>
	<4FD0D1FF.5070702@tresys.com>
	<2008897.ahYGsh5Elr@sifl>
Date: Thu, 7 Jun 2012 13:43:47 -0400
Message-ID: <CACLa4ptxWaidOZ6kk0=oh1p3PO_M=UQisLRvjpXn7bE+=P821Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Update SELinux policy capability to always check peer class.
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul@paul-moore.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 7, 2012 at 12:52 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Thursday, June 07, 2012 12:08:31 PM Christopher J. PeBenito wrote:

> I'm also curious if you are going to do anything about incorporating the
> secmark configuration into the greater SELinux policy.  As far as I'm
> concerned, that is the only way I would consider ack'ing these patches (I did
> mention this in the original thread).

As soon as this series covers all paths I am willing to take it, even
over Paul's larger objection.  I don't think what Paul wants makes
enough sense to warrant not allowing enforcement in the face of a
mislabeled system.  Sorry Paul.  That doesn't mean I wouldn't be happy
to see something along those lines, but I think allowing people to use
and control the system the way we have it today trumps some potential
work tomorrow.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
