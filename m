Subject: RE: Security Context Type Changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <822A6B57FFD31647BB62F4676394C675034B6FF9@XMBTX131.northgrum.com>
References: 
	 <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>
	 <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil>
	 <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com>
	 <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil>
	 <822A6B57FFD31647BB62F4676394C675034B6C0F@XMBTX131.northgrum.com>
	 <1263936423.12068.90.camel@moss-pluto.epoch.ncsc.mil>
	 <822A6B57FFD31647BB62F4676394C675034B6FF9@XMBTX131.northgrum.com>
Content-Type: text/plain
Date: Wed, 20 Jan 2010 12:36:31 -0500
Message-Id: <1264008991.24133.119.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-20 at 10:50 -0600, Tomas, Gregg A (IS) wrote:
> Stephen,
> 
> That is correct, we are not executing anything that would set up a user
> context. Nothing in our code or our policy would change the context. In
> RHEL4, root and any other users have a security context type of
> unconfined_t so we would it expect it to be the same on RHEL5 but they
> are init_t. Perhaps, something changed with RHEL5 release that I need to
> research.

Normally it is programs such as login (non-graphical console login), gdm
(graphical console login), or sshd (remote login) that set up the
security context for a user session.  If you were executing your script
directly from /etc/inittab under RHEL4, you should have had the same end
result - it would stay in init_t until/unless it executed a program for
which a domain transition was defined or a program that explicitly set a
context.  Possibly you were labeling your script or fvwm with a type and
defining a domain transition on RHEL4?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
