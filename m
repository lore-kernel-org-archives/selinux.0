Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6MDf4V8032707
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 09:41:04 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E6F07EA82
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-200-65.brq.redhat.com
 [10.40.200.65])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u6MDf0TP005491
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 09:41:01 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Miroslav Grepl <mgrepl@redhat.com>
Subject: rpm running with MLS range?
Message-ID: <b479402e-d234-676b-ea5e-33c7d966729f@redhat.com>
Date: Fri, 22 Jul 2016 15:41:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi folks,
we define a MLS range for some directories in the policy and because we
have a SELinux support in rpm, we can end up with AVC msgs like

type=AVC msg=audit(1461664028.583:784): avc:  denied  { relabelto } for
pid=14322 comm="yum" name="libvirt" dev="dm-0" ino=670147
scontext=root:system_r:rpm_t:s0
tcontext=system_u:object_r:virt_cache_t:s0-s15:c0.c1023 tclass=dir

Does it make sense to have rpm_t running with a range or should we think
about a new MLS attribute for "file ( relableto )"?

Thank you,

-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
