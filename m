MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libsemanage: free policydb before fork
Date: Mon, 4 Feb 2008 11:05:22 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181EEF3@exchange.columbia.tresys.com>
References: <47A5311F.2020703@manicmethod.com> <47A6367F.5040609@manicmethod.com> 
From: "Todd Miller" <Tmiller@tresys.com>
To: "Todd Miller" <tmiller@tresys.com>,
        "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> You might try calling malloc_stats() before you free the policydb and
> see how the stats differ in the two cases.

Actually, the info returned by mallinfo() may be more useful.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
