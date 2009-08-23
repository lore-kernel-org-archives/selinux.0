Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7NH2JCL012335
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 13:02:19 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7NH1itd024854
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 17:01:45 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: 498320-forwarded@bugs.debian.org, Russell Coker <russell@coker.com.au>
Subject: policycoreutils: audit2allow gives bad policy for role violations
Date: Sun, 23 Aug 2009 09:52:37 -0500
Message-ID: <878whavayy.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        This has been reported against the Debian BTS.
=========== ROLES ===============
role system_r types ssh_exec_t;

        The above policy is given as the output of audit2allow for the
 below kernel message:

type=SELINUX_ERR msg=audit(1220928625.787:79): security_compute_sid:
invalid context unconfined_u:system_r:user_t:s0-s0:c0.c1023 for
scontext=unconfined_u:system_r:inetd_t:s0-s0:c0.c1023
tcontext=system_u:object_r:ssh_exec_t:s0 tclass=process

        One possibility is to have the following, although it might be
 best to just flag the error and let the sys-admin decide on their own
 way of solving it (there are several possibilities that are equally
 valid): 

        role_transition system_r ssh_exec_t user_r;

        manoj

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=498320
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
