Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A54@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: RE: can't start X window in enforce mode
Date: Thu, 16 Oct 2003 10:21:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to get X-windows to start with enforce set to "1" without any
luck.  I have moved the xserver.te file from the domains/program/unused
directory to the domains/program directory.  I have changed the dontaudit
line to allow as described here in the email below.  Any help would be
appreciated.

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Sunday, October 12, 2003 6:11 PM
To: lky; SELINUX
Subject: Re: can't start X window in enforce mode


On Mon, 13 Oct 2003 04:37, lky wrote:
>-------------- Why the system didn't display the denied message if the
> opration violate the policy? How should I configure my policy in order to
> start the X window? Thanks!

# memory_device_t access is needed if not using the frame buffer
dontaudit $1_xserver_t memory_device_t:chr_file read;

The above is the relevant section of policy in
macros/program/xserver_macros.te.  The X server tries to access /dev/mem
even 
if it doesn't need to.  Change the dontaudit rule to an allow for 
rw_file_perms and it should work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
