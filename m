Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5UJqo15025055
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 15:52:50 -0400
Received: by mail-oi0-f54.google.com with SMTP id u201so80904841oie.0
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 12:52:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM4PR0501MB22578AA5FF8B4062F650C581C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-4-git-send-email-danielj@mellanox.com>
 <20160630151005.GC22107@yuval-lap.uk.oracle.com>
 <AM4PR0501MB22578AA5FF8B4062F650C581C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 30 Jun 2016 15:52:47 -0400
Message-ID: <CAGH-Kgtn0EFxYc+UOvVQk-0Bco0oOG=STZA+aGYza4TmbNXq3A@mail.gmail.com>
Subject: Re: [PATCH 03/12] selinux: Implement Infiniband flush callback
To: Daniel Jurgens <danielj@mellanox.com>, Yuval Shaia <yuval.shaia@oracle.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 30, 2016 at 11:44 AM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 6/30/2016 10:10 AM, Yuval Shaia wrote:
>> On Thu, Jun 23, 2016 at 10:52:49PM +0300, Dan Jurgens wrote:
>>
>>> +static void (*ib_flush_callback)(void);
>> Do we really want to have such ib_ prefix in security/ directory?
>>
>>> +            if (ib_flush_callback)
>>> +                    ib_flush_callback();
>> How about some generic mechanism (such as a list) in case more
>> modules/drivers would like to register callbacks?
>> ( assuming this is no longer RFC :) )
>>
> Paul Moore and I were having a higher level discussion about this in the 00/12 thread.  I think your suggestion makes sense, perhaps Paul will weigh in when he reaches this patch.

I'm still working on understanding IB, but my current thinking is very
similar to Yuval's suggestions.  There is a risk of creating a general
purpose mechanism to solve a specific, isolated problem, but adding a
LSM notification mechanism does seem like a reasonable thing to do.

My current thinking is to have the LSM framework itself, e.g.
security/security.c, maintain a list of callbacks (BTW, please make it
a RCU protected list) with other non-LSM subsystems registering
callbacks, and specific LSMs making notification calls into the LSM
framework itself which would handle iterating through the registered
callbacks.  Since we're going down the general purpose solution route,
I might add an event field and a void pointer to the callback, for
example:

  void lsm_notifier_callback(unsigned int event, void *ptr);

... I would expect at first we would only have a POLICY_CHANGE event
(ptr set to NULL), but we may want/need to add other events in the
future.

Make sense?

-- 
paul moore
security @ redhat
