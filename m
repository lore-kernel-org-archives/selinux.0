Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "'James Morris'" <jmorris@namei.org>, <jbrindle@tresys.com>,
        <selinux@tycho.nsa.gov>, "'Stephen Smalley'" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>, "'Paul Moore'" <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 10:22:08 -0600
Message-ID: <001301c6fe9b$0bd0d820$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <36282A1733C57546BE392885C06185920166D6EC@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > Since an association is a uni-directional object and since having
> > > mozilla_t as the label on associations in BOTH directions would
> > > mess-up the getpeercon semantics (it would return mozilla_t when
> > > invoked by the client as well as the server which isn't 
> > what we want)
> > > the above rule will have to be broken into:
> > 
> > It wouldn't break the getpeercon semantics.  The 
> association would be
> > labeled mozilla_t on the apache machine, and apache_t on the mozilla
> > machine.
> 
> Yes, but the thing to realize with these SAs is that they are
> uni-directional. So there's no mozilla_t SA involved when mozilla

s/mozilla_t/apache_t/

> is sending to apache (if you ignore the transport here).
> IOW, using SAs you can broadly only control "who can talk to you",
> not "who you can talk to". The latter can currently be achieved by
> using secmark controls where you would mark the packet in a
> fine-grained manner and see if the socket can send that Type of
> packet.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
