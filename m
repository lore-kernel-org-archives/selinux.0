Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9LLxr6w018641
 for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2015 17:59:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 7C2DEC0BEAA3
 for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2015 21:59:44 +0000 (UTC)
Received: from sifl.localnet (vpn-53-69.rdu2.redhat.com [10.10.53.69])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t9LLxh8k015574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2015 17:59:44 -0400
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Re: [GIT PULL] SELinux patches for 4.4
Date: Wed, 21 Oct 2015 17:59:43 -0400
Message-ID: <1915624.B5IT58XOGq@sifl>
In-Reply-To: <2506963.zmKhoxexGn@sifl>
References: <2506963.zmKhoxexGn@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, October 21, 2015 05:57:27 PM Paul Moore wrote:
> Hi James,
> 
> Nine SELinux patches in total for v4.4 ...

Just a FYI, I've rebased the selinux#next and selinux#upstream branches; my 
apologies if this causes anyone some extra headache, but I need to keep the 
SELinux tree fairly close to James' LSM tree since he doesn't like to do any 
merging.

-- 
paul moore
security @ redhat
