MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: libsemanage patch
Date: Mon, 3 Dec 2007 14:51:22 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801455C46@exchange.columbia.tresys.com>
In-Reply-To: <4754599A.8060605@redhat.com>
References: <4754599A.8060605@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> genhomedircon includes the "\n" in /etc/shells so no shells in the
> /etc/passwd match.

Isn't this going to cause problems if the last line in /etc/shells has
no newline?

Instead of:
    temp[strlen(temp)-1]=0;

I would use:
    temp[strcspn(temp, "\n")] = '\0';

That will overwrite the first newline with a NUL or, if there is no
newline, the terminating NUL will be overwritten with another NUL, which
is harmless.  It is a useful idiom...

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
