Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, SELinux@tycho.nsa.gov
Subject: Re: distribution of kernel patches
Date: Fri, 28 Sep 2001 23:50:36 +0200
References: <200109281941.OAA50738@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200109281941.OAA50738@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <20010928215036.8D8E6AE50@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Sep 2001 21:41, Jesse Pollard wrote:
> > Also could the kernel patch please change the EXTRAVERSION variable in
> > the top-level makefile?  Currently the kernel-patch package I am playing
> > with changes it from "-lsm" to "-selinux", but it would be equally valid
>
> Actually, I would prefer the "EXTRAVERSION" be left alone and/or add a new
> form of EXTRAVERSION (I'll call it "LOCALVERSION") be made generally
> available.

That would be OK too.  However using a LOCALVERSION would require more 
patches to the main kernel tree which would need to be separate from what we 
are doing, which means more patches to juggle.

Sending a patch to Alan that implements LOCALVERSION might be a good idea.

For the moment I think that we have no realistic choice apart from using 
EXTRAVERSION as it's all we can do.

I take it that you agree that we need some way of knowing from the early boot 
stages whether we are running selinux, plain lsm, or neither?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
