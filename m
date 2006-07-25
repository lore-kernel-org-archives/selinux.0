Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PDBsWx020740
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 09:11:54 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6PDBqPQ013258
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 13:11:53 GMT
Received: by nf-out-0910.google.com with SMTP id l24so227097nfc
        for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 06:11:52 -0700 (PDT)
Message-ID: <de6d2b4f0607250611n2d0a3fbbjeddcec33df1b9734@mail.gmail.com>
Date: Tue, 25 Jul 2006 14:11:52 +0100
From: "M Macnair" <mmacnair@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: security_context_to_sid failed - mounting from /etc/rc.d
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1153831474.7104.5.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <de6d2b4f0607250253g46e392d1lfa7ba0c3aadcabd@mail.gmail.com>
	 <1153831474.7104.5.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/25/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2006-07-25 at 10:53 +0100, M Macnair wrote:
> > I discovered this whilst trying to mount removable devices on boot.
> > There is the following line in /etc/rc.d/rc.local (FC5):
> > mount -a -t nonfs,nfs4,smbfs,ncpfs,cifs,gfs -O
> > no_netdev,context=system_u:object_r:removable_t
>
> Add :s0 to the end of that context.  IIRC, the problem is that mount
> just directly passes the context to the kernel without going through
> libselinux, so it never undergoes "label translation".
>
> > When executed, this fails with the error:
> > mount: wrong fs type, bad option, bad superblock on /dev/store/music,
> >        missing codepage or other error
> >        In some cases useful info is found in syslog - try
> >        dmesg | tail  or so
> >
> > /var/log/messages says:
> >  kernel: SELinux:
> > security_context_to_sid(system_u:object_r:removable_t) failed for (dev
> > dm-3, type ext2) errno=-22
> >
> > /dev/store/music is an unmounted lvm ext2 formatted logical volume,
> > with fstab entry:
> > /dev/store/music  /mnt/music  ext2
> > defaults,user,context=system_u:object_r:removable_t
> >
> >
> > This error is dependent on the context of the script that is executing
> > it - cp rc.local into /etc/ (from /etc/rc.d) and execute it there, and
> > it works perfectly.  Executing the mount command from a terminal also
> > works.
> >
> > # ls -Z /etc/rc.d/rc.local /etc/rc.local.cp
> > -rwxr-xr-x  root root system_u:object_r:initrc_exec_t  /etc/rc.d/rc.local
> > -rwxr-xr-x  root root user_u:object_r:etc_t            /etc/rc.local.cp
> >
> >
> > Any ideas on what's going on / how to work around it?
>
> I don't understand why that would make a difference; the error has to do
> with validity of the context, not a permission denial.
>
> --
> Stephen Smalley
> National Security Agency
>
>

Thanks, adding :s0 to the context in the script and fstab entry fixed it.

Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
