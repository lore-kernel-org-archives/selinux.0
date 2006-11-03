Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>, "Paul Moore" <paul.moore@hp.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Fri, 3 Nov 2006 09:12:35 -0600
Message-ID: <001a01c6ff5a$7eb99970$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514A65@exchange.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > using the packet label (either secmark or external, how do you
> > > decide?)
> >
> > Both.
>
> It calls avc_has_perm for both labels? How will netlabel fit
> in?

Yes.

> What do
> you expect the performance hit to be with so many avc lookups?
>

I believe the avc has been well-optimized lately.

> > > to see if it should drop (or is it
> > > reject? Can
> > > you choose?).
> >
> > Yes. You should be able to.
> >
>
> So you just pass an additional parameter to the selinux
> module? I assume
> you aren't going to try to use TE policy to choose.

Can you reframe your original question? I am afraid I misunderstood
it when I answered.

>
> <snip>
> >
> > > With these
> > > filter rules if
> > > they aren't in place the policy becomes less restrictive
> (right?)..
> >
> > We could also be restrictive or leave it up to the policy entirely.
> >
>
> So if there is no rule present it would always check against unlabeled
> (or some initial SID)?

Yes. I think this would be the simpler approach for now.

> Can you force the selinux module to be called
> under all circumstances?

Yes, in the proposal we are looking at here, the module will be called
from within netfilter when there are explicit secfilter rules as well as
when none have been found in which case there would be a check against
unlabeled. Is this what you meant to ask?

>
> This is starting to sound pretty reasonable. The filter rules
> really are
> policy

They are a really a labeling policy just like in the secmark case.
Here we would label the filter points as opposed to packets.

> they just aren't TE policy, and they are also tightly
> bound to a
> particular TE policy.

If you meant the "particular" portion of the policy that would
have the allow rules, etc., to enforce secfilter, yes.

>
> This is different from other object managers because their "policy" is
> static, they always ask the question at some point in the codepath
> wheras you want to implement a dynamic policy to query the security
> server.

I am not sure I understand. This is completely analogous to how the
filesystem
checks work. Just like how file contexts live on the File System, secfilter
contexts live (just like secmark labels) in the netfilter subsystem
efficiently
looked up by the iptables framework. Just like how the various portions of
the
FS code call into LSM, so would netfilter/secfilter.

> I don't think there is anything wrong with it but the
> ramifications need to be examined, synchronicity is probably
> going to be
> the hardest thing to solve.

Could you please eleborate on the synchronicity issues and how these are
absent/resolved for the FS case?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
