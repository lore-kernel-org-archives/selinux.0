Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>,
   "'Chad Hanson'" <chanson@TrustedCS.com>
In-Reply-To: <1099431220.23756.129.camel@pham.columbia.tresys.com>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com>
	 <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil>
	 <4186DCE7.9030401@tresys.com>
	 <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
	 <1099417155.23756.112.camel@pham.columbia.tresys.com>
	 <1099418564.31739.208.camel@moss-spartans.epoch.ncsc.mil>
	 <1099431220.23756.129.camel@pham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099490029.1213.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 08:53:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 16:33, Karl MacMillan wrote:
> On Tue, 2004-11-02 at 13:02 -0500, Stephen Smalley wrote:
> > The amount of trust placed in samba is the same, but the dynamic context
> > transition allows the kernel to handle the mediation directly and
> > atomically with respect to the file access.  Otherwise, you have to
> > duplicate the checking in samba (which will still ultimately get the
> > decisions from the kernel via selinuxfs) and deal in some way with race
> > conditions.  Keep in mind that we are talking about user-writable
> > directories that are being exported by samba.
> > 
> 
> This is using the dynamic context transitions as a practical
> _discretionary_ security measure then. That may have some benefit. I'm
> still concerned that the benefits don't outweigh the costs. We are,
> after all, talking about breaking some fundamental assumptions of the
> SELinux mechanism in a way that may give many people a false sense of
> security.

Discretionary?  To samba, I suppose, but not to the client.  We are
still talking about the enforcement of a mandatory policy, whether the
enforcement is provided by samba as a userspace object manager or by the
kernel based on samba's dynamic transitions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
