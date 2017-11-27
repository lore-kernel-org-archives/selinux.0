Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAS91xma027809
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 04:01:59 -0500
To: Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov
Cc: pebenito@ieee.org, honli@redhat.com, refpolicy@oss.tresys.com
References: <1511791439-15957-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhRqB4DxRjR=ceaJuc12M5R4ZAXgmBrEKws4BQMGVeASzw@mail.gmail.com>
From: Daniel Jurgens <danielj@mellanox.com>
Message-ID: <6ced2e0c-e6a3-9481-f20d-ca81027e6d2f@mellanox.com>
Date: Mon, 27 Nov 2017 14:04:19 -0600
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRqB4DxRjR=ceaJuc12M5R4ZAXgmBrEKws4BQMGVeASzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 1/1] networkmanager: Grant access to unlabeled
 PKeys
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/27/2017 10:19 AM, Paul Moore wrote:
> On Mon, Nov 27, 2017 at 9:03 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> For controlling IPoIB VLANs
>>
>> Reported-by: Honggang LI <honli@redhat.com>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>> Tested-by: Honggang LI <honli@redhat.com>
>> ---
>>  networkmanager.te |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
> [NOTE: resending due to a typo in the refpol mailing list address]
>
> We obviously need something like this now so we don't break IPoIB, but
> I wonder if we should make the IB access controls dynamic like the
> per-packet network access controls.  We could key off the presence of
> the IB pkey and endport definitions: if there are any objects defined
> in the loaded policy we enable the controls, otherwise we disable
> them.

I think I understand what you're saying Paul, but I'm not clear on the mechanism.  Are you referring to the netlabel/IPSEC enable checks? They are wrapped up in selinux_peerlbl_enabled.

>
>> diff --git a/networkmanager.te b/networkmanager.te
>> index 76d0106..5e881f4 100644
>> --- a/networkmanager.te
>> +++ b/networkmanager.te
>> @@ -184,6 +184,8 @@ userdom_write_user_tmp_sockets(NetworkManager_t)
>>  userdom_dontaudit_use_unpriv_user_fds(NetworkManager_t)
>>  userdom_dontaudit_use_user_ttys(NetworkManager_t)
>>
>> +corenet_ib_access_unlabeled_pkeys(NetworkManager_t)
>> +
>>  optional_policy(`
>>         avahi_domtrans(NetworkManager_t)
>>         avahi_kill(NetworkManager_t)
>> --
>> 1.7.1
