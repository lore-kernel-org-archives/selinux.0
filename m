Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJEQ9E3003227
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 09:26:09 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lAJEQ89h026570
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 14:26:08 GMT
Subject: Re: [DSE-Dev] [martin@martinorr.name:  /selinux getattr messages]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, Martin Orr <martin@martinorr.name>,
        selinux-devel@lists.alioth.debian.org
In-Reply-To: <20071116125923.GA25905@bobek.pm.i.cz>
References: <20071116125923.GA25905@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 19 Nov 2007 09:25:26 -0500
Message-Id: <1195482326.16660.19.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-16 at 13:59 +0100, Václav Ovsík wrote:
> Hello,
> I'm trying to stabilize refpolicy-20070928 on Debian Etch.
> 
> Repository with some updated selinux packages will be available soon.
> I took packages from Sid and updated these with 20070928 upstream
> releases.
> 
> I'm SELinux beginer, but my intention is to understand the SELinux
> finally :) and run targeted and possibly strict policies in production
> environment on Debian.
> 
> Currently I'm booting Xen DomU Debian Etch in permissive mode.
> 
> There are two audit messages, and I found solution (attached) in
> selinux-devel@lists.alioth.debian.org.
> 
> audit(1195215260.590:3): avc:  denied  { getattr } for  pid=760
> comm="mount" name="/" dev=selinuxfs ino=475
> scontext=system_u:system_r:mo
> unt_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> 
> audit(1195215263.626:6): avc:  denied  { getattr } for  pid=1017
> comm="swapon" name="/" dev=selinuxfs ino=475 scontext=system_u:system_r:
> fsadm_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> 
> 
> So after insertion
> 
> selinux_get_fs_mount(fsadm_t)
> -> ./policy/modules/system/fstools.te
> 
> selinux_get_fs_mount(mount_t)
> -> ./policy/modules/system/mount.te
> 
> both messages dismiss.
> 
> Is such solution ok and acceptable upstream (conditionaly for
> Debian distro or so)?

I have added a selinuxutil interface for libselinux-linked domains
(seutil_libselinux_linked()).  That way its clear why the access is
needed, and we can change it if the constructor changes.

The mount change could be for all, as I also see the libblkid linkage on
my Gentoo system too.  However, I don't see it in Gentoo iptables
(1.3.8).


> email message attachment
> > -------- Forwarded Message --------
> > From: Martin Orr <martin@martinorr.name>
> > To: selinux-devel@lists.alioth.debian.org
> > Subject: [DSE-Dev] /selinux getattr messages
> > Date: Sat, 23 Jun 2007 12:39:11 +0100
> > 
> > I am using the targeted policy in permissive mode.  During boot I
> > get the
> > following messages:
> > audit(1182511335.252:36): avc:  denied  { getattr } for  pid=1249
> > comm="mount" name="/" dev=selinuxfs ino=318
> > scontext=system_u:system_r:mount_t:s0
> > tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > audit(1182511346.457:47): avc:  denied  { getattr } for  pid=1503
> > comm="swapon" name="/" dev=selinuxfs ino=318
> > scontext=system_u:system_r:fsadm_t:s0
> > tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > audit(1182511347.644:48): avc:  denied  { getattr } for  pid=1570
> > comm="iptables" name="/" dev=selinuxfs ino=318
> > scontext=system_u:system_r:iptables_t:s0
> > tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > 
> > These come because libblkid and iptables are both linked against
> > libselinux,
> > which locates the selinux mount point in a constructor.  When this
> > was
> > introduced in libselinux, the selinux_get_fs_mount interface was
> > added to
> > the reference policy to allow this.  So mount.te should gain
> > selinux_get_fs_mount(mount_t)
> > and fstools.te should gain
> > selinux_get_fs_mount(fsadm_t)
> > 
> > So far as I can see iptables has no need to be linked against
> > libselinux,
> > but I will check further.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
