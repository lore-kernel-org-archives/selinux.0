Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Still problems with RedHat8.0
Date: Wed, 20 Nov 2002 01:16:18 +0100
Cc: azeredo@qmc.ufsc.br, SELinux@tycho.nsa.gov
References: <1037722529.3dda63a114991@qmc.ufsc.br> <200211200033.35017.russell@coker.com.au> <20021120001641.GF28431@snoopy.apana.org.au>
In-Reply-To: <20021120001641.GF28431@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200211200116.18933.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Nov 2002 01:16, Brian May wrote:
> On Wed, Nov 20, 2002 at 12:33:35AM +0100, Russell Coker wrote:
> > > avc:  denied  { read } for  pid=751 exe=/usr/bin/magicdev path=/dev/hdd
> > > dev=03:05 ino=33539 scontext=root:sysadm_r:sysadm_t
> > > tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file
> >
> > What is magicdev?
>
> According to <URL:http://www.ccs.neu.edu/home/bchafy/magicdev.html>, it
> is "an automount/autoplay package for CD's and floppy's under linux
> redhat 6.1".

OK, that will require it's own policy if it's to work.  However I suspect that 
anyone who wants security does not want such "features"...

The autorun feature of inserting CDs in Windows has been the cause of quite a 
few security issues.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
