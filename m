From: Paul Moore <paul@paul-moore.com>
To: vlad halilov <vlad.halilov@gmail.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: marking ipv6 loopback for cipsov?
Date: Wed, 15 May 2013 09:48:02 -0400
Message-ID: <1547102.UbLjJyaKNC@sifl>
In-Reply-To: <CAHw9pMVv-Q7uZQvd2gJ_AD-FjRGegSWtZFwWH-U85u0vmF3YNw@mail.gmail.com>
References: <CAHw9pMVv-Q7uZQvd2gJ_AD-FjRGegSWtZFwWH-U85u0vmF3YNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, May 15, 2013 11:57:34 AM vlad halilov wrote:
> Hello guyz. Is any way to mark traffic for ipv6 loopback interface as
> 'cipso'?

CIPSO is an IPv4-only protocol, CALIPSO/RFC5570 is a similar protocol for IPv6 
but unfortunately I have not yet finished its Linux/SELinux implementation.

On RHEL6.4 if you want to use labeled networking for IPv6 addresses you can 
either use the NetLabel static/fallback labeling or labeled IPsec (yes, you 
can use IPsec over loopback with some tweaking, but it is not an ideal 
solution).

> p.s.  btw, i tried to make something fool action, like 'netlabelctl map add
> default address:::/128 protocol:cipsov4,32' and get kernel bug .. :)  is
> these result need to be reported or no?

Ouch, that's not good.  I'll take a look at that, but since this is on RHEL6.4 
I would highly recommend you file a bug with the Red Hat's Bugzilla.

 * http://bugzilla.redhat.com

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
