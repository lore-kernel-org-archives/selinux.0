Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UBmvrT026412
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 07:48:57 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6UBmPTf010938
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 11:48:26 GMT
Received: from localhost (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11/Debian-5) with ESMTP id i6UBmmPg000661
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 13:48:51 +0200
Subject: Re: Building SE-ssh. Result: fakeroot: Permission denied
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1091187766.18595.153.camel@debby>
References: <1091187766.18595.153.camel@debby>
Content-Type: text/plain
Message-Id: <1091188128.18595.158.camel@debby>
Mime-Version: 1.0
Date: Fri, 30 Jul 2004 13:48:48 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-30 at 13:42, Wolfgang Pfeiffer wrote:
> Hi All
> 

     [ ... ]   


> ssh.getandbuild.sh:
> #######################################################
> #!/bin/sh -x
> /bin/sh -n $HOME/ssh.getandbuild.sh && \
> cd $HOME/test/ && \
> rm -rf * && \
> curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1.orig.tar.gz && \
> curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz && \
> curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz.sign && \
> curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1-7.se1.diff.gz && \
> tar -xzvf *\.tar.gz && \
> cd openssh-3.8.1p1/ && \
> cp ../openssh_3.8.1p1-7.se1.diff.gz . && \
> gzip -cd  openssh_3.8.1p1-7.se1.diff.gz | patch -p1 && \
> autoconf && \
> fakeroot debian/rules binary
> ####################################################
> 
> The script above, according to the ssh.log log file, ends like that:
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Should say:
Running the script above, according to the ssh.log log file, ends like
that:


> 
> + autoconf
> + fakeroot debian/rules binary
> /usr/bin/fakeroot: line 146: debian/rules: Permission denied
> 
         [ ... ]

Sorry
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
