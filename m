From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Douglas Williams" <douglaswilliams@sympatico.ca>,
   "SELinux" <SELinux@tycho.nsa.gov>
Subject: Re: StrongArm port
Date: Mon, 16 Feb 2004 16:52:32 +1100
References: <005701c3f441$e13d7a20$6401a8c0@williams>
In-Reply-To: <005701c3f441$e13d7a20$6401a8c0@williams>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402161652.32834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Feb 2004 15:03, "Douglas Williams" <douglaswilliams@sympatico.ca> 
wrote:
> Does anyone know where I can get a good linux kernel for an IPAQ 3850. My
> next robot must have a secure OS especially since it will use an RF data
> link with relatively weak encryption.

The new SE Linux requires XATTR support in the file system.

The 2.4 kernels for the iPaQ do not have any XATTR code, if the patch was 
merged (which is more difficult than you might imagine as Familiar uses 
2.4.19 which is heavily modified) then support would still have to be written 
for the JFFS2 file system.  I think that we will never see 2.4.x on the iPaQ 
supporting XATTRs.

2.6 on the iPaQ is a work in progress.  Whether they will back-port it to 
older iPaQ's such as the 3800 series is something I'm unsure of.  I get the 
impression that the key developers have moved on from the 3900 series and are 
not going to do much more for it, so I'm not sure what that means for the 
older 3800 series.

When 2.6 is running on iPaQ's, then someone needs to write XATTR support for 
JFFS2.  After that getting the new SE Linux running on iPaQ's should be easy.


Old SE Linux works on iPaQ's, but there will not be much future support for 
that.


If you use an IBM mini-disk formatted with Ext3 then you could use new SE 
Linux on an iPaQ.  Of course you would still have to back-port the kernel 
patches to 2.4.19...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
