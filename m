Subject: Re: Updated policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1106690203.20960.4.camel@cobra.ivg2.net>
References: <41F6A47E.9010407@redhat.com>
	 <1106690203.20960.4.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1106741934.23386.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Jan 2005 07:18:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 16:56, Ivan Gyurdiev wrote:
> > Elimination of gpg execmod change.  The gpg rpm was fixed in rawhide.
> 
> Please add execmod to mozilla and X (Bug #145067).
> Mozilla needs it for flash, and X for the Nvidia driver.
> 
> Here's all the libs on my system where I see TEXTREL with readelf -d.
> 
> /usr/lib/libstdc++.so.2.7.2.8
> /usr/lib/libpostproc.so.0.0.1
> /usr/lib/nvidia/tls/libnvidia-tls.so.1.0.6629
> /usr/lib/nvidia/libnvidia-tls.so.1.0.6629
> /usr/lib/libmp3lame.so.0.0.0
> /usr/lib/libmlib_jai.so
> /usr/lib/libgsm.so.1.0.10
> /usr/lib/libglide3.so.3.10.0
> /usr/lib/libg++.so.2.7.2.8
> /usr/lib/libdv.so.4.0.1
> /usr/lib/libavformat-0.4.9-pre1.so
> /usr/lib/libavcodec-0.4.9-pre1.so
> /usr/X11R6/lib/libXvMCNVIDIA.so.1.0.6629
> /usr/lib/libSDL-1.2.so.0.7.0
> /usr/X11R6/lib/libOSMesa.so.4.0
> /usr/lib/libImlib2.so.1.2.0
> /usr/lib/libHermes.so.1.0.0
> /usr/lib/nvidia/libGLcore.so.1.0.6629
> /usr/lib/nvidia/libGL.so.1.0.6629
> sed: -e expression #1, char 13: unknown option to `s'
> /usr/lib/firefox-0.10.0/plugins/libflashplayer.so
> /usr/lib/firefox-0.9.3/plugins/libflashplayer.so

The preferred approach would be to assign a different type to all such
shared objects, e.g. textrel_shlib_t, and only allow execmod permission
to that type.  Any existing occurrences of execmod should also be
rewritten to use the specific type at that point.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
