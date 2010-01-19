Subject: RE: Security Context Type Changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <822A6B57FFD31647BB62F4676394C675034B6C0F@XMBTX131.northgrum.com>
References: 
	 <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>
	 <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil>
	 <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com>
	 <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil>
	 <822A6B57FFD31647BB62F4676394C675034B6C0F@XMBTX131.northgrum.com>
Content-Type: text/plain
Date: Tue, 19 Jan 2010 16:27:03 -0500
Message-Id: <1263936423.12068.90.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-19 at 15:15 -0600, Tomas, Gregg A (IS) wrote:
> Stephen,
> 
> I apologize for my lack promptness, I have been in and out of the
> office. We are in the middle of transitioning from RHEL4 to RHEL5 so
> some of the links maybe off. Anyhow, here is our run_xstart.bash script:
> ========================================================================
> ========================
<snip>
> # Start window manager for primary display #
> exec /usr/bin/fvwm -display $DISPLAY1 \
>      -cmd "Read /h/ProjectX/config_values/system.fvwmrc"
> 
> ========================================================================
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
