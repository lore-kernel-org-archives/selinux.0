Subject: Re: module that checks each access
From: Stephen Smalley <sds@tycho.nsa.gov>
To: mina elnino <potushka@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <f7d5075c0908050609g59705ba4y88a55963c4f4f5f8@mail.gmail.com>
References: <f7d5075c0908050609g59705ba4y88a55963c4f4f5f8@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 05 Aug 2009 09:34:15 -0400
Message-Id: <1249479255.21455.47.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-08-05 at 17:39 +0430, mina elnino wrote:
> dear list,
> i need to know if there is a special module in source code of selinux
> which is responsible to check every access to resources of the system.
> i mean is there a specific function that reads binary policy file and
> according to it, grants or prohibits the action.
> regards.

Sounds like you need to do some reading on the architecture and
implementation of SELinux, e.g.:
http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.shtml
http://www.nsa.gov/research/_files/selinux/papers/module-abs.shtml

The SELinux by Example book may be a useful resource.

You may find this recent thread to be informative:
http://marc.info/?t=124816978000005&r=1&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
