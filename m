Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3Bi5Wt028893
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 06:44:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3BhiC7000714
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 11:43:45 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hA3Bhiuw000711
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 11:43:44 GMT
Date: Mon, 3 Nov 2003 11:43:53 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: default policy package
Message-ID: <20031103114353.GC13273@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looks like X windows has really stuck it's tentacles
into the policy. I can't compile one without it. Something
in the macros that I haven't tracked down yet:

ERROR: unknown type initrc_xserver_tmp_t' at token ':' on line 6198:
allow sysadm_uml_t initrc_xserver_tmp_t:dir search;

so I removed uml.te, which I didn't need anyway. Next run
I've now got:

ERROR: unknown type sysadm_xserver_t' at token ':' on line 7525:
allow sysadm_xserver_t xserver_tmpfile:dir { read getattr lock search ioctl add name remove_name write };

This is just some examples. I've been fighting this
all morning without finding a set that works without 
any X. (Hardly need X for a machine that normally doesn't
even have a terminal on it, and when it does it's an old
dumb b&w character only glass tty)

I haven't specifically seen where the problem is coming
from yet: everything seems to have ifdef's around it
on startx.te or xserver.te but I've not gone through
every file.

I'll keep at it, but suggestions are welcome. 
-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
