Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MKxPQw005481
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 16:59:25 -0400
Received: by mail-lf0-f44.google.com with SMTP id h4so37985262lfj.3
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 13:59:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB167814F66EEF8A1BD77C793AC4F80@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <1495198139-69993-3-git-send-email-danielj@mellanox.com>
 <alpine.LRH.2.20.1705220959450.3502@namei.org>
 <VI1PR05MB167814F66EEF8A1BD77C793AC4F80@VI1PR05MB1678.eurprd05.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 May 2017 16:59:15 -0400
Message-ID: <CAHC9VhS-W6NaraJB9uCzpAQvUq1+XL+f6YUnqOzAPa6Q56b0FQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] IB/core: Enforce PKey security on QPs
To: Daniel Jurgens <danielj@mellanox.com>
Cc: James Morris <jmorris@namei.org>, Chris Wright <chrisw@sous-sol.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 22, 2017 at 6:42 AM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 5/21/2017 7:13 PM, James Morris wrote:
>> On Fri, 19 May 2017, Dan Jurgens wrote:
>>
>>> security/security.c                  | 385 ++++++++++++++++++++++
>> This looks wrong -- merge problem?
>
> Yes, it was a merge problem.  I added back the per field initialization of the security head hooks.  Paul stripped this (and the same problem in patch 0004) himself before merging.
>
>>
>>
>>> +    if (pps->alt.state != IB_PORT_PKEY_NOT_VALID) {
>>> +            get_pkey_and_subnet_prefix(&pps->alt,
>>> +                                       &pkey,
>>> +                                       &subnet_prefix);
>>> +
>>> +            ret = enforce_qp_pkey_security(pkey,
>>> +                                           subnet_prefix,
>>> +                                           sec);
>>> +    }
>>> +
>>> +    if (ret)
>>> +            goto out;
>> The above if/goto is unnecessary.
>
> Right.
>
> Paul, do you want me to fix this with a new patch?

Since this isn't a build or runtime failure, just a style correction,
I'll leave it up to you: either post a 10/9 patch which converts all
the jumps-to-return to just return, or respin/resubmit the patches.
If you do the latter, just resubmit the affected patches and not the
whole patchset.

-- 
paul moore
www.paul-moore.com
