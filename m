Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "Darrel Goeddel" <DGoeddel@tcs-sec.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        <sds@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Mon, 23 Oct 2006 12:42:35 -0500
Message-ID: <001501c6f6ca$a0bb3d50$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161348060.22531.58.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just FYI- I spoke to Chris Friday morning and after we discussed that
the incoming traffic uses a differently labeled SA than the outgoing
traffic,
getpeercon semantics, etc., he is agreeable to eliminating the sendto check
for the outbound traffic. I am going to put a patch out that does this as
also
a. get the SA context from the sock (part of the failed secid patch)
b. fix getpeercon

Stay tuned.


> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Friday, October 20, 2006 7:41 AM
> To: vyekkirala@trustedcs.com
> Cc: Darrel Goeddel; 'Karl MacMillan'; 'Joshua Brindle';
> selinux@tycho.nsa.gov; sds@tycho.nsa.gov
> Subject: RE: Denials from newest kernel
>
>
> On Thu, 2006-10-19 at 10:57 -0500, Venkat Yekkirala wrote:
> > > I want to be able to restrict which associations a packet
> can go over,
> > > specified by TE policy _alone_.
> >
> > Yes. The current design (including the constraints for
> context equality)
> > is in fact assuring that all packets from apache use the apache_t
> > association, since it's all coming from apache. This also preserves
> > the getpeercon semantics in that the remote BIND as well as
> firefox_t
> > will see the traffic as coming from apache_t.
>
> There is a severe problem with this.  The label of the association on
> the apache machine should not be apache_t, it should be
> named_t for the
> BIND association and firefox_t for the firefox association.
> I described
> this in a previous email.  The wrong labeling will cause unexpected
> getpeercon results on the initiator side because apache would get
> apache_t instead of firefox_t for example.  There should not be a
> context equality between the socket and the association.
>
> >  Choice of association
> > by "packet type" (specified entirely in the SELinux policy) isn't
> > possible for the following reasons:
> >
> > 1. secmarking comes into play AFTER the association is
> chosen. This is just
> >    how Linux networking operates.
>
> The question for this check is, "is this packet allowed to go over the
> association?", and has the assumption that the association has been
> chosen.  The negative answer means the packet is dropped, not
> "try next
> association".  Your description above sounds like the appropriate
> information is probably available for this check.
>
> > 2. In the new secpoint design (if we ever get to do it)
> there's no "packet
> >    type" per se. It's a flow-control point (dp_bind_t and
> dp_firefox_t) that
> >    apache_t will have to be configured to talk to in the
> SELinux policy.
>
> Its been stated clearly that the internal labeling shouldn't be
> overwritten, see James's comments (which I agree with).
>
> > So SELinux policy would have to assume that all packets from apache
> > use a "single" apache_t association, but in reality they may get to
> > be different associations based on how you have your SPD
> and SAD and IKE
> > setup.
>
> More than one file can have the same type, for example, so
> more than one
> association having the same label isn't anything new.  See
> above for the
> problem with the context equality.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
