Cc: SE-Linux Linux <selinux@tycho.nsa.gov>
Message-Id: <5C6F4AE5-5754-4894-A4A4-727B7462AB8C@nall.com>
From: Joe Nall <joe@nall.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1227617019.683.1.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Polyinstantiation in cron
Date: Tue, 25 Nov 2008 07:37:50 -0600
References: <D52C0637-73C3-42BB-862E-447D5B404B48@nall.com> <1227617019.683.1.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Nov 25, 2008, at 6:43 AM, Stephen Smalley wrote:

> On Mon, 2008-11-24 at 22:00 -0600, Joe Nall wrote:
>> I created a normal user (urss) and added a crontab entry for that  
>> user
>> that runs a script. I can get the script launched at level, but not
>> polyinstantiated. A 'cat /proc/mounts' shows no polyinstantiation for
>> the cron session, but a normal login session has properly
>> polyinstantiated directories.
>>
>> The crontab entry looks like:
>>
>> SELINUX_ROLE_TYPE=user_u:user_r:user_t:UNCLASSIFIED-UNCLASSIFIED
>> * * * * * /opt/jcdx/libexec/urss-rss2email-cron.sh
>> SELINUX_ROLE_TYPE=user_u:user_r:user_t:UNCLASSIFIED-UNCLASSIFIED
>> * * * * * /opt/jcdx/libexec/urss-delivermail-cron.sh
>>
>> The relevant portion of /opt/jcdx/libexec/urss-delivermail-cron.sh
>>
>> #!/bin/bash
>> id
>> ls -Z /var/mailboxes
>> cat /proc/mounts
>>
>> Have I missed some cron specific pam configuration? Did this work for
>> RHEL 5.X LSPP?
>
> Does /etc/pam.d/cron contain pam_namespace.so?

It did not and that fixed it. I'll do some more research and file a  
bugzilla if required. Thanks.

joe




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
