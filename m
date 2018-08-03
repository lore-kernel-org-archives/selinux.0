Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w739AgXR010764
 for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2018 05:10:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20180803091012euoutp023c9d22ca6bccdcdb3e8bb662494bfc48~HVMc-qlIK2748527485euoutp02C
 for <selinux@tycho.nsa.gov>; Fri,  3 Aug 2018 09:10:12 +0000 (GMT)
From: Piotr Sawicki <p.sawicki2@partner.samsung.com>
To: Casey Schaufler <casey@schaufler-ca.com>, LSM
 <linux-security-module@vger.kernel.org>, LKLM
 <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>, John Johansen
 <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>, Tetsuo
 Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
Cc: "Schaufler, Casey" <casey.schaufler@intel.com>
Date: Fri, 3 Aug 2018 11:10:09 +0200
MIME-Version: 1.0
In-Reply-To: <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
Message-Id: <20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
 <CGME20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663@eucas1p2.samsung.com>
Subject: Re: [PATCH v1 20/22] Move common usercopy into
 security_getpeersec_stream
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/16/2018 08:24 PM, Casey Schaufler wrote:
> [PATCH 20/22] Move common usercopy into security_getpeersec_stream
> 
> The modules implementing hook for getpeersec_stream
> don't need to be duplicating the copy-to-user checks.
> Moving the user copy part into the infrastructure makes
> the security module code simpler and reduces the places
> where user copy code may go awry.

Hi,

This change will break the API. Some clients may call getsockopt(..,SO_PEERSEC,..) twice. Firstly, to fetch the length. In that case xxx_socket_getpeersec_stream should return -ERANGE and set *optlen. Secondly, to retrieve a proper security label.

Please take a look at the implementation of the getClientSmackLabel() function in Cynara: https://review.tizen.org/gerrit/#/c/26888/6/src/helpers/creds-socket/creds-socket-inner.cpp
Also there is an email thread about this socket option which tells us why it is made this way: "[RFC] SO_PEERSEC - security credentials for Unix stream sockets"

http://lists.jammed.com/linux-security-module/2003/12/0029.html

Regards,
Piotr
