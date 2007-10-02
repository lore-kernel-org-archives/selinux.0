Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92LLAXD020338
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 17:21:10 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92LL9dd003679
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 21:21:09 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: [RFC PATCH v3 2/2] [SELINUX] Better integration between peer labeling subsystems
Date: Tue, 2 Oct 2007 16:58:33 -0400
Cc: selinux@tycho.nsa.gov
References: <20071002183121.24760.92916.stgit@flek.americas.hpqcorp.net> <20071002183737.24760.64673.stgit@flek.americas.hpqcorp.net> <7e0fb38c0710021253x4c3a9bd2sd8006934801c2f74@mail.gmail.com>
In-Reply-To: <7e0fb38c0710021253x4c3a9bd2sd8006934801c2f74@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710021658.33949.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 October 2007 3:39:42 pm Eric Paris wrote:
> On 10/2/07, Paul Moore <paul.moore@hp.com> wrote:
> > +       if (!ss_initialized || !selinux_mls_enabled) {
> > +               *peer_sid = SECSID_NULL;
> > +               return 0;
> > +       }
>
> Is it possible for both netlbl_sid and xfrm_sid to be != SECSID_NULL
> if !ss_initialized?  What label to packets get while !ss_initialized?

Hmmm ... so you're thinking ss_initialized is redundant here.  Good catch.  
Looking at the NetLabel secattr_to_sid code in ss/services.c you're right - 
it has it's own ss_initialized check which will always result in netlbl_sid 
== SECSID_NULL when the security server is not initialized.  While I don't 
quickly see something similar in the labeled XFRM code I suspect it would get 
tripped up on the context_to_sid and sid_to_context calls.  Regardless, we 
only need one to be SECSID_NULL and netlbl_sid would catch it so you're 
right - out with the check (and in with a comment so we don't wonder later 
why it's not there).

> The selinux_mls_enabled check is (i think) also useless at the moment
> since if MLS is off won't netlbl_sid be null? But I guess it doesn't 
> hurt to leave it in there.

This is rather interesting, if you ignore the selinux_mls_enabled check I 
believe you would end up a netlbl_sid which is equal to SECINITSID_NETMSG.  
Look in security_netlbl_secattr_to_sid() in the if block when (secattr->flags 
& NETLBL_SECATTR_MLS_LVL) and you'll see that the key security server MLS 
calls are to mls_import_netlbl_lvl() which will be a no-op and to 
mls_context_isvalid() which will declare the context valid as the 
default "base sid" which in this case is SECINITSID_NETMSG.  Perhaps not the 
most obvious conclusion at first glance but it does make sense.

> We can't call mls_context_cmp() the way
> you are below if !selinux_mls_enabled since apparently no MLS != no
> MLS (which i wonder if it's right, but i didn't check all the callers
> of it)

You lost me on the "no MLS != no MLS".  Other than the obvious brain-o on the 
mls_context_cmp() return value I think we'd be okay calling mls_context_cmp() 
even when selinux_mls_enabled if false as we would end up returning the 
xfrm_sid which would be the right thing to do in this case.

I'm going to leave the selinux_mls_enabled check in for now as my gut tells me 
it is "safer", although I believe the function would still operate correctly 
even if the check were not in place.

> </nit picking>

Fine with me, I'm glad it's getting nit picked - that's why I keep posting the 
patches :)  Once development slows a bit I'll start doing more testing which 
should help sort out some of these problems too, but if anyone wants to get a 
head start ...

On Tuesday 02 October 2007 3:53:15 pm Eric Paris wrote:
> > +out_slowpath:
> > +       POLICY_RDUNLOCK;
> > +       if (rc == 0)
> > +               /* at present NetLabel SIDs/labels really only carry MLS
> > +                * information so if the MLS portion of the NetLabel SID
> > +                * matches the MLS portion of the labeled XFRM SID/label
> > +                * then pass along the XFRM SID as it has the most peer
> > label +                * information */
> > +               *peer_sid = xfrm_sid;
> > +       else
> > +               *peer_sid = SECSID_NULL;
> > +       return rc;
>
> Actually now that I look at it, doesn't mls_context_cmp return 1 if
> they are the same and 0 if they are different?  So you'd need rc =
> !mls_context_cmp ()  and we can then drop both the ss_initialized and
> the mls_enabled stuff I was talking about before?

See my comments above.  You are correct that I mixed up the return values.  I 
remember checking that when I was writing the code but I guess I'm too used 
to memcmp()/strcmp() and friends ...

Thanks for taking the time to look at the code.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
