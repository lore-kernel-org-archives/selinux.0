From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC PATCH 0/2] Series short description
Date: Wed, 26 Sep 2007 16:46:29 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <200709261304.20745.paul.moore@hp.com> <46FAC381.5010208@manicmethod.com>
In-Reply-To: <46FAC381.5010208@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261646.29704.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 September 2007 4:39:29 pm Joshua Brindle wrote:
> So.. how are we going to determine if the policy is capable of doing
> peersid reconciliation? Is this going to be a user flag or is there an
> object class it can depend on?

In this case we can probably key off the existence of the yet to be 
defined "peer" class.  Although we might want/need a more general way of 
setting the capability bitmap in the future.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
