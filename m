Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5IFNxet001400
	for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2012 11:23:59 -0400
Message-ID: <4FDF480C.1020406@tresys.com>
Date: Mon, 18 Jun 2012 11:23:56 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: <selinux@tycho.nsa.gov>, <method@manicmethod.com>
Subject: Re: [PATCH system/core] add iptables secmark labeling script to startup
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com> <1339872999-30243-3-git-send-email-jbrindle@tresys.com> <10555397.PmF0tPeDBq@sifl>
In-Reply-To: <10555397.PmF0tPeDBq@sifl>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Saturday, June 16, 2012 02:56:36 PM Joshua Brindle wrote:
>> Change-Id: I47100243b04d9629d44c8962eafeacabdcd0e6d2
>>
>> Signed-off-by: Joshua Brindle<jbrindle@tresys.com>
>> ---
>>   rootdir/init.rc |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/rootdir/init.rc b/rootdir/init.rc
>> index 7131095..bd4bc81 100644
>> --- a/rootdir/init.rc
>> +++ b/rootdir/init.rc
>> @@ -372,6 +372,10 @@ service console /system/bin/sh
>>       user shell
>>       group log
>>
>> +service netlabels /system/bin/iptables-selinux.sh
>> +    class core
>> +    oneshot
>
> I don't know much about Android development or the boot process, but I wonder
> if it would make sense to either change the name of the service or the script
> it executes.  While the script seems aptly named for its current
> functionality, the service name might become a problem if an Android user ever
> needs to enable NetLabel support.
>
> I would suggest either changing the service name to reflect the
> secmark/iptables nature of the script or changing the name of the script to
> something more generic, e.g. selinux-network.sh, so that it is less awkward if
> the script grows at some point to contain secmark labeling rules, NetLabel
> configuration, labeled IPsec, etc.
>

That is fine. This script generally should just be the initial network state. I 
fully expect that VPN apps, etc would have to do runtime label changes, both 
using secmark and labeled ipsec.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
