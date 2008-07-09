From: David Howells <dhowells@redhat.com>
In-Reply-To: <200807091821.46296.paul.moore@hp.com>
References: <200807091821.46296.paul.moore@hp.com> <20080709161043.24255.62312.stgit@warthog.procyon.org.uk>
To: Paul Moore <paul.moore@hp.com>
Cc: dhowells@redhat.com, sds@tycho.nsa.gov, jmorris@namei.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix a potentially uninitialised variable in SELinux hooks
Date: Wed, 09 Jul 2008 23:39:02 +0100
Message-ID: <8198.1215643142@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore <paul.moore@hp.com> wrote:

> I haven't checked but I'm pretty sure that would fix the problem you are 
> seeing, yes?

Maybe.  The problem, I think, is that the error handling path diverges from
the main path and then converges again, and the compiler can't tell which way
it's going to go.

Besides, this way eliminates an if-statement.  I noticed that addrp was never
passed as NULL, but I was unsure as to whether this will always be the case.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
