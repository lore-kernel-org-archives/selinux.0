Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "Justin P. mattock" <justinmattock@gmail.com>,
        Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7DB3B4.2070409@gmail.com>
	 <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7EDC9A.40801@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Fri, 19 Feb 2010 16:25:11 -0500
Message-Id: <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-19 at 16:08 -0500, Alan Rouse wrote:
> Ok, in case this might be useful to someone else, here's my recipe for an OpenSuse 11.2 system booting to the desktop using SELinux in permissive mode.  (Next step for me is to fix a few pages of AVC denied messages...)
> 
> 1.  Default install of OpenSuse 11.2 (used Gnome desktop)
> 2.  Boot normally to desktop, open terminal, su -
> 3.  Do this:
> 
> zypper install selinux-tools selinux-policy libselinux* libsemanage* policycoreutils checkpolicy   setools-console make m4 gcc findutils-locate git
> 
> vi /boot/grub/menu.lst
>  -- and add to the Desktop kernel boot line: "security=selinux selinux=1 enforcing=0"
> 
> cd /etc/selinux
> cp -R refpolicy-standard targeted
> usermod -s /sbin/nologin nobody
> reboot <should boot to desktop>
> ===============
> Get policy src:
> ===============
> -- launch firefox, go to http://software.opensuse.org/search/
> -- search for selinux-policy, download src
> -- install src rpm
> cp /usr/src/packages/SOURCES/refpolicy-2.20081210.tar.bz2 /tmp
> cd /tmp
> bunzip2 refpolicy-2.20081210.tar.bz2
> tar xvf refpolicy-2.20081210.tar
> cd refpolicy
> vi build.conf   (set NAME = refpolicy-standard; set DISTRO = suse; set MONOLITHIC = n)
> make clean; make conf; make; make install; make load; make install-src
> cd /etc/selinux/refpolicy-standard/src/policy
> make clean; make conf; make; make install; make load
> cd /etc/selinux
> rsync -avz refpolicy-standard/ targeted

Why is it necessary to download and rebuild the source policy?  Did they
build it as a monolithic policy?

> reboot
> =============================
> End of getting policy source:
> =============================
> setsebool -P init_upstart=on
> setsebool -P xdm_sysadm_login=on
> setsebool -P xserver_object_manager=on

I think you only need the first boolean setting.
And we should likely introduce an ifdef for suse in refpolicy that
always disables that transition so that you don't have to artificially
turn on that boolean.

> fixfiles relabel
> -- put SETLOCALDEFS=0 in /etc/selinux/config
> reboot
> 
> And we're now in the desktop with a relabeled system and selinux in permissive mode.
> ================================================================================
> 
> Here's what "audit2allow -al" shows now...
> 
> #============= avahi_t ==============
> allow avahi_t tmpfs_t:dir search;
> allow avahi_t tmpfs_t:sock_file write;

It would be useful to see the raw audit message with what directory/file
is being accessed.  tmpfs_t indicates a tmpfs mount, which might mean
you have a mislabeled tmpfs mount (e.g. /dev is a tmpfs mount that
should be relabeled by rc.sysinit via restorecon -R /dev).


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
