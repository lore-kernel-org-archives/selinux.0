Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "James Morris" <jmorris@namei.org>, <jbrindle@tresys.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>, "Paul Moore" <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
Date: Fri, 3 Nov 2006 08:49:04 -0600
Message-ID: <001901c6ff57$35d4bd50$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1162492417.18181.24.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> No, secmark does not help here.  It has nothing to do with 
> the domain on
> the other machine.  It only represents ports, nodes and netifs.

That's correct, but currently that's as close as you can get to
representing a form of the remote peer on the local machine. The
remote peer domain simply isn't available on the local machine
at the time you are trying to determine if a local process can
talk TO a remote peer.

> 
> > > > > allow http_server_packet_t mozilla_t:association { 
> > > flow_in flow_out };
> > > > 
> > > > This won't always work since at least from the MLS 
> standpoint, an
> > > > association
> > > > could be looked at as being more fine-grained than a 
> packet type.
> > > 
> > > I don't understand what the problem is.  MLS constraints 
> still apply.
> > 
> > Yes MLS constraints apply. But consider the following:
> > 
> > secmark: s2-s4
> > SA: s3
> 
> I still don't see what the problem is.  If this packet 
> shouldn't go over
> the association, the MLS constraints would be written for the above
> permissions to express that goal and it would get denied.

Yes, you could frame MLS constraints accordingly, but I suspect
they may look awkward.

Could you please give an example or two where this would be useful?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
