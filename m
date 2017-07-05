Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v65DGq27002234
 for <selinux@tycho.nsa.gov>; Wed, 5 Jul 2017 09:16:52 -0400
Subject: Re: [PATCH] IB/core: Fix static analysis warning in
 ib_policy_change_task
To: Paul Moore <paul@paul-moore.com>
References: <1498835756-7610-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhQcSfuMxZoAiTW8c-MNf6m0gLk_xArC7HkjR+5ZJgtgPA@mail.gmail.com>
Cc: dan.carpenter@oracle.com, dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com
From: Daniel Jurgens <danielj@mellanox.com>
Message-ID: <f6b2d672-4895-f589-10b4-84dabc2f2de4@mellanox.com>
Date: Wed, 5 Jul 2017 08:16:36 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQcSfuMxZoAiTW8c-MNf6m0gLk_xArC7HkjR+5ZJgtgPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/3/2017 6:03 PM, Paul Moore wrote:
> On Fri, Jun 30, 2017 at 11:15 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> ib_get_cached_subnet_prefix can technically fail, but the only way it
>> could is not possible based on the loop conditions. Check the return
>> value before using the variable sp to resolve a static analysis warning.
>>
>> Fixes: 8f408ab64be6 ("selinux lsm IB/core: Implement LSM notification
>> system")
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  drivers/infiniband/core/device.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 631eaa9..dabd9f9 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -376,7 +376,8 @@ static void ib_policy_change_task(struct work_struct *work)
>>                         WARN_ONCE(ret,
>>                                   "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
>>                                   ret);
>> -                       ib_security_cache_change(dev, i, sp);
>> +                       if (ret)
> Should this be "if (!ret)"?

Yes, my apologies. I missed the git add after fixing that locally.  I sent v1 a minute ago.
>
>> +                               ib_security_cache_change(dev, i, sp);
>>                 }
>>         }
>>         up_read(&lists_rwsem);
