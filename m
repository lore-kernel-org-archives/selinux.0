Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9UFMFWt013357
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 10:22:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9UFMDKl027915
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 15:22:14 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id h9UFMD5m027909 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 15:22:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Diyab <diyab@diyab.net>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Diamond Rio 500 and other device nodes
Date: Fri, 31 Oct 2003 01:33:36 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310300227.27364.russell@coker.com.au> <3FA08C65.2020309@diyab.net>
In-Reply-To: <3FA08C65.2020309@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310310133.36055.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 30 Oct 2003 14:58, Diyab wrote:
> Russell Coker wrote:
> > What do you think is the correct type for the device node for the
> > "Diamond Rio 500" (/dev/usb/rio500)?
> >
> > It's a portable MP3 player and storage device with a USB interface, so I
> > think that removable_device_t is appropriate, in concept it's similar to
> > a floppy disk drive.
>
> Just curious, but how will the files on the device be labeled once the
> device is mounted?  For example if I plug in my digital camera and mount
> it so that I can copy the pictures from it am I going to have access to
> read the files?  Will I even be able to mount it as a normal user?  Is
> this going to be a problem since we can't label the device filesystem?

I don't anticipate any need for things to operate differently to floppy disks.

Device nodes for floppy disks don't change type when they are mounted.

However there is a more important issue, we can't allow anyone other than an 
administrator to mount a ext3 file system from a floppy disk or other 
removable media.  If we do then it would be trivial to create a file system 
with a file of type newrole_exec_t and take over the system.

Steve, any ideas on how to solve this?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
