From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [patch 2/2] Peersid capability support
Date: Wed, 7 Nov 2007 16:54:34 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20071107205047.102519666@manicmethod.com> <1194469634.3956.174.camel@moss-spartans.epoch.ncsc.mil> <47322CCB.4020801@manicmethod.com>
In-Reply-To: <47322CCB.4020801@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711071654.34141.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 07 November 2007 4:23:23 pm Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-11-07 at 15:50 -0500, Joshua Brindle wrote:
> >> plain text document attachment (peersid_cap.patch)
> >> Peersid capability support, keys the peersid capability on the peer
> >> object class.
> >
> > I'm uneasy about this approach, as it is similar to what we originally
> > tried for secmark - tying the compat_net setting to the presence of the
> > packet class in the policy, except there we were doing it at policy load
> > time.  As it turned out, we had policies that defined the packet class
> > well before we had usable rule sets for them, and even if we had covered
> > that angle, presence/absence of a class definition doesn't reflect
> > policy writer intent (e.g. does he want legacy network controls or
> > secmark irrespective of whether he is using a modern policy), so we went
> > back to manual setting of compat_net.
> >
> > What if the base.conf / policy.conf itself had an explicit declaration
> > of the capabilities to be enabled?  We can certainly do sanity checks
> > too (e.g. if they ask for this capability but haven't defined the
> > requisite class, that's a bug in their policy), but that would let
> > someone use the latest policy flask definitions but still select what
> > they want to enable/disable explicitly, and no unwitting enabling of
> > capabilities by side effect.
>
> I just implemented the last thing I saw in the capability bitmap thread,
> and what Paul had thought the behavior was going to be.
>
> I'm not expecting every capability to be keyed off an object class so I
> wasn't sure how to best enable them in a general way anyway.

Josh and I talked about this a little offline before he posted the patch and 
while we agreed this wasn't the best solution we were at a loss of how to do 
it the "right way".  Actually, I'm not even sure what the "right way" is ...

I like the idea of requiring the policy to explicitly turn on/off 
capabilities.  Further, I like the idea of the policy defining what 
capabilities are available and within those constraints allowing specific 
capabilities to be selected at policy load time.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
