Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA15731
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 11:24:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA15492
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 15:22:52 GMT
Received: from torpid.com (infoblox.com [64.39.15.22])
	by jazzswing.ncsc.mil  with SMTP id PAA15488
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 15:22:52 GMT
Date: Sat, 20 Apr 2002 10:24:33 -0500 (CDT)
From: Ivan Pulleyn <ivan@torpid.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
In-Reply-To: <20020420123709.465F819143@lyta.coker.com.au>
Message-ID: <Pine.LNX.4.10.10204201020030.2381-100000@norway.torpid.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



I don't know how granular these policies can get (I'm just a lurker on
this list), but it would be cool if you could restrict boot_loader to
access only the first couple disk blocks where lilo writes to, and
privmem to only the less than 1MB region where BIOS values are.

Ivan...


On Sat, 20 Apr 2002, Russell Coker wrote:

> I am creating a policy for lilo.
> 
> I have defined it's type as follows:
> type lilo_t, domain, privlog, privmem, boot_loader;
> 
> privmem is because lilo needs to read from /dev/mem to get BIOS data about 
> boot devices.  I have defined "boot_loader" as a type attribute for anything 
> that needs to write to raw hard drive devices to install a boot loader (grub 
> etc would need that too).  Then I added boot_loader in assert.te as being 
> allowed to write to fixed_disk_device_t.
> 
> What do you think?
> 
> -- 
> If you send email to me or to a mailing list that I use which has >4 lines
> of legalistic junk at the end then you are specifically authorizing me to do
> whatever I wish with the message and all other messages from your domain, by
> posting the message you agree that your long legalistic sig is void.
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
