Date: Thu, 12 Feb 2009 09:22:03 -0600
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Peter Staubach <staubach@redhat.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
Subject: Re: [nfsv4] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090212152203.GO9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <4990AD20.3030902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4990AD20.3030902@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 09, 2009 at 05:24:32PM -0500, Peter Staubach wrote:
> Section 3.2 discusses handling if a security attribute is
> changed while a client is holding a delegation to an object.
> The text describes that the client should flush changes to the
> server and relinquish the delegation.  Why?  Is access to an
> open file on the client to be revoked?  What happens on a
> client which does not happen to be holding a delegation at the
> time?
> 
> This leads to a further question concerning client side caching
> of these attributes.  Is the client allowed to do caching?  If
> so, how would it go about doing cache validation?

For DAC POSIX semantics are that open file references are not revoked
when a file's owner/group/permissions (and/or ACL) change.

MAC requires some sort of revocation.  This can happen on the
server-side whenever the client tries to access a file after it's been
relabeled.  The client might learn of this pretty late, but given that
the user on the client would have been able to see the contents under
the old label this timing seems to me to be acceptable.

Recalling an open file delegation seems OK as a way to speed that up if
the client can obtain a new delegation if it still has access to the
file.

The only other wrinkle is that multi-user clients need to let the server
perform all access decisions for each user -- the client must not allow
access using local MAC decisions based on cached file labels.

> Section 4.1 includes an XXX reference probably to a draft
> document.  Is this the draft for RPCSEC_GSSAPI v3?

No, it's not.  As David explained, that I-D came later.

> Section 4.1.1 discusses denying a request if a security
> attribute can not be translated from one DOI to another.
> What error should be returned?  It seems to me that a new

IMO NFS4ERR_ACCESS is good enough.

> set of errors may potentially need to be introduced to
> handle the new cases where servers need to inform clients
> exactly what happened.  [...]

Perhaps, but I expect that production servers would return generic
errors like NFS4ERR_ACCESS rather than newfangled ones like, say,
NFS4ERR_NODOITRANS.  There's no need to tell the client too much about
why its request failed.  It suffices that access was denied, and for
that NFS4ERR_ACCESS is good enough.

> Section 4.2.1 discusses a smart client and the need for a
> common DOI.  Could a client not implement its own translations
> for the DOIs that it may choose to know about?

It could.

> Anyway, enough for the time being.  I think that some more
> detailed definitions and declarations need to be specified
> in order to move along.

Defnitely.

Thanks for the comments!

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
