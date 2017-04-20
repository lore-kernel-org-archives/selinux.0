Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3KKqvt8007645
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 16:52:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3KKmrYo036966
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 16:52:54 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29xvy26hxr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 16:52:54 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <ebarreto@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 17:52:52 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3KKqiau66977884
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 17:52:49 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3KKqT1Z018896
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 17:52:29 -0300
Received: from [9.18.235.81] (ebarreto-T430.br.ibm.com [9.18.235.81] (may be
 forged))
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v3KKqTQE018789
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 17:52:29 -0300
To: selinux@tycho.nsa.gov
From: Eduardo Barretto <ebarreto@linux.vnet.ibm.com>
Subject: Updating offline the commit_num file
Date: Thu, 20 Apr 2017 17:52:13 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <6731786d-a352-ce4b-b212-3b85735b571f@linux.vnet.ibm.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

I'm trying to do an offline update (i.e. issuing the semanage command)
of some files on SELinux, and then replace those files on the system
that is being updated.

I know that the semanage also updates the commit_num file. So my doubt is:

Do I need to care about updating the commit_num on the updated system?
Should I increment the commit_num by the same amount (resulted from the
semanage command) that the updated files where ?

Is there any code that is reading the value in the commit_num file and
if so, how is it using the value read?

If this is not the correct place to get this information, just let me know.

Thanks,
Best regards,
Eduardo
