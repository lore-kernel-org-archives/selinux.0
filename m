From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/6] SELinux UNIX domain socket fixes/cleanup
Date: Thu, 3 Jun 2010 16:52:51 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
References: <20100529214628.4042.88276.stgit@flek.lan>
In-Reply-To: <20100529214628.4042.88276.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201006031652.51531.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday, May 29, 2010 05:53:16 pm Paul Moore wrote:
> I finally got a chance to cobble together some tests to verify both
> getpeercon() on the client end of a connected UNIX domain socket as well
> as the proper operation of fsetxattr() on sockets.  I'm happy to report
> that everything worked as I expected it to (UNIX sockets now behave like
> INET sockets) and nothing exploded.  This latest version of the patchset
> should include all the feedback I've received so far as well as my
> sign-off on each patch so I think we should be in good shape at this
> point.  As a result, I'm submitting these patches for whatever kernel
> release looks most appropriate - maybe to late for .35, but you might
> be able to make a weak argument that some of the patches are
> bugfixes - regardless, I'll let you guys make that call; as long as
> they go somewhere I'll be happy.
> 
> For those of you using git, you can also find a copy of the patches at
> the URL below.
> 
>  * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing
> 
> Thanks.

Thoughts?  Comments?  ACKs?  NACKs?

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
