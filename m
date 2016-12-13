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
Subject: Re: [PATCH v6 3/9] selinux lsm IB/core: Implement LSM notification
 system
Date: Tue, 13 Dec 2016 14:38:54 +0000
Message-ID: <DB6PR0501MB24224ED80DC88FB3BC44BF9FC49B0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
References: <1479910651-43246-1-git-send-email-danielj@mellanox.com>
 <1479910651-43246-4-git-send-email-danielj@mellanox.com>
 <8165ef76-d620-5904-e38e-90d258a30683@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/13/2016 8:26 AM, Stephen Smalley wrote:
> On 11/23/2016 09:17 AM, Dan Jurgens wrote:
>> @@ -177,6 +177,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>>  			avc_ss_reset(0);
>>  		selnl_notify_setenforce(selinux_enforcing);
>>  		selinux_status_update_setenforce(selinux_enforcing);
>> +		if (!selinux_enforcing)
>> +			call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> Why do you need this notification?  When switching from permissive to
> enforcing, you need (and already get) a notification since you may need
> to revoke previously granted permissions.  But what action do you need
> to take on switching to permissive?
MAD (management datagram) Agents cache if they are allowed to send and receive subnet management protocol (SMP) datagrams.  Without this notification they will still drop all SMPs in permissive mode if they weren't allowed in enforcing mode.  This is handled in [PATCH v6 4/9] IB/core: Enforce security on management datagrams.
