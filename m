Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5ULUthx004543
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 17:30:55 -0400
Received: by mail-oi0-f54.google.com with SMTP id r2so84755903oih.2
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 14:30:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM4PR0501MB2257674DEA1F81F53A35AC21C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-2-git-send-email-danielj@mellanox.com>
 <CAGH-KgtcpKPciy-1-KhQDw2xA5-35t_W9TKCf3z9tj=Vg_hjsg@mail.gmail.com>
 <AM4PR0501MB2257674DEA1F81F53A35AC21C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 30 Jun 2016 17:30:53 -0400
Message-ID: <CAGH-KgvGn5btCGQGEiEHWrW4RZebjuoPYRSTz6RYzg=fXTbX2w@mail.gmail.com>
Subject: Re: [PATCH 01/12] security: Add LSM hooks for Infiniband security
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "paul@paul-moore.com" <paul@paul-moore.com>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 30, 2016 at 5:27 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 6/30/2016 3:33 PM, Paul Moore wrote:
>> On Thu, Jun 23, 2016 at 3:52 PM, Dan Jurgens <danielj@mellanox.com> wrote:
>>
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index 432bed5..3f6780b 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -1428,6 +1428,10 @@ struct ib_srq {
>>>         } ext;
>>>  };
>>>
>>> +struct ib_qp_security {
>>> +       void *q_security;
>>> +};
>> Sorry, I missed this earlier and didn't realize it until I was going
>> through 4/12 ... why both with ib_qp_security?  Why not just use a
>> straight void pointer?
>>
> In the RFC series Casey Schaufler asked me to not use void blobs to make module stacking easier.

I'm not entirely sure that is what he had in mind, but ...

> Also, in the IB/Core part of the series much is added to the ib_qp_security structure to track security info needed for proper enforcement.

... okay, I'll reserve further comment until I get there.

-- 
paul moore
security @ redhat
