Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n16GLGUP019562
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2009 11:21:16 -0500
Received: from mho-02-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n16GLBE1012331
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2009 16:21:15 GMT
Received: from cpe-66-68-165-162.austin.res.rr.com ([66.68.165.162] helo=[192.168.20.230])
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1LVTRx-0005qv-HW
	for selinux@tycho.nsa.gov; Fri, 06 Feb 2009 16:21:05 +0000
Message-Id: <58C746BE-D2EA-4B17-B7F8-37F57E0AD806@nall.com>
From: Joe Nall <joe@nall.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: security_compute_av_raw confusion
Date: Fri, 6 Feb 2009 10:21:02 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I confused by the behavior of security_compute_av_raw in fedora rawhide
...
rc = security_compute_av_raw(ctx, raw, SECCLASS_CONTEXT,  
CONTEXT__CONTAINS, &avd);
log_debug("ctx=%s raw=%s avd.allowed=%d rc=%d\n", ctx, raw,  
avd.allowed, rc);
...

with ctx and raw identical user contexts, it works as expected:

ctx=user_u:user_r:user_t:s15:c0.c1023  
raw=user_u:user_r:user_t:s15:c0.c1023 avd.allowed=2 rc=0

with ctx and raw identical system contexts, it behaves differently:

ctx=system_u:system_r:setrans_t:s15:c0.c1023  
raw=system_u:system_r:setrans_t:s15:c0.c1023 avd.allowed=1 rc=0

both in mls/permissive. No obvious avcs.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
