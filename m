Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9EATh0C027598
 for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2017 06:29:44 -0400
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id 42AE656419
 for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2017 06:29:40 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id tD9QQqZ3TpUY for <selinux@tycho.nsa.gov>;
 Sat, 14 Oct 2017 06:29:37 -0400 (EDT)
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id 220F75641A
 for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2017 06:29:37 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id dWus8fcZbHkd for <selinux@tycho.nsa.gov>;
 Sat, 14 Oct 2017 06:29:34 -0400 (EDT)
Received: from rhea.itechfrontiers.com ([10.7.14.47])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: cto@itechfrontiers.com)
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTPSA id 34D5256419
 for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2017 06:29:33 -0400 (EDT)
To: SELinux <selinux@tycho.nsa.gov>
From: "Patrick K., ITF" <cto@itechfrontiers.com>
Message-ID: <931fd53b-672e-808c-73e7-077dd75affed@itechfrontiers.com>
Date: Sat, 14 Oct 2017 06:29:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: RowHammer Protection
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

Any proposed method using SELinux to counter RowHammer attacks On Linux?

Unfortunately hardware based protection is no longer any use as the Row 
Hammer attack evolved and bypassed hardware protection, and the 
following paper defeats the protection mechanisms we took.

Any proposals?

Paper: Another Flip in the Wall of Rowhammer Defenses
https://arxiv.org/pdf/1710.00551.pdf


Note: Please consider sudo here is a sample, so just blocking sudo won't 
help really.

QUOTE
XI. Conclusion
In this paper, we showed that even a combination of all state-of-the-art 
Rowhammer defenses does not prevent Rowhammer attacks. Our novel attack 
and exploitation primitives systematically undermine the assumptions of 
all defenses. With one-location hammering, we showed that previous 
assumptions on how the Rowhammer bug can be triggered are invalid and 
keeping only one DRAM row constantly open is sufficient to induce bit 
flips. With a slow-down factor of only 3.3, it is still on par with 
previous (now mitigated) techniques. With opcode flipping, we bypass all 
memory layout-based defenses by flipping bits in a predictable and 
targeted way in the userspace sudo binary. We present 29 bit offsets, 
each allowing an attacker to obtain root privileges in practice. With 
memory waylaying, we present a reliable technique to replace conspicuous 
and unstable memory spraying and grooming techniques. Coaxing the 
operating system into relocating any binary page takes 2.68 s with our 
stealth-optimized variant, and only 36.7 µs with our speed-optimized 
variant. Finally, we leveraged Intel SGX to hide the full 
privilege-escalation attack, making any inspection or detection of the 
attack infeasible. Consequently, our attack evades all previously 
proposed countermeasures for commodity systems

UNQUOTE

Best regards,

-- 
  Patrick K.
