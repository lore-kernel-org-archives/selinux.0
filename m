Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q85FZusO023667
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2012 11:35:56 -0400
Message-ID: <5047715A.2020203@schaufler-ca.com>
Date: Wed, 05 Sep 2012 08:35:54 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 5/5] LSM: SELinux changes to allow LSM stacking
References: <5046B459.4070200@schaufler-ca.com> <1346855881.9153.21.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1346855881.9153.21.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/5/2012 7:38 AM, Stephen Smalley wrote:
> On Tue, 2012-09-04 at 19:09 -0700, Casey Schaufler wrote:
>> Subject: LSM: SELinux changes to allow LSM stacking
>>
>> Change security blob accesses to use the lsm_get/lsm_set
>> interfaces. This requires removal of the cred pointer
>> poisoning in selinux_cred_free.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> FWIW, passes the selinux-testsuite with SELinux and Yama enabled.
>

Thank you. I'm not at all surprised given the intent of Yama. I would be
much
more interested in the results with AppArmor and TOMOYO.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
