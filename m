Subject: Re: [PATCH 0/6] SELinux UNIX domain socket fixes/cleanup
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        James
 Morris <jmorris@namei.org>
In-Reply-To: <201006031652.51531.paul.moore@hp.com>
References: <20100529214628.4042.88276.stgit@flek.lan>
	 <201006031652.51531.paul.moore@hp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Jun 2010 17:12:37 -0400
Message-ID: <1275599557.2828.1.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-06-03 at 16:52 -0400, Paul Moore wrote:
> On Saturday, May 29, 2010 05:53:16 pm Paul Moore wrote:

> > For those of you using git, you can also find a copy of the patches at
> > the URL below.
> > 
> >  * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing
> > 
> > Thanks.
> 
> Thoughts?  Comments?  ACKs?  NACKs?

I looked over the whole series and was good with them except I didn't
know/understand the netlbl changes at the bottom of the first patch.  I
kept telling myself I was going to dig out the code and verify it's
correctness but I haven't yet.  Any chance you could explain what that
change is all about to make it easier for me to verify it is correct?

Patches 2-6 I'm ok adding my ACK to.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
