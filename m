From: Daniel Jurgens <danielj@mellanox.com>
To: Paul Moore <pmoore@redhat.com>
CC: "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "dledford@redhat.com"
 <dledford@redhat.com>, "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH 02/12] selinux: Create policydb version for Infiniband
 support
Date: Thu, 30 Jun 2016 21:32:39 +0000
Message-ID: <AM4PR0501MB2257CB8E6F84835315734487C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-3-git-send-email-danielj@mellanox.com>
 <CAGH-KgsOE7Ryjy7a6z8Q0o=0yae2FrUc3Qso-1geygULh18Msw@mail.gmail.com>
 <AM4PR0501MB22579221434714783B0AFC68C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
 <CAGH-KgsDc5RJ=9pHDFViOsVT08mUTrCPw4wUoXE2BMrDq6G=bA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 6/30/2016 4:18 PM, Paul Moore wrote:
> On Thu, Jun 30, 2016 at 4:59 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
>> On 6/30/2016 3:17 PM, Paul Moore wrote:
>>> On Thu, Jun 23, 2016 at 3:52 PM, Dan Jurgens <danielj@mellanox.com> wrote:
>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>
>>>> Support for Infiniband requires the addition of two new object contexts,
>>>> one for infiniband PKeys and another IB End Ports.  Added handlers to read
>>>> and write the new ocontext types when reading or writing a binary policy
>>>> representation.
>>>>
>>>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>>> Reviewed-by: Eli Cohen <eli@mellanox.com>
>>>> ---
>>>>  security/selinux/include/security.h |   3 +-
>>>>  security/selinux/ss/policydb.c      | 129 +++++++++++++++++++++++++++++++-----
>>>>  security/selinux/ss/policydb.h      |  27 +++++---
>>>>  3 files changed, 135 insertions(+), 24 deletions(-)
>>> ...
>>>
>>>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>>>> index 992a315..78b819c 100644
>>>> --- a/security/selinux/ss/policydb.c
>>>> +++ b/security/selinux/ss/policydb.c
>>>> @@ -2219,6 +2229,58 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>>>>                                         goto out;
>>>>                                 break;
>>>>                         }
>>>> +                       case OCON_PKEY: {
>>>> +                               rc = next_entry(nodebuf, fp, sizeof(u32) * 6);
>>>> +                               if (rc)
>>>> +                                       goto out;
>>>> +
>>>> +                               c->u.pkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
>>>> +                               /* The subnet prefix is stored as an IPv6
>>>> +                                * address in the policy.
>>>> +                                *
>>>> +                                * Check that the lower 2 DWORDS are 0.
>>>> +                                */
>>> Any particular reason why you reusing an IPv6 address format here?
>>> Why not use a u64 for the prefix and u16/u32 fields for the partition
>>> keys?
>> The subnet prefix is the high order bytes of an IPv6 address and there is infrastructure in place in the userland utilities that deal with IPv6 addresses (parsing them with a :: to eliminate the need to fill out the 0's for example).
> Okay, as long as it is a proper IPv6 address, that's fine.
>
>> Regarding u16, the policy is packed with everything in u32, as you can see in OCON_NODE6 and OCON_PORT handling.
>>>> +                               if (nodebuf[2] || nodebuf[3]) {
>>>> +                                       rc = -EINVAL;
>>>> +                                       goto out;
>>>> +                               }
>>>> +
>>>> +                               if (nodebuf[4] > 0xffff ||
>>>> +                                   nodebuf[5] > 0xffff) {
>>>> +                                       rc = -EINVAL;
>>>> +                                       goto out;
>>>> +                               }
>>>> +
>>>> +                               c->u.pkey.low_pkey = le32_to_cpu(nodebuf[4]);
>>>> +                               c->u.pkey.high_pkey = le32_to_cpu(nodebuf[5]);
>>>> +
>>>> +                               rc = context_read_and_validate(&c->context[0],
>>>> +                                                              p,
>>>> +                                                              fp);
>>>> +                               if (rc)
>>>> +                                       goto out;
>>>> +                               break;
>>>> +                       }
>>>> +                       case OCON_IB_END_PORT:
>>> This is a little bit of bikeshedding, but is there such thing as an IB
>>> "port" that isn't an *end* "port"?  Could we simply use OCON_IB_PORT?
>> Jason Gunthorpe requested that the name be end_port  in the RFC series.
> His reasoning?  Is there a IB port concept that isn't an end port?
The IB spec defines them as such.  I had called them ib_devices previously though so it's possible he would tolerate "port" instead.
