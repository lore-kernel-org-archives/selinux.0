Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5ULbaar004962
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 17:37:36 -0400
Received: by mail-oi0-f42.google.com with SMTP id u201so84864986oie.0
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 14:37:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM4PR0501MB2257CB8E6F84835315734487C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-3-git-send-email-danielj@mellanox.com>
 <CAGH-KgsOE7Ryjy7a6z8Q0o=0yae2FrUc3Qso-1geygULh18Msw@mail.gmail.com>
 <AM4PR0501MB22579221434714783B0AFC68C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
 <CAGH-KgsDc5RJ=9pHDFViOsVT08mUTrCPw4wUoXE2BMrDq6G=bA@mail.gmail.com>
 <AM4PR0501MB2257CB8E6F84835315734487C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 30 Jun 2016 17:37:34 -0400
Message-ID: <CAGH-Kguca78Ma-VJkOz97ixLHrXDgWQxNURre9tVOh+Qb6C1aQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] selinux: Create policydb version for Infiniband
 support
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

On Thu, Jun 30, 2016 at 5:32 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 6/30/2016 4:18 PM, Paul Moore wrote:
>> On Thu, Jun 30, 2016 at 4:59 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
>>> On 6/30/2016 3:17 PM, Paul Moore wrote:
>>>> On Thu, Jun 23, 2016 at 3:52 PM, Dan Jurgens <danielj@mellanox.com> wrote:
>>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>>
>>>>> Support for Infiniband requires the addition of two new object contexts,
>>>>> one for infiniband PKeys and another IB End Ports.  Added handlers to read
>>>>> and write the new ocontext types when reading or writing a binary policy
>>>>> representation.
>>>>>
>>>>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>>>> Reviewed-by: Eli Cohen <eli@mellanox.com>
>>>>> ---
>>>>>  security/selinux/include/security.h |   3 +-
>>>>>  security/selinux/ss/policydb.c      | 129 +++++++++++++++++++++++++++++++-----
>>>>>  security/selinux/ss/policydb.h      |  27 +++++---
>>>>>  3 files changed, 135 insertions(+), 24 deletions(-)

...
                       }
>>>>> +                       case OCON_IB_END_PORT:
>>>> This is a little bit of bikeshedding, but is there such thing as an IB
>>>> "port" that isn't an *end* "port"?  Could we simply use OCON_IB_PORT?
>>> Jason Gunthorpe requested that the name be end_port  in the RFC series.
>> His reasoning?  Is there a IB port concept that isn't an end port?
> The IB spec defines them as such.  I had called them ib_devices previously though so it's possible he would tolerate "port" instead.

Okay, if that is what they are called that's fine with me.  Perhaps
just squash the macro to OCON_IB_ENDPORT or similar; all those
underscores are messing with my mental parser.

-- 
paul moore
security @ redhat
