Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26BwQ19025649
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 06:58:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AB978182D0C
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:22 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC202026DFD
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:21 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue,  6 Mar 2018 12:58:05 +0100
Message-Id: <20180306115808.17470-1-vmojzis@redhat.com>
Subject: libsemanage: Perform access check using euid instead of uid
 v2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Changes: 
  - replace semanage_copy_file by copy_file_if_exists to make sure "retval" is 0 if the file does not exist
  - restructure if statements to be more clear ("fail" is last part of the statement)
  - replace read test (attempt to open the file) by stat() call
