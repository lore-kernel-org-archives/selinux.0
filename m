MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Security Context Type Changes
Date: Wed, 20 Jan 2010 10:50:58 -0600
Message-ID: <822A6B57FFD31647BB62F4676394C675034B6FF9@XMBTX131.northgrum.com>
In-Reply-To: <1263936423.12068.90.camel@moss-pluto.epoch.ncsc.mil>
References: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com> <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil> <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com> <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil> <822A6B57FFD31647BB62F4676394C675034B6C0F@XMBTX131.northgrum.com> <1263936423.12068.90.camel@moss-pluto.epoch.ncsc.mil>
From: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

That is correct, we are not executing anything that would set up a user
context. Nothing in our code or our policy would change the context. In
RHEL4, root and any other users have a security context type of
unconfined_t so we would it expect it to be the same on RHEL5 but they
are init_t. Perhaps, something changed with RHEL5 release that I need to
research.

Thanks,


Gregg

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, January 19, 2010 1:27 PM
To: Tomas, Gregg A (IS)
Cc: selinux@tycho.nsa.gov
Subject: RE: Security Context Type Changes

On Tue, 2010-01-19 at 15:15 -0600, Tomas, Gregg A (IS) wrote:
> Stephen,
> 
> I apologize for my lack promptness, I have been in and out of the
> office. We are in the middle of transitioning from RHEL4 to RHEL5 so
> some of the links maybe off. Anyhow, here is our run_xstart.bash
script:
>
========================================================================
> ========================
<snip>
> # Start window manager for primary display #
> exec /usr/bin/fvwm -display $DISPLAY1 \
>      -cmd "Read /h/ProjectX/config_values/system.fvwmrc"
> 
>
========================================================================
> ===============

So why would you expect that to transition out of init_t?
Unless you've specifically labeled /usr/bin/fvwm with an entrypoint type
and defined a type transition on it, you'll just continue in init_t.

You aren't executing anything that would set up a user context, e.g. gdm
or friends.
 
-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
