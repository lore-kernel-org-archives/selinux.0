Subject: Re: Updated policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F6A47E.9010407@redhat.com>
References: <41F6A47E.9010407@redhat.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 14:56:43 -0700
Message-Id: <1106690203.20960.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Elimination of gpg execmod change.  The gpg rpm was fixed in rawhide.

Please add execmod to mozilla and X (Bug #145067).
Mozilla needs it for flash, and X for the Nvidia driver.

Here's all the libs on my system where I see TEXTREL with readelf -d.

/usr/lib/libstdc++.so.2.7.2.8
/usr/lib/libpostproc.so.0.0.1
/usr/lib/nvidia/tls/libnvidia-tls.so.1.0.6629
/usr/lib/nvidia/libnvidia-tls.so.1.0.6629
/usr/lib/libmp3lame.so.0.0.0
/usr/lib/libmlib_jai.so
/usr/lib/libgsm.so.1.0.10
/usr/lib/libglide3.so.3.10.0
/usr/lib/libg++.so.2.7.2.8
/usr/lib/libdv.so.4.0.1
/usr/lib/libavformat-0.4.9-pre1.so
/usr/lib/libavcodec-0.4.9-pre1.so
/usr/X11R6/lib/libXvMCNVIDIA.so.1.0.6629
/usr/lib/libSDL-1.2.so.0.7.0
/usr/X11R6/lib/libOSMesa.so.4.0
/usr/lib/libImlib2.so.1.2.0
/usr/lib/libHermes.so.1.0.0
/usr/lib/nvidia/libGLcore.so.1.0.6629
/usr/lib/nvidia/libGL.so.1.0.6629
sed: -e expression #1, char 13: unknown option to `s'
/usr/lib/firefox-0.10.0/plugins/libflashplayer.so
/usr/lib/firefox-0.9.3/plugins/libflashplayer.so


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
