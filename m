Message-Id: <200210021252.MAA21909@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Re: postfix
Date: Wed, 2 Oct 2002 14:53:25 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20020929161517.D356DBEF4@sat.sws.net.au> <200209291914.23804.russell@coker.com.au>
In-Reply-To: <200209291914.23804.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 29. September 2002 19:14 schrieb Russell Coker:
> On Sun, 29 Sep 2002 17:57, Carsten Grohmann wrote:
> > the attached patch contain some little changes on your postfix rules. I
> > need the additional rules on my (SuSE) system and I think this changes
> > are not SuSE specific and we could add this to postfix.te
>
> How is the following needed?  A fifo_file access to the same process is
> not checked for creation and usually only needs { read write } access,
> sometimes getattr and ioctl.  I could probably make it more restrictive
> than rw_file_perms even...
> -allow postfix_master_t self:fifo_file rw_file_perms;
> +allow postfix_master_t self:fifo_file create_file_perms;
>
> What needs the following?  On my system I have no fifo's with that type,
> only sockets.
> -allow postfix_master_t postfix_private_t:fifo_file getattr;
> +allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
>
> For the following, are you sure that you have the programs in the right
> domains?

Yes I think.

> -allow postfix_master_t postfix_prng_t:file getattr;
> +allow postfix_master_t postfix_prng_t:file { getattr lock read write };
> +allow postfix_master_t random_device_t:chr_file { read };
> The following file_contexts line was changed recently to cover a change
> in the default Debian setup for Postfix, maybe this is something you
> need. /usr/lib/postfix/(n)?qmgr      
> system_u:object_r:postfix_qmgr_exec_t

qmgr is labelling correct

> What is this one used for?
> +allow postfix_pickup_t self:udp_socket { create ioctl };
>
> Could you show me some dmesg output?

Is attached.

Could it be that this rules are used by older postfix versions? Because I 
don't use the current version use 20010228pl8.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
