Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h54C0rI4021708
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 08:00:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h54C0Jss013287
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 12:00:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h54C0HhY013284
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 12:00:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: file labels during init process
Date: Wed, 4 Jun 2003 21:59:59 +1000
References: <200306041048.19435.carsten.grohmann@raumbildsysteme.de>
In-Reply-To: <200306041048.19435.carsten.grohmann@raumbildsysteme.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306042159.59076.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Jun 2003 18:48, Carsten Grohmann wrote:
> Today I found this log message:
> avc:  denied  { search } for  pid=1 exe=/sbin/init path=/var/log
> dev=03:09 ino=6 scontext=system_u:system_r:init_t
> tcontext=system_u:object_r:file_t tclass=dir
>
> I have a problem with this entry. The complete filesystem is labeled
> correct. The partition hda7 mounted as /var/log is also labled with
> the correct type. Could it be that the init process access the
> filesystem before the labels "grasp"?

It looks like init accessed /var/log before the /var/log filesystem was 
mounted.  As you apparently labeled the /var filesystem when /var/log was 
mounted it was not possible to label the /var/log mount-point directory.  
Therefore it had the default of file_t.

Probably it's best to put in a dontaudit rule for that.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
