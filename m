Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BBftrT024253
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 07:41:55 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BBft6V001607
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 11:41:55 GMT
Date: Sat, 11 Sep 2004 12:53:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch against latest CVS
Message-ID: <20040911115308.GB24787@lkcl.net>
References: <200409111954.15823.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409111954.15823.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 11, 2004 at 07:54:15PM +1000, Russell Coker wrote:

> +file_type_auto_trans(init_t, device_t, initctl_t, fifo_file)
> +ifdef(`distro_redhat', `
> +file_type_auto_trans(init_t, tmpfs_t, initctl_t, fifo_file)
> +')

 debian will need this too, yes?

>  
>  # Create ioctl.save.
>  file_type_auto_trans(init_t, etc_t, etc_runtime_t, file)
> @@ -114,7 +117,10 @@
>  can_setbool(init_t)
>  
>  # Read and write the console and ttys.
> -allow init_t { tmpfs_t tty_device_t console_device_t } :chr_file rw_file_perms;
> +allow init_t { tty_device_t console_device_t } :chr_file rw_file_perms;
> +ifdef(`distro_redhat', `
> +allow init_t tmpfs_t:chr_file rw_file_perms;
> +')

 and this?

 if this is as you say to support tmpfs_t in udev, and i am to keep
 current with the present selinux policy, i'll need these in debian
 not just redhat!

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
