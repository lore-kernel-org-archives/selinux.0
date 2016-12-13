From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "chrisw@sous-sol.org"
 <chrisw@sous-sol.org>, "paul@paul-moore.com" <paul@paul-moore.com>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "dledford@redhat.com"
 <dledford@redhat.com>, "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v6 5/9] selinux: Create policydb version for Infiniband
 support
Date: Tue, 13 Dec 2016 14:40:45 +0000
Message-ID: <DB6PR0501MB2422CF0BEC4BE08E2EEB6BD8C49B0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
References: <1479910651-43246-1-git-send-email-danielj@mellanox.com>
 <1479910651-43246-6-git-send-email-danielj@mellanox.com>
 <edb7cebd-cf0a-f115-741e-6d4e96edb0bd@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/13/2016 8:35 AM, Stephen Smalley wrote:
> On 11/23/2016 09:17 AM, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Support for Infiniband requires the addition of two new object contexts,
>> one for infiniband PKeys and another IB Ports. Added handlers to read
>> and write the new ocontext types when reading or writing a binary policy
>> representation.
>>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>> Reviewed-by: Eli Cohen <eli@mellanox.com>
> I assume you have libsepol/checkpolicy patches for this as well?
>
Yes, I plan to submit them once the kernel changes are accepted.
