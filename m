From: Paul Moore <paul.moore@hp.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Fix a potentially uninitialised variable in SELinux hooks
Date: Wed, 9 Jul 2008 18:47:14 -0400
Cc: sds@tycho.nsa.gov, jmorris@namei.org, selinux@tycho.nsa.gov
References: <200807091821.46296.paul.moore@hp.com> <20080709161043.24255.62312.stgit@warthog.procyon.org.uk> <8198.1215643142@redhat.com>
In-Reply-To: <8198.1215643142@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807091847.14347.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 July 2008 6:39:02 pm David Howells wrote:
> Paul Moore <paul.moore@hp.com> wrote:
> > I haven't checked but I'm pretty sure that would fix the problem
> > you are seeing, yes?
>
> Maybe.  The problem, I think, is that the error handling path
> diverges from the main path and then converges again, and the
> compiler can't tell which way it's going to go.

Ah yes, my apologies.

> Besides, this way eliminates an if-statement.  I noticed that addrp
> was never passed as NULL, but I was unsure as to whether this will
> always be the case.

Well, it's a rather simple, local function so I'm not too concerned 
about what _might_ happen; I'm focusing more on what we have right now.  
For me personally, I'm not a huge fan of adding more variables and 
extra assignments to work around the problem; I'd prefer to fix it like 
this if we can ...

	ret = selinux_parse_skb_ipv4(...);
	if (ret != 0)
		addrp = (src ? ...);
	else
		addrp = NULL;

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
