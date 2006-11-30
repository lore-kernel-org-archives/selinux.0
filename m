Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU3RNUw011230
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 22:27:24 -0500
Subject: Re: [PATCH] refpolicy: add X object classes to unconfined_t
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <cadfc0e40611291434w5b1468ffo2eb87b0e982569e2@mail.gmail.com>
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
	 <450962DB.7050107@tresys.com>
	 <1158324416.8680.5.camel@twoface.columbia.tresys.com>
	 <1158355183.7554.268.camel@moss-huskies.epoch.ncsc.mil>
	 <cadfc0e40611290712g7fa802f2oa5b5ebc079e8ead2@mail.gmail.com>
	 <1164830966.2794.144.camel@moss-huskies.epoch.ncsc.mil>
	 <cadfc0e40611291434w5b1468ffo2eb87b0e982569e2@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-/4iqx3izuagmCLCkKCKS"
Date: Wed, 29 Nov 2006 22:27:23 -0500
Message-Id: <1164857243.2794.177.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/4iqx3izuagmCLCkKCKS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-11-29 at 16:34 -0600, Xavier Toth wrote:
> Humm I attached the log to my last post anyway I attached it again. I
> have been able to run Xorg under the targeted policy (permissive mode)
> after I chcon'd it to the same context as the Xorg in /usr/bin. Now
> I'm trying to get it working under the MLS permissive policy which
> doesn't have the unconfined_t type. Under MLS Xorg gets labeled as
> type bin_t so I chcon'd my Xorg to match and edited XSELinuxConfig
> replacing unconfined_t with bin_t. However the result of my simplistic
> approach is that Xorg fails to start complaining:
> XSELinux: Line 11 of
> /home/jcdxdev/tmp/modular/lib/xserver/XSELinuxConfig is invalid
> 
> Fatal server error:
> XSELinux: Failed to load security policy
> 
> Any suggestions?

The type of the Xorg executable itself is not what goes in the
XSELinuxConfig file.  The types in the file are for internal X objects
such as windows that are managed by the SELinux control code in the X
server.

Try the the attached .te file.  It works for me with MLS policy in
permissive mode.  Use the instructions mentioned earlier to build it and
load it into your policy (URL below).

You also need to add the following line to XSELinuxConfig:
root_window_context       system_u:object_r:root_window_t:s1
I just fixed this in git.

Again, this is going to create loads of denial messages in the Xorg log
file.  The next step is to flesh out the .te file with appropriate allow
rules; something I haven't gotten around to yet.

http://fedora.redhat.com/docs/selinux-faq-fc5/#faq-entry-local.te


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-/4iqx3izuagmCLCkKCKS
Content-Disposition: attachment; filename=local.te
Content-Type: text/plain; name=local.te; charset=utf-8
Content-Transfer-Encoding: 7bit

policy_module(local, 1.0)

require {
	class drawable all_drawable_perms;
	class window all_window_perms;
	class gc all_gc_perms;
	class font all_font_perms;
	class colormap all_colormap_perms;
	class property all_property_perms;
	class cursor all_cursor_perms;  
	class xclient all_xclient_perms;
	class xserver all_xserver_perms;
	class xinput all_xinput_perms;
	class xextension all_xextension_perms;
}

# Type for remotely connected X clients
type remote_xclient_t;

# Type for the root window
type root_window_t;

# Types for properties 
type wm_property_t;
type cut_buffer_property_t;
type unknown_property_t;

# Types for extensions
type std_ext_t;
type screensaver_ext_t;
type font_ext_t;
type shmem_ext_t;
type accelgraphics_ext_t;
type debug_ext_t;
type sync_ext_t;
type windowmgr_ext_t;
type video_ext_t;
type input_ext_t;
type security_ext_t;
type unknown_ext_t;

--=-/4iqx3izuagmCLCkKCKS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
