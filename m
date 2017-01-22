Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0N6e1gN023476
 for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2017 01:40:01 -0500
Received: from athena.localnet (unknown [1.136.15.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: russell@coker.com.au)
 by smtp.sws.net.au (Postfix) with ESMTPSA id 4598EEC7D
 for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2017 17:39:51 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Reply-To: russell@coker.com.au
Subject: NFS mount contexts
Date: Sun, 22 Jan 2017 17:17:02 +1100
Message-ID: <2241712.usJZ9WgKHP@russell.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=851143

I've filed a Debian bug report about systemd not using the context= mount 
option.

root@swssmtp:/tmp# grep unlabeled_t /var/log/audit/audit.log|head -1
type=AVC msg=audit(1484976198.164:160): avc:  denied  { search } for  pid=1090 
comm="maildrop" name="/" dev="0:40" ino=256 
scontext=system_u:system_r:procmail_t:s0 
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0
root@swssmtp:/tmp# grep unlabeled_t /var/log/audit/audit.log|tail -1
type=AVC msg=audit(1484976262.152:222): avc:  denied  { search } for  pid=1173 
comm="maildrop" name="/" dev="0:40" ino=256 
scontext=system_u:system_r:procmail_t:s0 
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0

Also I've got a problem with kernel 4.9.2 apparently having an NFS mount as 
unlabeled_t for a minute after it's first mounted.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
