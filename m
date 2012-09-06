Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q86FHCB2024355
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2012 11:17:12 -0400
Message-ID: <5048BE76.3000202@schaufler-ca.com>
Date: Thu, 06 Sep 2012 08:17:10 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 5/5] LSM: SELinux changes to allow LSM stacking
References: <5046B459.4070200@schaufler-ca.com>  <1346855881.9153.21.camel@moss-pluto.epoch.ncsc.mil> <1346936932.19997.21.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1346936932.19997.21.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/6/2012 6:08 AM, Stephen Smalley wrote:
> On Wed, 2012-09-05 at 10:38 -0400, Stephen Smalley wrote:
>> On Tue, 2012-09-04 at 19:09 -0700, Casey Schaufler wrote:
>>> Subject: LSM: SELinux changes to allow LSM stacking
>>>
>>> Change security blob accesses to use the lsm_get/lsm_set
>>> interfaces. This requires removal of the cred pointer
>>> poisoning in selinux_cred_free.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> FWIW, passes the selinux-testsuite with SELinux and Yama enabled.
> However, setting SELINUX=disabled in /etc/selinux/config and rebooting
> with this kernel yields a kernel panic during reset_security_ops(),
> called by selinux_disable().
>

reset_security_ops is only used by SELinux. There are a number of ways
to repair this. The important question is whether a general solution is
required or if it can be left SELinux specific. If it is a general
interface, does it clear all the LSMs or just the LSM calling it?
I would suggest that leaving it to SELinux is the best choice, and
clearing the calling LSM only the next best choice.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
