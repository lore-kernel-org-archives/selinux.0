Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8JH6QXA016683
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 13:06:27 -0400
Received: from macii.ads-oh.atg.titan.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8JH5uL7016444
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 17:05:57 GMT
Received: from [192.168.50.32] (macii.ads-oh.atg.titan.com [66.218.141.147])
	by macii.ads-oh.atg.titan.com (Postfix) with ESMTP id 68B23142699
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 16:57:15 +0000 (GMT)
Mime-Version: 1.0
Message-Id: <p0600203ac135cffa140b@[192.168.50.32]>
Date: Tue, 19 Sep 2006 13:06:19 -0400
To: selinux@tycho.nsa.gov
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: Problem with sshd and polyinstantiation
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have noticed that when I have polyinstantiation with the instance 
directory contained in the base directory, then sshd fails.  It 
appears that sshd goes through pam_namespace (which creates/mounts 
instance directories), and then launches another sshd process which 
also goes through pam_namespace.  The second sshd fails to stat the 
instance directory.

So, if my namespace.conf contains the following entry,
     /var/poly   /var/poly/poly-inst context adm
then when I ssh in as root, two sshd processes output pam_namespace 
messages  to /var/log/secure.  The first sshd successfully mounts the 
instance directory, but the second sshd is unsuccessful (since it's 
already mounted).  The second sshd outputs the following error:
   pam_namespace(sshd:session): Error stating /var/poly/poly-inst, No 
such file or directory
   pam_namespace(sshd:session): Error mounting 
/var/poly/poly-inst/root on /var/poly, No such file or directory

When I change the instance directory not to be a subdir of the base, 
then sshd works fine.  Is this a problem with sshd or is my setup 
incorrect ?

Thanks,
Rosalie

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
