Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9U41UWt010953
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 23:01:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9U41TXK011522
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 04:01:29 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
        by jazzband.ncsc.mil  with ESMTP id h9U40Jj4011509 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 04:00:43 GMT
Message-ID: <3FA08C65.2020309@diyab.net>
Date: Wed, 29 Oct 2003 22:58:29 -0500
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Diamond Rio 500 and other device nodes
References: <200310300227.27364.russell@coker.com.au>
In-Reply-To: <200310300227.27364.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

> What do you think is the correct type for the device node for the "Diamond Rio 
> 500" (/dev/usb/rio500)?
> 
> It's a portable MP3 player and storage device with a USB interface, so I think 
> that removable_device_t is appropriate, in concept it's similar to a floppy 
> disk drive.
> 
> Also I've used scanner_device_t for USB digital cameras, I think of a camera 
> as a portable scanner.  ;)  But I guess a case could be made for considering 
> digital cameras to be removable storage.
> 
> 
> I have been considering whether I should merge the v4l_device_t device nodes 
> with those for scanners.  However I think that although the concept is the 
> same the likely use is different.  Having one program to use v4l to control a 
> security system while another program acts as a scanner server is likely, 
> while it's likely that a program which is authorised for accessing a scanner 
> will also be authorised for digital cameras.
> 

Just curious, but how will the files on the device be labeled once the 
device is mounted?  For example if I plug in my digital camera and mount 
it so that I can copy the pictures from it am I going to have access to 
read the files?  Will I even be able to mount it as a normal user?  Is 
this going to be a problem since we can't label the device filesystem?

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
