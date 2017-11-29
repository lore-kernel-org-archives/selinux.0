Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAT1nE4l017530
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 20:49:14 -0500
Received: by mail-qt0-f174.google.com with SMTP id d4so2485650qtj.5
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 17:49:03 -0800 (PST)
To: Paul Moore <paul@paul-moore.com>, Daniel Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov, honli@redhat.com, refpolicy@oss.tresys.com
References: <1511791439-15957-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhRqB4DxRjR=ceaJuc12M5R4ZAXgmBrEKws4BQMGVeASzw@mail.gmail.com>
 <6ced2e0c-e6a3-9481-f20d-ca81027e6d2f@mellanox.com>
 <CAHC9VhSTR250fQvNs61VbftsLOX=Lxt5t-CoH1BzXjWRJw2xDw@mail.gmail.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <163e0282-3638-1655-e726-6820265bad19@ieee.org>
Date: Tue, 28 Nov 2017 20:25:05 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSTR250fQvNs61VbftsLOX=Lxt5t-CoH1BzXjWRJw2xDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 1/1] networkmanager: Grant access to unlabeled
 PKeys
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/27/2017 05:50 PM, Paul Moore wrote:
> On Mon, Nov 27, 2017 at 3:04 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
>> On 11/27/2017 10:19 AM, Paul Moore wrote:
>>> On Mon, Nov 27, 2017 at 9:03 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>
>>>> For controlling IPoIB VLANs
>>>>
>>>> Reported-by: Honggang LI <honli@redhat.com>
>>>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>>> Tested-by: Honggang LI <honli@redhat.com>
>>>> ---
>>>>   networkmanager.te |    2 ++
>>>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>> [NOTE: resending due to a typo in the refpol mailing list address]
>>>
>>> We obviously need something like this now so we don't break IPoIB, but
>>> I wonder if we should make the IB access controls dynamic like the
>>> per-packet network access controls.  We could key off the presence of
>>> the IB pkey and endport definitions: if there are any objects defined
>>> in the loaded policy we enable the controls, otherwise we disable
>>> them.
>>
>> I think I understand what you're saying Paul, but I'm not clear on the mechanism.  Are you referring to the netlabel/IPSEC enable checks? They are wrapped up in selinux_peerlbl_enabled.
> 
> Basically, yes.  We could add a new variable/function that gates the
> access control checks in selinux_ib_pkey_access() and
> selinux_ib_endport_manage_subnet(); the checks would be enabled when
> there was Infiniband configuration loaded with the policy.  Without
> the IB config loaded, all the checks would end up being just a domain
> check against unlabeled_t, which isn't very interesting, so we would
> just drop the checks.

As long as it also respects policycap always_check_network, it works for me.

-- 
Chris PeBenito
