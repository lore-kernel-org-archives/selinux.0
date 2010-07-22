Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6MLIBK2016983
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2010 17:18:11 -0400
Received: from smtp138.iad.emailsrvr.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6MLIB26008110
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2010 21:18:11 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp33.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 913A33017E
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2010 17:18:10 -0400 (EDT)
Received: from [192.168.20.165] (cpe-173-174-96-179.austin.res.rr.com [173.174.96.179])
	(Authenticated sender: joe@nall.com)
	by smtp33.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPA id 52B12302B9
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2010 17:18:10 -0400 (EDT)
From: Joe Nall <joe@nall.com>
Content-Type: text/plain; charset=us-ascii
Subject: Memory leak question in avc_context_to_sid question
Date: Thu, 22 Jul 2010 16:18:09 -0500
Message-Id: <5C0D2C82-5111-439D-8AAA-5FF17DD415F7@nall.com>
To: selinux@tycho.nsa.gov
Mime-Version: 1.0 (Apple Message framework v1081)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a snippet of code in a bigger class:

        security_id_t sid = NULL, osid = NULL;
        if (avc_context_to_sid(*thisContext, &sid) < 0 ||
            avc_context_to_sid(*otherContext, &osid) < 0)
            rlog(LOG_ERR, "%s: avc_context_to_sid failed: %m", process_name);

        struct av_decision avd = {0,0,0,0,0};
        int astat = avc_has_perm_noaudit(sid, osid, SECCLASS_FILE, FILE__READ, &avcref, &avd);
        if (astat < 0 && errno != EACCES)
            rlog(LOG_ERR, "%s: avc_has_perm_noaudit failed: %m", process_name);

        decision = (avd.allowed & FILE__READ) == FILE__READ;
        if (sid)
            sidput(sid);
        if (osid)
            sidput(osid);
        dcache->put(hashKey, decision);

that valgrind says is leaking memory

==3000== 25,470 bytes in 346 blocks are definitely lost in loss record 9 of 9
==3000==    at 0x46DFAEE: malloc (vg_replace_malloc.c:207)
==3000==    by 0x71670EF: strdup (in /lib/libc-2.9.so)
==3000==    by 0x4826E14: (within /lib/libselinux.so.1)
==3000==    by 0x4826F66: (within /lib/libselinux.so.1)
==3000==    by 0x4824B2A: avc_context_to_sid_raw (in /lib/libselinux.so.1)
==3000==    by 0x4824C03: avc_context_to_sid (in /lib/libselinux.so.1)
...

am I missing a cleanup call somewhere? This is a fairly old libselinux (2.0.79-4) on a patched up Fedora 10.

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
