Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: postfix
Date: Sun, 29 Sep 2002 19:14:23 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20020929161517.D356DBEF4@sat.sws.net.au>
In-Reply-To: <20020929161517.D356DBEF4@sat.sws.net.au>
MIME-Version: 1.0
Message-Id: <200209291914.23804.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Sep 2002 17:57, Carsten Grohmann wrote:
> the attached patch contain some little changes on your postfix rules. I
> need the additional rules on my (SuSE) system and I think this changes are
> not SuSE specific and we could add this to postfix.te

How is the following needed?  A fifo_file access to the same process is not 
checked for creation and usually only needs { read write } access, sometimes 
getattr and ioctl.  I could probably make it more restrictive than 
rw_file_perms even...
-allow postfix_master_t self:fifo_file rw_file_perms;
+allow postfix_master_t self:fifo_file create_file_perms;

What needs the following?  On my system I have no fifo's with that type, only 
sockets.
-allow postfix_master_t postfix_private_t:fifo_file getattr;
+allow postfix_master_t postfix_private_t:fifo_file create_file_perms;

For the following, are you sure that you have the programs in the right 
domains?
-allow postfix_master_t postfix_prng_t:file getattr;
+allow postfix_master_t postfix_prng_t:file { getattr lock read write };
+allow postfix_master_t random_device_t:chr_file { read };
The following file_contexts line was changed recently to cover a change in the 
default Debian setup for Postfix, maybe this is something you need.
/usr/lib/postfix/(n)?qmgr       system_u:object_r:postfix_qmgr_exec_t

What is this one used for?
+allow postfix_pickup_t self:udp_socket { create ioctl };

Could you show me some dmesg output?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
