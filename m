Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6M0ZW7a028508
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 20:35:32 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6M0ZVmn026029
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 00:35:31 GMT
Received: by wa-out-1112.google.com with SMTP id k17so849843waf.0
        for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 17:35:30 -0700 (PDT)
Message-ID: <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com>
Date: Mon, 21 Jul 2008 20:35:30 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Andrew Warner" <warner@rubix.com>
Subject: Re: questions about persistent storage of security contexts
Cc: selinux@tycho.nsa.gov
In-Reply-To: <48851770.5020002@rubix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48851770.5020002@rubix.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 21, 2008 at 7:10 PM, Andrew Warner <warner@rubix.com> wrote:
> Hello,
>
> I am currently developing an "SELinux aware" DBMS (primarily TE and MLS)
> that is characterized by:
>
> 1. The need to store a security context (in some recoverable form) in our
> persistent database (storage size of the context is an important factor)
> 2. The need to frequently perform a high number of security access checks in
> a performance sensitive way
>
> My question relates to the first characteristic from above. I am having
> trouble deciding on the best way to store the security context in the
> database. From my research I  see (I think!) three different representations
> for a security context: 1) string; 2) raw; 3) SID.
>
> The string representation, generally, seems clear as this is what is shown
> in all documentation as the context representation that exists in user
> space. My only question regarding the string representation is: is there is
> any hard limit to the length of the security context string? Do I need to
> allow for no theoretical size limit on a context string if I choose to store
> it?

No hard limit that I can think of. There might be one somewhere but I
wouldn't count on it.

> I am inferring the the raw representation exists from seeing *_raw functions
> (e.g., security_compute_create_raw) referenced in selinux header files.
> Other than seeing these functions declared I am having trouble finding out
> much about a raw representation. Is there any advantage to
> storing/manipulating a context in its raw representation? That is, are they
> more suited for a fast security access check, are they smaller in size, or
> do they have a fixed or maximum length?

The _raw is actually what you want.  _raw basically just means strings
without any translations from things like mcstransd.  Given a context
like user_u:role_r:type_t the "raw" on an MLS system maybe
"user_u:object_r:type_t::s0."  Throwing a context with the MLS portion
attched at the !raw functions will work just fine.

> The SID I have also seen mentioned in various documentations but can
> determine little about them. My guess is that they are an integer value that
> is used for fast internal access, particularly for the AVC. Are SIDs indeed
> integer values? Are they persistent or are they meaningful only for a
> particular OS session?

That's exactly what they are.  They are kernel internal integer
representations that are (for the most part) only meaningful for that
session.  There are some 'initial sids' that are always the same, but
no userspace app should care about 'sids' in the general sense.

> I have also considered maintaining my own internal, persistent mapping
> between string based contexts and an integer representation, the mapping
> being stored/indexed inside the DBMS. This gives me a small storage overhead
> with a fixed size.

I don't have a problem with internal mapping like that.

But, don't we already have sepostgresql?  Maybe you should be looking
to see if that fits your needs or you might get ideas from the work
that they performed?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
