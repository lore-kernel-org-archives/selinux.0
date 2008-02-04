MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libsemanage: free policydb before fork
Date: Mon, 4 Feb 2008 10:44:25 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181EEE8@exchange.columbia.tresys.com>
In-Reply-To: <47A6367F.5040609@manicmethod.com>
References: <47A5311F.2020703@manicmethod.com> <47A6367F.5040609@manicmethod.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Interestingly this works sometimes and not others. I suppose it
> depends on whether the libc allocator feels like giving up the memory
> when we free the policydb or not. I am not sure what the best way to
> address this is, any ideas?

You might try calling malloc_stats() before you free the policydb and
see how the stats differ in the two cases.  We may also be able to tune
malloc via mallopt().  I would guess that mmap()'d data is more likely
to be returned to the system so we might try reducing M_MMAP_THRESHOLD
from 128K to a smaller amount (maybe try 64K).  The flip side of this
is M_TRIM_THRESHOLD (which also defaults to 128K).  A lower value of
M_TRIM_THRESHOLD will result in malloc() returning sbrk()'d memory
back to the system more often.  So, there are knobs we can twiddle--
I just don't know how likely they are to help.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
