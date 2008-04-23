Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3NJGKQh003591
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2008 15:16:20 -0400
Received: from web63005.mail.re1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3NJGKeq015128
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2008 19:16:20 GMT
Date: Wed, 23 Apr 2008 12:07:52 -0700 (PDT)
From: run zhang <zhang4run@yahoo.com>
Subject: labelling with genfscon
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-126358939-1208977672=:20897"
Message-ID: <358705.20897.qm@web63005.mail.re1.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-126358939-1208977672=:20897
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

In the NSA example policy package, the genfs_contexts explains that except /proc, all other filesystems without xattr support are limited to a single entry /. Can I specify the subdirs of a filesystem with different lables with genfscon just like /proc? 
  More specifically, I am using NFS and cramfs, where I specify 
  genfscon nfs /   root_t
  genfscon nfs /bin bin_t
   
  However, after boot and load the result policy, still every dir in rootfs is labelled with root_t. It seems the same result for cramfs. According this thread: http://marc.info/?l=selinux&m=102587231814793&w=2, it seems that this should be doable. 
  Please give hand, thanks very much!
   
  --Run
   

       
---------------------------------
Be a better friend, newshound, and know-it-all with Yahoo! Mobile.  Try it now.
--0-126358939-1208977672=:20897
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>In the NSA example policy package, the genfs_contexts explains that except /proc, all other filesystems without xattr support are&nbsp;limited to a single entry /.&nbsp;Can&nbsp;I specify the subdirs&nbsp;of a filesystem with different lables with genfscon just like /proc? </div>  <div>More specifically, I am using NFS and cramfs, where&nbsp;I specify </div>  <div>genfscon nfs /&nbsp;&nbsp; root_t</div>  <div>genfscon nfs /bin bin_t</div>  <div>&nbsp;</div>  <div>However,&nbsp;after&nbsp;boot and load the&nbsp;result policy, still every dir in rootfs is&nbsp;labelled with root_t.&nbsp;It seems the same result for cramfs. According this&nbsp;thread: <A href="http://marc.info/?l=selinux&amp;m=102587231814793&amp;w=2">http://marc.info/?l=selinux&amp;m=102587231814793&amp;w=2</A>, it seems that this should be doable. </div>  <div>Please give hand, thanks very much!</div>  <div>&nbsp;</div>  <div>--Run</div>  <div>&nbsp;</div><p>&#32;



      <hr size=1>Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile. <a href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ "> Try it now.</a>
--0-126358939-1208977672=:20897--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
