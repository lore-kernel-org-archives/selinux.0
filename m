Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8AHvlrT020379
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 13:57:48 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8AHusvo024223
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 17:56:54 GMT
Date: Fri, 10 Sep 2004 19:09:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ssh policy
Message-ID: <20040910180900.GQ14060@lkcl.net>
References: <200409090428.52881.russell@coker.com.au> <1094761979.2895.64.camel@moss-lions.epoch.ncsc.mil> <4141BF21.9050004@redhat.com> <1094828891.28310.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094828891.28310.52.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 10, 2004 at 11:08:11AM -0400, Stephen Smalley wrote:
> On Fri, 2004-09-10 at 10:50, Daniel J Walsh wrote:
> > Latest policy.  More stuff for dbus.  Added media file.   Changes for 
> > udev on tmpfs.
> 
> Conflicts with our latest patches.
> > 
> > ______________________________________________________________________
> > -allow ifconfig_t self:netlink_route_socket { bind create getattr nlmsg_read nlmsg_write read write };
> > +allow ifconfig_t self:netlink_route_socket { bind create getattr nlmsg_read nlmsg_write read write setopt };
> 
> I just replaced this with rw_netlink_socket_perms in our tree.
> 
> > -r_dir_file(updfstab_t, { selinux_config_t file_context_t default_context_t } )
> >  can_getsecurity(updfstab_t)
> > +dontaudit updfstab_t selinux_config_t:dir search;
> 
> I don't think that this is correct; updfstab appears to be looking up a
> context via matchpathcon for preserving the context on /etc/fstab, so it
> needs access to the file contexts file as in our policy.
> 
> > diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/xserver.fc policy-1.17.13/file_contexts/program/xserver.fc
> > --- nsapolicy/file_contexts/program/xserver.fc	2004-09-09 15:36:11.000000000 -0400
> > +++ policy-1.17.13/file_contexts/program/xserver.fc	2004-09-10 10:29:32.761599897 -0400
> > @@ -11,7 +11,7 @@
> >  /var/log/XFree86.*	--	system_u:object_r:xserver_log_t
> >  /var/log/Xorg.*		--	system_u:object_r:xserver_log_t
> >  /etc/init\.d/xfree86-common --	system_u:object_r:xserver_exec_t
> > -/tmp/\.X11-unix		-d	system_u:object_r:xdm_xserver_tmp_t
> > +/tmp/\.X11-unix		-d	system_u:object_r:xdm_tmp_t
> >  /tmp/\.X11-unix/.*	-s	<<none>>
> >  /tmp/\.ICE-unix		-d	system_u:object_r:xdm_xserver_tmp_t
> >  /tmp/\.ICE-unix/.*	-s	<<none>>
> 
> I know that this was motivated by the relabel cycling reported by Tom
> London, but it raises an obvious question - who is creating this
> directory?  Is it truly [xdk]dm?  If not, why it is being created in
> xdm_tmp_t rather than xdm_xserver_t?
> 

 i raised a bug on debian about this and the reason is that a number
 of legacy X programs rely on the location /tmp.

 actually i raised the bug about /etc/init.d/xfs so in fact
 this time /etc/init.d/xfree86-common needs
 if [ -x /sbin/restorecon ]; then /sbin/restorecon $ICE_DIR; fi
 and
 if [ -x /sbin/restorecon ]; then /sbin/restorecon $SOCKET_DIR; fi

 debian intend to fix the location of all of these post-sarge.

 at the moment it'd break too many legacy apps that used to be
 happy with /tmp.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
