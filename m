Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1BNoJsN012590
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 18:50:19 -0500
Subject: Re: New MAC label support Internet Draft posted to IETF website
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Peter Staubach <staubach@redhat.com>
Cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org, nfsv4@ietf.org,
        nfs-discuss@opensolaris.org
In-Reply-To: <4990AD20.3030902@redhat.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
	 <4990AD20.3030902@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 18:47:44 -0500
Message-Id: <1234396064.2929.121.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-02-09 at 17:24 -0500, Peter Staubach wrote:
> 
> I have been looking at the document and have some comments,
> questions, and suggestions --
> 
> In section 1, MAC is defined, but perhaps it might be useful for
> NFS folks to expand upon the definition just a tad.  For example,
> how is this different than normal access control and why?  Perhaps
> I am dense, but the text in Section 3 might make better sense if
> I understood a little more about MAC at a high level.

I will make an attempt to clarify this. I was trying to get a concise
definition into the draft without bogging it down with a whole bunch of
Access Control theory. However, if it isn't clear enough then I do need
to fix this.

> 
> In Section 3, there is discussion of using a recommended attribute
> to store the security attribute.  A request is made for security
> attribute number 76.  This one appears to be used already in the
> NFSv4.1 specification.  Perhaps this should be flagged so that it
> can be updated appropriate when this specification is included
> into a larger, NFSv4.2, document?

Hmm I picked that number from what I thought was an earlier v4.1
document. It's possible that I was looking at 4.0 proper instead. I
asked about grabbing a number a while back and someone said just take
one and we can fix it up later. A question for the WG is if there is a
proper procedure for this? Should I leave it blank with some sort of
marker like Peter suggests or is it as simple of just pick one for now
and we'll deal with conflicts if/when it gets chartered.

> 
> In Section 3.1, DOI is defined for a third time.  The acronym can
> probably just be used here.  That said, providing a little more
> detail on how a DOI would be represented would be useful.  Is it
> a 32 bit unsigned integer or something else?  Perhaps including
> a pseudo description of the syntax of the security_attribute
> would be good.

It seems reasonable at this point that the person will know what DOI
stands for and if not they can look it up in the terms section. There
are a few people doing transport layer work that have a definition of a
DOI. I originally had a marker in there that we should have a normative
reference to a draft about DOIs. The structure that most people seem to
be happy with is a 32 bit number that can be thought of as a series of 4
octets. This allows it to be easily partitioned into ranges for private
used among other things. The CALIPSO guys have a good starting point for
this and we talked about it at the DOI BOF last IETF. The consensus at
that meeting was that we should convene a full BOF to discuss it at a
future IETF. Between the Labeled IPSec drafts that are slowly making
their way to the IETF, the CALIPSO draft which is already far along, and
the Labeled NFS work we should probably have a standard definition for
DOIs including how they are registered, represented, what ranges are
reserved and for what purposed, etc. 

Even if this information is pulled in from a normative reference it
doesn't seem like a bad idea to explain part of it in this document. 

> 
> Section 3.2 discusses handling if a security attribute is
> changed while a client is holding a delegation to an object.
> The text describes that the client should flush changes to the
> server and relinquish the delegation.  Why?  Is access to an
> open file on the client to be revoked?  What happens on a
> client which does not happen to be holding a delegation at the
> time?

Well, this is standard behavior for delegation within NFSv4. If the
security label is changed from under a client you have an issue where it
could still be making local cached access decisions based on a label
that is now out of date. This may not be as stringent of a requirement
with DAC permissions but with MAC it's very important because the system
may be mediating read and write calls in addition to just open calls. If
the client doesn't have a delegation then it shouldn't have an open file
handle for the file. So when it opens the file it will get the valid
label.

Hmm, the text here seems a bit ambiguous. What I mean to say here is
that the label on the server changes while the client is holding the
delegation. There is a case to say that if it changes on the client that
if you really want to guarantee the file is protected on the server that
you shouldn't maintain local cached security attribute changes. However
it's not completely clear to me how the exported FS should react with
processes local to the server making access to files.

> 
> This leads to a further question concerning client side caching
> of these attributes.  Is the client allowed to do caching?  If
> so, how would it go about doing cache validation?

So as of right now we do standard attribute timeouts. In the Linux case
this is 5 seconds by default. I spoke with Nico briefly a while back
about this and he said what might be needed here was to provide some
sort of open file handle revocation support. In the past people have
suggested building the client's idea of the label into either the
stateid or some other form of cookie that can be verified by the server.
We explored doing this in the form of an NFSv4 op and while that worked
we are trying to shy away from adding new operations if we can help it.
I'm still open to potential solutions to this problem. 

> 
> Section 4.1 includes an XXX reference probably to a draft
> document.  Is this the draft for RPCSEC_GSSAPI v3?

That's exactly what it is referencing. I think the reason I left that
was because Nico hadn't posted it to the IETF website as a P-ID when I
had released this. It was made public but I don't think it was
submitted.

> 
> Section 4.1.1 discusses denying a request if a security
> attribute can not be translated from one DOI to another.
> What error should be returned?  It seems to me that a new
> set of errors may potentially need to be introduced to
> handle the new cases where servers need to inform clients
> exactly what happened.  Section 4.1.2 is missing a period
> on the end of the second paragraph.  Perhaps this is the
> intended error to be returned?

The error mentioned in 4.1.1 is the one referenced in 4.1.2
(NFS4ERR_ACCESS). I'll put it in section 4.1.1 as well if it makes
things clearer. I am open to adding a NFS4ERR_MACACCESS code or
something similar to that to provide additional information to
administrators as to why things are failing. I make mention in 4.3.2
that an administrator should be aware when he gets an access failure
using this functionality that it can possibly be caused by the MAC
policy. I probably need to find a better location for this tidbit of
information.

> 
> Section 4.2.1 discusses a smart client and the need for a
> common DOI.  Could a client not implement its own translations
> for the DOIs that it may choose to know about?

We made a decision that in an environment where the server just operates
as a dumb storage medium that it would bring huge problems to store the
DOI with the label. So in this kind of environment the security
attributes are stored without a DOI on the server so it isn't possible
to have those translations take place. The second half of that section
says why we made that decision. I should add to the security attribute
section that when an attribute shows up without the @DOI portion of the
string it should be treated as the null DOI. Either that or we should
atleast force these storage boxes to append @0 into the attribute. 

> 
> Section requests an IANA registry for DOIs.  Perhaps document
> like, draft-ietf-nfsv4-rpc-netid-06.txt, previously circulated
> by Michael Eisler, will need to be constructed to handle the
> issue.

I'll take a look into this document to see what we can learn from it.

> 
> ---
> 
> Anyway, enough for the time being.  I think that some more
> detailed definitions and declarations need to be specified
> in order to move along.

I noticed you didn't make any comments regarding section 5. This was the
most recent section added because some WG members expressed a desire to
see an extensive example of the system. Did you not comment because you
think its acceptable or are comments on that being put off till after I
address these. Also a question for the WG. Is that section effective in
providing understanding of the system? Is there something else that it
needs to contain? Are there ambiguities that I'm not seeing because I
have a background in the area?

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
