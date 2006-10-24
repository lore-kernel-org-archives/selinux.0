Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>
Cc: <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Tue, 24 Oct 2006 09:33:04 -0500
Message-ID: <000001c6f779$515c8840$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0610231715200.22353@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Yes. Currently you can't do it. But I would like to get ideas on
> > a "less confusing" way to do forwarding controls. Specifically,
> > what would be an ideal allow-rule-set look like for forwarding
> > controls?
> 
> I really don't know at this stage.  It seems like a generally complex 
> problem which needs a comprehensive solution itself, assuming 
> it's worth 
> solving,

We have needs for forwarding controls now.

> and I don't believe we need to wait for that to implement 
> protected paths for host to host networking.

Can you please lay out the kind of controls you have in mind
for "protected paths for host to host networking". I want to
see what (modified) portions I can present for upstreaming.

For the rest, I guess we will have to just patch our kernel.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
