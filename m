Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA19935
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 08:42:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA25383
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 12:41:14 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id MAA25377
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 12:41:14 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524355@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Russell Coker
	 <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: RE: boot loader
Date: Mon, 22 Apr 2002 07:43:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Could you name the policy 
bootloader_t

This way we could include grub to

Mark

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tislabs.com]
> Sent: Monday, April 22, 2002 6:49 AM
> To: Russell Coker
> Cc: SE Linux
> Subject: Re: boot loader
> 
> 
> 
> On Sat, 20 Apr 2002, Russell Coker wrote:
> 
> > I am creating a policy for lilo.
> >
> > I have defined it's type as follows:
> > type lilo_t, domain, privlog, privmem, boot_loader;
> >
> > privmem is because lilo needs to read from /dev/mem to get 
> BIOS data about
> > boot devices.  I have defined "boot_loader" as a type 
> attribute for anything
> > that needs to write to raw hard drive devices to install a 
> boot loader (grub
> > etc would need that too).  Then I added boot_loader in 
> assert.te as being
> > allowed to write to fixed_disk_device_t.
> >
> > What do you think?
> 
> This sounds fine.  Once lilo has been moved into its own 
> domain, you might
> try removing direct access to fixed_disk_device_t from sysadm_t
> (the admin_domain macro).
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 
> 
> --
> You have received this message because you are subscribed to 
> the selinux list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
