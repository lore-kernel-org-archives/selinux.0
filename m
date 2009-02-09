Message-ID: <4990AD20.3030902@redhat.com>
Date: Mon, 09 Feb 2009 17:24:32 -0500
From: Peter Staubach <staubach@redhat.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org, nfsv4@ietf.org,
        nfs-discuss@opensolaris.org
Subject: Re: New MAC label support Internet Draft posted to IETF website
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> Hello,
>    I have just posted a new document for the MAC labeling support work
> to the IETF website. It contains a lot of clarifying text that has been
> asked for by several people in the IETF community. I would like to ask
> that people give it a look over and provide comments if possible. I
> would prefer that discussion takes place on the NFSv4 WG mailing list
> since it shows interest in the technology which is what the WG is
> currently looking for. If you have any questions regarding the text or
> the system outlined in it email me and I'll be more than happy to help
> with any confusion. I am hoping to drum up enough interest in the work
> to request that it be added to the NFSv4 WG charter at the next IETF
> meeting. If you are interested in the work and would like to participate
> or just think that it is a worthwhile technology and would like to see
> it added to the NFSv4 standard feel free to speak up. 
>
> The information for the document which I received in the conformation
> email and a link to it can be found below.
>
> Dave Quigley
>
>
> A new version of I-D, draft-quigley-nfsv4-sec-label-00.txt has been
> successfuly submitted by David Quigley and posted to the IETF
> repository.
>
> Filename:        draft-quigley-nfsv4-sec-label
> Revision:        00
> Title:           MAC Security Label Support for NFSv4
> Creation_date:   2009-01-22
> WG ID:           Independent Submission
> Number_of_pages: 12
>
> Abstract:
> This Internet-Draft describes additions to NFSv4 minor version one to
> support Mandatory Access Control systems.  The current draft
> describes the mechanism for transporting a MAC security label using
> the NFSv4.1 protocol and the semantics required for that label.  In
> addition to this it describes an example system of using this label
> in a fully MAC aware environment.
>                                                                                   
>
>
> The IETF Secretariat.
>
> http://www.ietf.org/internet-drafts/draft-quigley-nfsv4-sec-label-00.txt

I have been looking at the document and have some comments,
questions, and suggestions --

In section 1, MAC is defined, but perhaps it might be useful for
NFS folks to expand upon the definition just a tad.  For example,
how is this different than normal access control and why?  Perhaps
I am dense, but the text in Section 3 might make better sense if
I understood a little more about MAC at a high level.

In Section 3, there is discussion of using a recommended attribute
to store the security attribute.  A request is made for security
attribute number 76.  This one appears to be used already in the
NFSv4.1 specification.  Perhaps this should be flagged so that it
can be updated appropriate when this specification is included
into a larger, NFSv4.2, document?

In Section 3.1, DOI is defined for a third time.  The acronym can
probably just be used here.  That said, providing a little more
detail on how a DOI would be represented would be useful.  Is it
a 32 bit unsigned integer or something else?  Perhaps including
a pseudo description of the syntax of the security_attribute
would be good.

Section 3.2 discusses handling if a security attribute is
changed while a client is holding a delegation to an object.
The text describes that the client should flush changes to the
server and relinquish the delegation.  Why?  Is access to an
open file on the client to be revoked?  What happens on a
client which does not happen to be holding a delegation at the
time?

This leads to a further question concerning client side caching
of these attributes.  Is the client allowed to do caching?  If
so, how would it go about doing cache validation?

Section 4.1 includes an XXX reference probably to a draft
document.  Is this the draft for RPCSEC_GSSAPI v3?

Section 4.1.1 discusses denying a request if a security
attribute can not be translated from one DOI to another.
What error should be returned?  It seems to me that a new
set of errors may potentially need to be introduced to
handle the new cases where servers need to inform clients
exactly what happened.  Section 4.1.2 is missing a period
on the end of the second paragraph.  Perhaps this is the
intended error to be returned?

Section 4.2.1 discusses a smart client and the need for a
common DOI.  Could a client not implement its own translations
for the DOIs that it may choose to know about?

Section requests an IANA registry for DOIs.  Perhaps document
like, draft-ietf-nfsv4-rpc-netid-06.txt, previously circulated
by Michael Eisler, will need to be constructed to handle the
issue.

---

Anyway, enough for the time being.  I think that some more
detailed definitions and declarations need to be specified
in order to move along.

    Thanx...

       ps


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
