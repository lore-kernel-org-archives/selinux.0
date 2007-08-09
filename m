From: Paul Moore <paul.moore@hp.com>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>, Joe Nall <joe@nall.com>,
        James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 18:48:41 -0400
Cc: SE Linux <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
References: <46BB84A4.8090804@trustedcs.com>
In-Reply-To: <46BB84A4.8090804@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708091848.42017.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, August 9 2007 5:18:28 pm Darrel Goeddel wrote:
> Agreed.  If the "fallback" context wouldn't actually replace a real peer
> context supplied by the peer itself, this would be useful.  I'm sure it
> can be made to operate this way if this patch set would be deemed the
> way-to-go in the end.

Darrel is right, I believe we can fix up the issues he presented today without 
too much fuss, however, at this point it's not clear to me this patchset 
would be accepted.  I'm happy to keep working on these patches, but I suspect 
it will get an explicit NACK from either James or Stephen; if one or both of 
you could clarify this I would appreciate it.

For better or worse I'm leaving tommorrow, August 10th, on vacation and I 
won't be back in front of a computer until the 20th.  I realized it's a bit 
of a "party-foul" to push a patch out for comments like this then disappear 
for a week, but up until today no one really had much to say about this idea 
so I wasn't quite expecting the discussion we had today ;)

That said, I'm sure you guys will keep talking about this (I hope you do 
anyway), just don't think I'm ignoring you - I'll do that when I get back ;)

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
