Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB10XJBQ010031
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 19:33:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3ynwH00lMCz25sjD
 for <selinux@tycho.nsa.gov>; Fri,  1 Dec 2017 00:33:16 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3ynwH00B52z25sgK
 for <selinux@tycho.nsa.gov>; Fri,  1 Dec 2017 00:33:16 +0000 (UTC)
Date: Fri, 1 Dec 2017 11:33:05 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov
In-Reply-To: <151206074183.32567.881282052709289967.stgit@chester>
Message-ID: <alpine.LFD.2.20.1712011132550.31584@localhost>
References: <151206074183.32567.881282052709289967.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH] selinux: ensure the context is NULL terminated
 in security_context_to_sid_core()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 30 Nov 2017, Paul Moore wrote:

> From: Paul Moore <paul@paul-moore.com>
> 
> The syzbot/syzkaller automated tests found a problem in
> security_context_to_sid_core() during early boot (before we load the
> SELinux policy) where we could potentially feed context strings without
> NULL terminators into the strcmp() function.
> 
> We already guard against this during normal operation (after the SELinux
> policy has been loaded) by making a copy of the context strings and
> explicitly adding a NULL terminator to the end.  The patch extends this
> protection to the early boot case (no loaded policy) by moving the context
> copy earlier in security_context_to_sid_core().
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>
