Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3D29XZ014301
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 08:02:09 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3D25JZ016117
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 13:02:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
Date: Wed, 3 Nov 2004 17:16:45 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, jwcart2@epoch.ncsc.mil,
   SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <4187AE44.40204@redhat.com> <20041103000707.GD2547@jmh.mhn.de>
In-Reply-To: <20041103000707.GD2547@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411031716.45644.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 November 2004 11:07, Thomas Bleher 
<bleher@informatik.uni-muenchen.de> wrote:
> allow logrotate_t acct_data_t:dir search;
> allow logrotate_t acct_data_t:file create_file_perms;

I don't think that is correct either.  If you only have search access to a 
directory then you can not create a file inside it...

> >  allow ftpd_t ftp_data_port_t:tcp_socket name_bind;
> > +allow ftpd_t port_t:tcp_socket { name_bind };
>
> I confess I am not too familiar with ftp, but does it really need to
> bind to arbitrary ports, seems excessive and unneeded (and is not
> granted in current policy as far as I can see)

I guess that would be for active FTP.  It's ugly but I don't think that we 
have a choice.

> > +/usr/lib/mailman/bin/qrunner    --
> > system_u:object_r:mailman_queue_exec_t +/etc/mailman(/.*)?    
> > system_u:object_r:mailman_data_t
> > +/var/spool/mailman(/.*)?    system_u:object_r:mailman_data_t
>
> Sorry, I do not know mailman at all, so please excuse my ignorance.
> But does mailman really have to write to /etc/mailman, which is
> presumably it's configuration data? This is not nice at all.

It shouldn't be necessary, and isn't unless mailman has changed recently.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
