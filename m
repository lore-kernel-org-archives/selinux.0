Date: Fri, 29 Jul 2005 15:05:00 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Lynx.SEL.4.62.0507291504330.12480@thoron.boston.redhat.com>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Jul 2005, Stephen Smalley wrote:

> - I didn't increment the policy version again for this patch set,
> so it is still version 20, as with the prior patch set.  If we
> were to upstream these patches separately, I'd split them into separate
> versions, but if we roll them up for a single upstream change, there is
> no reason to separate them.

I would suggest rolling them into one policy version change.


- James
-- 
James Morris
<jmorris@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
