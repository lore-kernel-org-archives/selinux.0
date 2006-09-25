Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573731@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201573731@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 15:24:26 -0400
Message-Id: <1159212266.16246.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 14:56 -0400, Chad Hanson wrote:
> Correct, I just wanted to state that we need to have an interface to get the
> packet context, no matter if it is from a labeled network connection or just
> an implicit context from secmark labeling. If getpeercon() can do this,
> there is no need for getdatacon().

The problem is that the secmark labeling is generally not suitable as a
subject label or as a data origin label, so you can't use it in the way
you described.

> 
> -Chad
> 
> > 
> > But your example is precisely how getpeercon() is used, so the
> > distinction between getdatacon() and getpeercon() seems artificial to
> > me.  The real problem is figuring out how to reconcile secmark with
> > labeled networking, not getpeercon vs. getdatacon.
> > 
> > -- 
> > Stephen Smalley
> > National Security Agency
> > 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
