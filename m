Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w73GIxCM004137
 for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2018 12:18:59 -0400
To: Piotr Sawicki <p.sawicki2@partner.samsung.com>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
Cc: "Schaufler, Casey" <casey.schaufler@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
 <CGME20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663@eucas1p2.samsung.com>
 <20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M@eucas1p2.samsung.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0c4b4f28-e51f-8b5d-9259-c6ab97c5c506@schaufler-ca.com>
Date: Fri, 3 Aug 2018 08:27:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v1 20/22] Move common usercopy into
 security_getpeersec_stream
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/3/2018 2:10 AM, Piotr Sawicki wrote:
> On 07/16/2018 08:24 PM, Casey Schaufler wrote:
>> [PATCH 20/22] Move common usercopy into security_getpeersec_stream
>>
>> The modules implementing hook for getpeersec_stream
>> don't need to be duplicating the copy-to-user checks.
>> Moving the user copy part into the infrastructure makes
>> the security module code simpler and reduces the places
>> where user copy code may go awry.
> Hi,
>
> This change will break the API. Some clients may call getsockopt(..,SO_PEERSEC,..) twice. Firstly, to fetch the length. In that case xxx_socket_getpeersec_stream should return -ERANGE and set *optlen. Secondly, to retrieve a proper security label.

Nuts. You're correct. I will fix this in the next round.

>
> Please take a look at the implementation of the getClientSmackLabel() function in Cynara: https://review.tizen.org/gerrit/#/c/26888/6/src/helpers/creds-socket/creds-socket-inner.cpp
> Also there is an email thread about this socket option which tells us why it is made this way: "[RFC] SO_PEERSEC - security credentials for Unix stream sockets"
>
> http://lists.jammed.com/linux-security-module/2003/12/0029.html
>
> Regards,
> Piotr
>
