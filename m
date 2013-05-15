From: Paul Moore <paul@paul-moore.com>
To: vlad halilov <vlad.halilov@gmail.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: marking ipv6 loopback for cipsov?
Date: Wed, 15 May 2013 15:29:51 -0400
Message-ID: <21728662.t5NqKJFd2O@sifl>
In-Reply-To: <CAHw9pMXP9FJvFNz7_wGz6mJa5PeYSSv4OfUKJMSBgcPO=1RZmg@mail.gmail.com>
References: <CAHw9pMVv-Q7uZQvd2gJ_AD-FjRGegSWtZFwWH-U85u0vmF3YNw@mail.gmail.com> <1547102.UbLjJyaKNC@sifl> <CAHw9pMXP9FJvFNz7_wGz6mJa5PeYSSv4OfUKJMSBgcPO=1RZmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, May 15, 2013 11:03:25 PM vlad halilov wrote:
> So, i just remove ipv6 support from system and this programm using ipv4
> loopback with normal label processing now :)

Glad you found a solution that is working for you.

> Bug reported https://bugzilla.redhat.com/show_bug.cgi?id=963427

Excellent, thank you.  Hopefully we'll have a fix soon.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
