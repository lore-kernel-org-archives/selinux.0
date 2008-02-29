MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion functions
Date: Fri, 29 Feb 2008 13:41:54 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880195CD04@exchange.columbia.tresys.com>
In-Reply-To: <200802291203.40204.paul.moore@hp.com>
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net> <1204294426.31790.256.camel@moss-spartans.epoch.ncsc.mil> <1204303255.11268.326.camel@code.and.org> <200802291203.40204.paul.moore@hp.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Paul Moore" <paul.moore@hp.com>, "James Antill" <james.antill@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> The strlcpy() implementation does a strlen() and a memcpy() call along
> with two comparisons and some trivial math.  The strcat()
> implementation does pretty much the same thing but with less
> comparisons and no additional math.  The strcpy() implementation only
> does a byte-by-byte copy which should be faster then strlcpy() even
> when one factors in an optimized memcpy() implementation due to the
> strlen() call.

The difference is that with strcat() you are also finding the length
of dest whereas which strlcpy() you only need to find the length of
src.  I really doubt it makes a measurable difference and things may
be muddied by gcc inlining some of the standard str* functions.

However, you definately do not need the final strlen(ctx) in either
case since you know that *scontext_len - 1 == strlen(ctx).

I'm not sanctioning James' abuse of strlcpy(); I think it is pointless
to try and guess which is faster without actually benchmarking it.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
