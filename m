From: Paul Moore <paul.moore@hp.com>
To: "Todd Miller" <Tmiller@tresys.com>
Subject: Re: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion functions
Date: Fri, 29 Feb 2008 13:58:56 -0500
Cc: "James Antill" <james.antill@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net> <200802291203.40204.paul.moore@hp.com> <6FE441CD9F0C0C479F2D88F959B015880195CD04@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880195CD04@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802291358.57146.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 February 2008 1:41:54 pm Todd Miller wrote:
> Paul Moore wrote:
> > The strlcpy() implementation does a strlen() and a memcpy() call
> > along with two comparisons and some trivial math.  The strcat()
> > implementation does pretty much the same thing but with less
> > comparisons and no additional math.  The strcpy() implementation
> > only does a byte-by-byte copy which should be faster then strlcpy()
> > even when one factors in an optimized memcpy() implementation due
> > to the strlen() call.
>
> The difference is that with strcat() you are also finding the length
> of dest whereas which strlcpy() you only need to find the length of
> src.

True, strcat() does do a strlen() on dest while strlcpy() does a 
strlen() on src and in this case dest is almost always going to be 
bigger then src.

> I really doubt it makes a measurable difference and things may 
> be muddied by gcc inlining some of the standard str* functions.

Agree.

Also, (this starts getting into architecture specifics) on x86 (not 
x86_64) I'm pretty sure all function arguments are passed on the stack 
and strlcpy() requires three arguments versus strcat()/strcpy() which 
require only two.  However, at this point I think the argument is 
starting to get a bit ridiculous.

> However, you definately do not need the final strlen(ctx) in either
> case since you know that *scontext_len - 1 == strlen(ctx).

Disagree.  At the point in time of the final strlen(ctx) call ctx looks 
like this (note the lack of MLS range):

    user_u:role_r:type_t

... where as scontext_len is equal to the strlen() of the full context 
(MLS included).  The results of strlen(*scontext) and *scontext_len are 
not the same until after the call to mls_sid_to_context().

> I'm not sanctioning James' abuse of strlcpy(); I think it is
> pointless to try and guess which is faster without actually
> benchmarking it.

Yep ... slow news day and this discussion seems a lot safer then the 
current labeled NFS discussion ;)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
