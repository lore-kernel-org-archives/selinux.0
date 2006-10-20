Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: Darrel Goeddel <DGoeddel@tcs-sec.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
In-Reply-To: <001001c6f397$408b2570$cc0a010a@tcssec.com>
References: <001001c6f397$408b2570$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 12:41:00 +0000
Message-Id: <1161348060.22531.58.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-19 at 10:57 -0500, Venkat Yekkirala wrote:
> > I want to be able to restrict which associations a packet can go over,
> > specified by TE policy _alone_.
>
> Yes. The current design (including the constraints for context equality)
> is in fact assuring that all packets from apache use the apache_t
> association, since it's all coming from apache. This also preserves
> the getpeercon semantics in that the remote BIND as well as firefox_t
> will see the traffic as coming from apache_t.

There is a severe problem with this.  The label of the association on
the apache machine should not be apache_t, it should be named_t for the
BIND association and firefox_t for the firefox association.  I described
this in a previous email.  The wrong labeling will cause unexpected
getpeercon results on the initiator side because apache would get
apache_t instead of firefox_t for example.  There should not be a
context equality between the socket and the association.

>  Choice of association
> by "packet type" (specified entirely in the SELinux policy) isn't
> possible for the following reasons:
>
> 1. secmarking comes into play AFTER the association is chosen. This is just
>    how Linux networking operates.

The question for this check is, "is this packet allowed to go over the
association?", and has the assumption that the association has been
chosen.  The negative answer means the packet is dropped, not "try next
association".  Your description above sounds like the appropriate
information is probably available for this check.

> 2. In the new secpoint design (if we ever get to do it) there's no "packet
>    type" per se. It's a flow-control point (dp_bind_t and dp_firefox_t) that
>    apache_t will have to be configured to talk to in the SELinux policy.

Its been stated clearly that the internal labeling shouldn't be
overwritten, see James's comments (which I agree with).

> So SELinux policy would have to assume that all packets from apache
> use a "single" apache_t association, but in reality they may get to
> be different associations based on how you have your SPD and SAD and IKE
> setup.

More than one file can have the same type, for example, so more than one
association having the same label isn't anything new.  See above for the
problem with the context equality.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
