Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: some missing printer devices
Date: Sun, 15 Sep 2002 19:18:01 +0200
References: <200209151641.QAA28645@jazzband.ncsc.mil>
In-Reply-To: <200209151641.QAA28645@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200209151918.01141.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 15 Sep 2002 18:42, Carsten Grohmann wrote:
> The attached patch add some missing printer devices lpd.fc.

/dev/usblp* is not in devices.txt so it's probably not suitable for 
distributing.

/dev/ttyS* is more commonly used for ppp, the next most common use is for 
serial port logins.  The policy should reflect this, tty_device_t is the 
current type and it works well.

I can't recall ever seeing a serial printer, modern printers can't be serial 
because they use too much data transfer.  Anyone who has a serial printer 
will have to do some customising of their policy.

Also when updating policy for /dev entries make sure you update the genfs 
entries for the devfs file system.

I've added /dev/lp* and /dev/usb/lp* to my policy tree with matching changes 
to the genfs_contexts file.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
