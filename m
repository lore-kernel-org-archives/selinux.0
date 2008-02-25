From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH][RFC] remove unused backpointers from security objects
Date: Mon, 25 Feb 2008 10:47:02 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>
References: <Xine.LNX.4.64.0802251524350.2482@us.intercode.com.au> <Xine.LNX.4.64.0802260019570.24574@us.intercode.com.au> <Xine.LNX.4.64.0802260044410.24574@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0802260044410.24574@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802251047.02614.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 25 February 2008 8:47:15 am James Morris wrote:
> On Tue, 26 Feb 2008, James Morris wrote:
> > See updated version below, with the sk pointer (to allow the callee
> > to take the rcu read lock).
>
> Actually, we shouldn't need that lock there, and can directly call
> selinux_netlbl_sk_security_reset, right?

I'm looking at this right now ... based on the idea that you can safely 
read/write 32-bit values without a lock I believe the locking for 
sk_security_struct could use a bit of a tweak.  I'm still 
looking/thinking but I believe we can remove the rcu lock entirely and 
just rework selinux_netlbl_inode_permission() a little bit.

If you can spare a few hours I'll post a RFC patch ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
