Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2RFGQvf031278
 for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2015 11:16:26 -0400
Message-ID: <551574CF.5020201@tycho.nsa.gov>
Date: Fri, 27 Mar 2015 11:18:39 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 0/3] libsepol, policycoreutils, and checkpolicy: Add support
 for generating CIL to libsepol and checkpolicy
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch set moves the code to generate CIL from pp.c in 
policycoreutils/hll/pp to libsepol, adds a new function to generate CIL from a 
module policydb, and modifies checkpolicy and checkmodule to support generating 
CIL as their output.

The primary motivation of this work is to allow SE for Android to use the CIl 
compiler. Converting the policy.conf to CIL and then compiling to the kernel 
binary policy results in a policy that is about 20% smaller. The smaller size is 
because type expressions with negations are converted to type attribute sets in 
CIL instead of being expanded.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
