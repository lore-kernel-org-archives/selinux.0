Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0P6MbOf032521
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 01:22:37 -0500
Received: from athena.localnet (ppp118-209-214-81.bras2.mel11.internode.on.net
 [118.209.214.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: russell@coker.com.au)
 by smtp.sws.net.au (Postfix) with ESMTPSA id 9DA18EC7D
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 17:22:29 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Reply-To: russell@coker.com.au
Subject: strange avc
Date: Wed, 25 Jan 2017 17:22:29 +1100
Message-ID: <1765226.bX7GAK7GcY@russell.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

type=AVC msg=audit(1485258907.829:106): avc:  denied  { 0x800000 } for  
pid=1280 comm="rewrite-0" name="after-the-deadline" dev="vda" ino=104107534 
scontext=system_u:system_r:httpd_t:s0 
tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0

I got the above after upgrading a system running kernel 3.16.0 to the latest 
userspace.  Why is this happening?  Is this a bug?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
