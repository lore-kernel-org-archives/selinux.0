Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2QHYWRb025106
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 12:34:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2QHYVFV005460
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 17:34:31 GMT
Received: from thumbler.kulnet.kuleuven.ac.be (thumbler.kulnet.kuleuven.ac.be [134.58.240.45])
        by jazzband.ncsc.mil  with ESMTP id i2QHYU36005451 for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 17:34:31 GMT
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 4E1DF137A26
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 18:34:30 +0100 (CET)
Received: from lepidus.kulnet.kuleuven.ac.be (lepidus.kulnet.kuleuven.ac.be [134.58.240.72])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id CA958137A13
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 18:34:29 +0100 (CET)
Received: from [10.0.57.79] (zen.kotnet.org [10.0.57.79])
	by lepidus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 65DEC38005A
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 18:34:29 +0100 (CET)
Mime-Version: 1.0 (Apple Message framework v613)
Message-Id: <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: selinux@tycho.nsa.gov
From: Koen Vervloesem <koen.vervloesem@student.kuleuven.ac.be>
Subject: make relabel: invalid context
Date: Fri, 26 Mar 2004 18:34:28 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have installed the SELinux tools on Debian with the Linux 2.6.4 
kernel with SELinux support. The package selinux-policy-default doens't 
get installed, and gives very strange errors, so I decided to get the 
NSA policy example (www.nsa.gov/selinux/code/download5.cfm). I did get 
through make policy and make install, but when I execute make relabel I 
get a bunch of errors:

root@carnivore:/etc/selinux# make relabel
/usr/sbin/setfiles file_contexts/file_contexts `mount | awk 
'/ext[23]/{print $3}'`
/usr/sbin/setfiles:  read 643 specifications
/usr/sbin/setfiles:  invalid context system_u:object_r:file_t on line 
number 39
/usr/sbin/setfiles:  invalid context system_u:object_r:root_t on line 
number 44
/usr/sbin/setfiles:  invalid context system_u:object_r:var_t on line 
number 49
/usr/sbin/setfiles:  invalid context system_u:object_r:catman_t on line 
number 50
/usr/sbin/setfiles:  invalid context system_u:object_r:catman_t on line 
number 51
/usr/sbin/setfiles:  invalid context system_u:object_r:var_yp_t on line 
number 52
/usr/sbin/setfiles:  invalid context system_u:object_r:var_lib_t on 
line number 53
/usr/sbin/setfiles:  invalid context system_u:object_r:var_lib_nfs_t on 
line number 54
/usr/sbin/setfiles:  invalid context system_u:object_r:tetex_data_t on 
line number 55
/usr/sbin/setfiles:  invalid context system_u:object_r:tetex_data_t on 
line number 56
Exiting after 10 errors.
make: *** [relabel] Fout 1
root@carnivore:/etc/selinux#

I can't find an error in the configuration files. Does anyone know 
what's wrong here?

Thanks in advance,

Koen
--
"You do not truly know someone until you fight them. "  (Seraph , "The 
Matrix Reloaded")


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
