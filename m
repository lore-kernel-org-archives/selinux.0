Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAS7KoXZ012755
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 02:20:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 3ym9Mg1CLjz34qc6
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 04:16:15 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 3ym9Mf6sK2z34qbw
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 04:16:14 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id i14so34722745lfc.1
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 14:50:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6ced2e0c-e6a3-9481-f20d-ca81027e6d2f@mellanox.com>
References: <1511791439-15957-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhRqB4DxRjR=ceaJuc12M5R4ZAXgmBrEKws4BQMGVeASzw@mail.gmail.com>
 <6ced2e0c-e6a3-9481-f20d-ca81027e6d2f@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Nov 2017 17:50:30 -0500
Message-ID: <CAHC9VhSTR250fQvNs61VbftsLOX=Lxt5t-CoH1BzXjWRJw2xDw@mail.gmail.com>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov, pebenito@ieee.org, honli@redhat.com,
 refpolicy@oss.tresys.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] networkmanager: Grant access to unlabeled
 PKeys
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 27, 2017 at 3:04 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 11/27/2017 10:19 AM, Paul Moore wrote:
>> On Mon, Nov 27, 2017 at 9:03 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>
>>> For controlling IPoIB VLANs
>>>
>>> Reported-by: Honggang LI <honli@redhat.com>
>>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>> Tested-by: Honggang LI <honli@redhat.com>
>>> ---
>>>  networkmanager.te |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>> [NOTE: resending due to a typo in the refpol mailing list address]
>>
>> We obviously need something like this now so we don't break IPoIB, but
>> I wonder if we should make the IB access controls dynamic like the
>> per-packet network access controls.  We could key off the presence of
>> the IB pkey and endport definitions: if there are any objects defined
>> in the loaded policy we enable the controls, otherwise we disable
>> them.
>
> I think I understand what you're saying Paul, but I'm not clear on the mechanism.  Are you referring to the netlabel/IPSEC enable checks? They are wrapped up in selinux_peerlbl_enabled.

Basically, yes.  We could add a new variable/function that gates the
access control checks in selinux_ib_pkey_access() and
selinux_ib_endport_manage_subnet(); the checks would be enabled when
there was Infiniband configuration loaded with the policy.  Without
the IB config loaded, all the checks would end up being just a domain
check against unlabeled_t, which isn't very interesting, so we would
just drop the checks.

-- 
paul moore
www.paul-moore.com
