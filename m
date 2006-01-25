Message-ID: <36282A1733C57546BE392885C0618592FD503E@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Chad Hanson
	 <chanson@TrustedCS.com>
Cc: JANAK DESAI <janak@us.ibm.com>, selinux@tycho.nsa.gov
Subject: RE: password policy question
Date: Wed, 25 Jan 2006 13:55:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Very true that this is a downgrade channel. We should probably create
another boolean for the ability of disallowing the chsh/chfn access, similar
to ping, thus closing this channel.

> 
> On Wed, 2006-01-25 at 13:35 -0500, Chad Hanson wrote:
> > This isn't an arbitrary process, this is the passwd program running in
the
> > passwd_t domain. The only thing the "trusted" program does is alter
password
> > data. The password data itself isn't classified so downgrading is
allowed in
> > this controlled instance.
> 
> Yes, but it is the caller that provides the input data (the new
> password), which could be used to leak arbitrary data through the passwd
> file.  In the case of the password itself, the channel is constrained by
> the fact that the plaintext is not saved to the file, but there is still
> a channel under the control of the caller.  In the case of other passwd
> file fields settable via chfn/chsh and some forms of the passwd program
> (not sure about the RH one), you can leak arbitrary plaintext (subject
> only to length limitations).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
