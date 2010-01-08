Message-ID: <4B479D49.6090306@manicmethod.com>
Date: Fri, 08 Jan 2010 16:02:01 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jwcart2@tycho.nsa.gov, Caleb Case <ccase@tresys.com>,
        selinux@tycho.nsa.gov, csellers@tresys.com, kmacmillan@tresys.com
Subject: Re: [PATCH 04/13] libsemanage: split final files into /var/lib/selinux/tmp
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>	 <1261610760-4724-2-git-send-email-ccase@tresys.com>	 <1261610760-4724-3-git-send-email-ccase@tresys.com>	 <1261610760-4724-4-git-send-email-ccase@tresys.com>	 <1261610760-4724-5-git-send-email-ccase@tresys.com>	 <1262961058.13162.4.camel@moss-pluto.epoch.ncsc.mil>	 <1262963276.11210.33.camel@localhost>	 <1262964484.13162.20.camel@moss-pluto.epoch.ncsc.mil>	 <4B47933F.4040905@manicmethod.com>	 <1262982343.20881.17.camel@moss-pluto.epoch.ncsc.mil>	 <4B4795F6.60505@manicmethod.com>  <4B479ACE.80305@manicmethod.com> <1262984338.20881.22.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1262984338.20881.22.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2010-01-08 at 15:51 -0500, Joshua Brindle wrote:
>> Joshua Brindle wrote:
>>>
>>> Stephen Smalley wrote:
>>>> On Fri, 2010-01-08 at 15:19 -0500, Joshua Brindle wrote:
>> <snip>
>>> oops, I foolishly scanned looking for policy.kern.
>>>
>> No, it is worse than that, I wasn't actually running the code I was
>> claiming to (as evidenced by the priority level and hll files)
>>
>> Up to patch 4 my /var/lib/selinux now looks like this:
>>
>> [root@F12 active]# find /var/lib/selinux/
>> /var/lib/selinux/
>> /var/lib/selinux/targeted
>> /var/lib/selinux/targeted/semanage.read.LOCK
>> /var/lib/selinux/targeted/semanage.trans.LOCK
>> /var/lib/selinux/targeted/active
>> /var/lib/selinux/targeted/active/modules
>> /var/lib/selinux/targeted/active/modules/abrt.pp
>> /var/lib/selinux/targeted/active/modules/ada.pp
>> ...
>> /var/lib/selinux/targeted/active/modules/xguest.pp
>> /var/lib/selinux/targeted/active/modules/zabbix.pp
>> /var/lib/selinux/targeted/active/modules/zebra.pp
>> /var/lib/selinux/targeted/active/modules/zosremote.pp
>> /var/lib/selinux/targeted/active/base.pp
>> /var/lib/selinux/targeted/active/file_contexts.template
>> /var/lib/selinux/targeted/active/homedir_template
>> /var/lib/selinux/targeted/active/users_extra
>> /var/lib/selinux/targeted/active/commit_num
>> /var/lib/selinux/tmp
>>
>>
>> so I don't have any final files in targeted anymore, though I didn't try
>> to stop semodule half-way and look in tmp.
>
> I haven't tried only up through patch 4, only with all 13 patches
> applied.
>
> Also, I have all Fedora policies installed (yum install
> selinux-policy*), so I have mls, targeted, and minimum, although
> targeted is the active one.
>

Are you running the migrate script? I believe it is erroneously copying 
final files into the store:

+	# List of paths that go in the active 'root'
+	TOPPATHS = [
+		"file_contexts",
+		"homedir_template",
+		"file_contexts.template",
+		"commit_num",
+		"ports.local",
+		"interfaces.local",
+		"nodes.local",
+		"booleans.local",
+		"file_contexts.local",
+		"seusers",
+		"users.local",
+		"users_extra.local",
+		"seusers.final",
+		"users_extra",
+		"netfilter_contexts",
+		"file_contexts.homedirs",
+		"disable_dontaudit" ]
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
