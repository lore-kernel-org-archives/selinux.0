Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45BkqKX009130
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 07:46:52 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id C55501A21E
 for <selinux@tycho.nsa.gov>; Thu,  5 May 2016 13:46:48 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id T6xgyQS4_Rx3 for <selinux@tycho.nsa.gov>;
 Thu,  5 May 2016 13:46:45 +0200 (CEST)
Received: from [IPv6:2a02:578:85fc:1::6b5] (unknown
 [IPv6:2a02:578:85fc:1::6b5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 134971A218
 for <selinux@tycho.nsa.gov>; Thu,  5 May 2016 13:46:45 +0200 (CEST)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: Licence of the new setools icons
Message-ID: <ed0f0b63-8fc6-a136-b5c9-950f1abca19b@debian.org>
Date: Thu, 5 May 2016 13:46:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

setools(4) includes a new set of icons. The COPYING file included in the 
same directory states:

===

Icons are sourced from the Koloria Free Icons Set

Terms of Use
* Koloria Icon Set can be used in open source or commercial projects for 
free.
* When you mention Koloria Icon Set, please refer to this[1] 
page/download link.
* Do not sell the package on graphic stock sites -- this pack is 
intended to be
   free. You may include the icons in your commercial 
themes/designs/creations.
* Do not claim to be the author of this icon set.

[1] http://www.graphicrating.com/2012/06/14/koloria-free-icons-set/

===

This doesn't seems free (as in freedom) as the license doesn't give 
right to modify the icons.

This will make it difficult to include setools in some distro (Debian, 
Fedora,...).

Couldn't the icons already present in the Qt icons theme be used 
instead? Most of them should have equivalent.

Laurent Bigonville
