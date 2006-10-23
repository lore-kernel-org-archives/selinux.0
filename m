Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>
Cc: <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Subject: RE: SELinux Networking Enhancements
Date: Mon, 23 Oct 2006 11:32:53 -0500
Message-ID: <001301c6f6c0$e3fd9b80$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0610201924040.9153@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Hi James, can you please tell me exactly what rules (and only those)
> > that one should be able to specify in the forwarding case in the
> > following example:
> > 
> > I have a machine 192.168.16.10 that needs to be able to do
> web-browsing
> > only, via the router.
> 
> You mean rules on thr router to to enforce MAC between two other
> systems?
> 
> I think this is currently out of scope.

Yes. Currently you can't do it. But I would like to get ideas on
a "less confusing" way to do forwarding controls. Specifically,
what would be an ideal allow-rule-set look like for forwarding
controls?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
