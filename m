Date: Tue, 26 Feb 2008 09:28:36 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: sds@tycho.nsa.gov, eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: Correct the NetLabel locking for the
 sk_security_struct
In-Reply-To: <20080225164033.31345.24622.stgit@flek.americas.hpqcorp.net>
Message-ID: <Xine.LNX.4.64.0802260924370.24764@us.intercode.com.au>
References: <Xine.LNX.4.64.0802260044410.24574@us.intercode.com.au>
 <20080225164033.31345.24622.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Feb 2008, Paul Moore wrote:

> The RCU/spinlock locking approach for the nlbl_state in the sk_security_struct
> was almost certainly overkill.  This patch removes both the RCU and spinlock
> locking, relying on the existing socket locks to handle the case of multiple
> writers.  This change also makes several code reductions possible.

Ok, the other thing to be concerned with is instruction reordering, and 
the possible need for memory barriers, which should be covered in this 
case by the memory barriers provided by the existing socket locks.

I'll apply this to for-akpm and then a revised version of the backpointer 
removal patch.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
