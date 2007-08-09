Message-ID: <46BB2785.8040507@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov, joe@nall.com,
        James Morris <jmorris@namei.org>, Eric Paris
	 <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 10:41:09 -0400 
MIME-Version: 1.0
in-reply-to: <200708090929.16906.paul.moore@hp.com>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Thursday 09 August 2007 8:42:43 am Stephen Smalley wrote:
>> I like the functionality, but I don't like having yet another mechanism
>> and configuration, and I'm concerned about it being netlabel-centric.
> 
> NetLabel has always been designed as a framework to support multiple
different 
> types of labeling protocols/mechanisms.  Adding this bit of functionality
to 
> NetLabel isn't a major departure from the existing architecture.  The only

> real substantial changes to the underlying NetLabel framework are the
passing 
> of the IP address family to some of the NetLabel APIs (minor tweak) and
the 
> addition of a secid field to the NetLabel security attributes struct (also
a 
> pretty minor tweak).
> 
> I'm also a little confused about your concern over this new feature being 
> NetLabel-centric?  I guess I don't understand how that is a problem,
further 
> explanation might help ...

I actually have a question regarding this.  This all seems to be aimed at
getting
getpeercon to always return our "best knowledge" of what the peer's context
actually
is.  This is excellent - we need this functionality.  getpeercon will return
the
xfrm label (which is, by mechanism, the context of the peer) if labeled
ipsec is
being used, correct?  netlabel will then modify that label with it's own
idea
of the peer, correct?  Doesn't that mean a secret peer (using labeled ipsec)
will
now actually look like a top_secret peer if there is a "fallback" that
specifies
this host as top_secret?  I think this is currently a problem with
"fighting"
mechanism that attempt to give information regarding the peer.  There is no
consistency between them.  A true fallback would have to occur *before* any
peer
provided label information would be processed.  I also think that there must
be consistency forced between the different peer labeling mechanisms.  If I
get
packets that are specified as top_secret via CIPSO over an ipsec association
labeled as user_u:user_r:user_t:secret, that packet should die.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
