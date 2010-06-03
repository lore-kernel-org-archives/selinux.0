From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 0/6] SELinux UNIX domain socket fixes/cleanup
Date: Thu, 3 Jun 2010 17:44:14 -0400
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
References: <20100529214628.4042.88276.stgit@flek.lan> <201006031652.51531.paul.moore@hp.com> <1275599557.2828.1.camel@localhost>
In-Reply-To: <1275599557.2828.1.camel@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201006031744.14365.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, June 03, 2010 05:12:37 pm Eric Paris wrote:
> On Thu, 2010-06-03 at 16:52 -0400, Paul Moore wrote:
> > On Saturday, May 29, 2010 05:53:16 pm Paul Moore wrote:
> > > For those of you using git, you can also find a copy of the patches at
> > > the URL below.
> > > 
> > >  * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing
> > > 
> > > Thanks.
> > 
> > Thoughts?  Comments?  ACKs?  NACKs?
> 
> I looked over the whole series and was good with them except I didn't
> know/understand the netlbl changes at the bottom of the first patch.  I
> kept telling myself I was going to dig out the code and verify it's
> correctness but I haven't yet.  Any chance you could explain what that
> change is all about to make it easier for me to verify it is correct?

Sure, let me give it a shot - I assume you're talking about the changes to 
selinux_netlbl_sk_security_reset()?  Assuming the answer is "yes", the reason 
is that before it's inclusion in selinux_inode_setsecurity() it was always 
called from functions operating on newly allocated sk_security_structs and as 
a result it didn't need to worry about any old per-socket cached values (look 
at selinux_netlbl_sock_genattr() to see what I mean about cached values and 
sksec->nlbl_secattr).  The change to selinux_netlbl_sk_security_reset() is to 
check if a cache value exists and if it does clear it out before we relabel 
the socket.

Anything else you're fuzzy on?  I can't promise my explanations will help but 
I can try ;)

> Patches 2-6 I'm ok adding my ACK to.....

Thanks!

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
