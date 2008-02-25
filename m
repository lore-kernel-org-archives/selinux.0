Date: Tue, 26 Feb 2008 00:47:15 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH][RFC] remove unused backpointers from security objects
In-Reply-To: <Xine.LNX.4.64.0802260019570.24574@us.intercode.com.au>
Message-ID: <Xine.LNX.4.64.0802260044410.24574@us.intercode.com.au>
References: <Xine.LNX.4.64.0802251524350.2482@us.intercode.com.au>
 <1203944199.2804.142.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0802260019570.24574@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Feb 2008, James Morris wrote:

> See updated version below, with the sk pointer (to allow the callee to 
> take the rcu read lock).

Actually, we shouldn't need that lock there, and can directly call 
selinux_netlbl_sk_security_reset, right?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
