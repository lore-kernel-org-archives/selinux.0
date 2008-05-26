Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4QFkoXd008042
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 11:46:50 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m4QFknLN019864
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 15:46:49 GMT
Subject: Re: New domain for nsplugin
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4831B4E7.6010000@comcast.net>
References: <4831B4E7.6010000@comcast.net>
Content-Type: text/plain
Date: Mon, 26 May 2008 11:46:02 -0400
Message-Id: <1211816762.11188.181.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-05-19 at 13:12 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/apps/nsplugin.fc	1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-3.4.1/policy/modules/apps/nsplugin.fc	2008-05-19 11:36:24.749177000 -0400
> @@ -0,0 +1,9 @@
> +
> +/usr/lib(64)?/nspluginwrapper/npviewer.bin	--	gen_context(system_u:object_r:nsplugin_exec_t,s0)
> +/usr/lib(64)?/nspluginwrapper/plugin-config	--	gen_context(system_u:object_r:nsplugin_config_exec_t,s0)
> +/usr/lib(64)?/mozilla/plugins-wrapped(/.*)?			gen_context(system_u:object_r:nsplugin_rw_t,s0)
> +
> +HOME_DIR/\.adobe(/.*)?			gen_context(system_u:object_r:user_nsplugin_home_t,s0)
> +HOME_DIR/\.macromedia(/.*)?		gen_context(system_u:object_r:user_nsplugin_home_t,s0)
> +HOME_DIR/\.gstreamer-.*			gen_context(system_u:object_r:user_nsplugin_home_t,s0)
> +HOME_DIR/\.local.*			gen_context(system_u:object_r:user_nsplugin_home_t,s0)

I'm having trouble buying this one.  It seems pretty broad, especially
since acrobat isn't only a browser plugin, and I'm not sure what
gstreamer is doing here.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
