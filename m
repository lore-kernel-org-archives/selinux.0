MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 11:31:30 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588514A3C@exchange.columbia.tresys.com>
In-Reply-To: <001301c6fe9b$0bd0d820$cc0a010a@tcssec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <vyekkirala@TrustedCS.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>,
        "Paul Moore" <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Venkat Yekkirala [mailto:vyekkirala@trustedcs.com] 
> 
> > > > Since an association is a uni-directional object and 
> since having 
> > > > mozilla_t as the label on associations in BOTH directions would 
> > > > mess-up the getpeercon semantics (it would return 
> mozilla_t when 
> > > > invoked by the client as well as the server which isn't
> > > what we want)
> > > > the above rule will have to be broken into:
> > > 
> > > It wouldn't break the getpeercon semantics.  The
> > association would be
> > > labeled mozilla_t on the apache machine, and apache_t on 
> the mozilla 
> > > machine.
> > 
> > Yes, but the thing to realize with these SAs is that they are 
> > uni-directional. So there's no mozilla_t SA involved when mozilla
> 
> s/mozilla_t/apache_t/
> 

I think he's asking why both SA's aren't labeled as the peer on each
side:

Side 1: socket client_t
Outgoing SA: server_t
Incomging SA: server_t

Side 2: socket server_t
Outgoing SA: client_t
Incoming SA: client_t

That way client_t has to be able to send to and recv from server_t, 
Likewise server_t has to be able to send to and recv from client_t.

The SA labeling semantics can be changed at this point, they are just
userland drive, correct? Last time I used them the labeling semantics
weren't what AFAIK they are suppose to be anyway (eg., every SA was
labeled client_t, not one labeled clien_t and the other labeled
server_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
