Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3G9SjJP026349
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 05:28:45 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3G9SgqZ005674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 05:28:42 -0400
Received: from oldenburg.str.redhat.com (oldenburg.str.redhat.com
 [10.33.200.60])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t3G9SfjO002523
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 05:28:42 -0400
Message-ID: <552F80C8.9060809@redhat.com>
Date: Thu, 16 Apr 2015 11:28:40 +0200
From: Florian Weimer <fweimer@redhat.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Impersonating a process for file creation purposes
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The ABRT coredump handler has code to emulate default core file creation
(as if no such pipe-based handler was installed).  The handler runs in a
separate process, initially as root.  Currently, the handler just
switches effective IDs and creates the file.  This does not replicate
the SELinux context of the zombie process.

Is there a way to do that?   Is there some recommended way to inherit
all the security-related process attributes?

-- 
Florian Weimer / Red Hat Product Security
