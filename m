Message-ID: <48EB0B75.1030108@ak.jp.nec.com>
Date: Tue, 07 Oct 2008 16:10:45 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
Subject: Re: typebounds lookup from userspace
References: <48D3B220.1060903@manicmethod.com>
In-Reply-To: <48D3B220.1060903@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> For symbol labeling purposes for policy access control we need to be able
 > to look up symbol hierarchy relationships. I expect we'll do this by exporting
 > the symbol hierarchy via selinuxfs. Does anyone have suggestions on what that
 > should look like? Do we want to export additional information on the symbols
 > at the same time?

I noticed that userspace object manager also need an interface to get metadata
of types to support permissive domain. Currently, we don't have any interface
to know what domain should be handled as permissive domain.

If "/selinux/access" can return the 6th value to show whether the given query
should be handled as permissive domain or not, it helps userspace object managers.

It is undesirable for me to add a new interface to query whether the given domain
is permissive or not, because it cannot avoid atomicity matter.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
