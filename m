Message-ID: <4B4795F6.60505@manicmethod.com>
Date: Fri, 08 Jan 2010 15:30:46 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jwcart2@tycho.nsa.gov, Caleb Case <ccase@tresys.com>,
        selinux@tycho.nsa.gov, csellers@tresys.com, kmacmillan@tresys.com
Subject: Re: [PATCH 04/13] libsemanage: split final files into /var/lib/selinux/tmp
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>	 <1261610760-4724-2-git-send-email-ccase@tresys.com>	 <1261610760-4724-3-git-send-email-ccase@tresys.com>	 <1261610760-4724-4-git-send-email-ccase@tresys.com>	 <1261610760-4724-5-git-send-email-ccase@tresys.com>	 <1262961058.13162.4.camel@moss-pluto.epoch.ncsc.mil>	 <1262963276.11210.33.camel@localhost>	 <1262964484.13162.20.camel@moss-pluto.epoch.ncsc.mil>	 <4B47933F.4040905@manicmethod.com> <1262982343.20881.17.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1262982343.20881.17.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Stephen Smalley wrote:
> On Fri, 2010-01-08 at 15:19 -0500, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Fri, 2010-01-08 at 10:07 -0500, James Carter wrote:
>> <snip>
>>
>>> I tried running the code but I seem to see these "final files" still
>>> under the individual<store>   directories in /var/lib/selinux rather than
>>> under tmp/.
>>>
>> I built patches 1-4 and made a fresh store from whatever was in
>> /etc/selinux and I did not have any final files under
>> /var/lib/selinux/targeted:
>>
>> [root@F12 selinux]# pwd
>> /var/lib/selinux
>> [root@F12 selinux]# find
>> .
>> ./targeted
>> ./targeted/active
>> ./targeted/active/modules
>> ./targeted/active/modules/100
>> ./targeted/active/modules/100/_base
>> ./targeted/active/modules/100/_base/hll
>> ./targeted/active/modules/100/_base/ext
>>
>> ...
>>
>> ./targeted/active/modules/100/milter
>> ./targeted/active/modules/100/milter/hll
>> ./targeted/active/modules/100/milter/ext
>> ./targeted/active/modules/100/permissive_bin_t
>> ./targeted/active/modules/100/permissive_bin_t/hll
>> ./targeted/active/modules/100/permissive_bin_t/ext
>> ./targeted/active/file_contexts.template
>> ./targeted/active/file_contexts
>
> That's a final file.
>
>> ./targeted/active/homedir_template
>> ./targeted/active/seusers.final
>
> And there is one.
>
>> ./targeted/active/users_extra
>> ./targeted/active/netfilter_contexts
>
> And another.
>
>> ./targeted/active/file_contexts.homedirs
>> ./targeted/active/commit_num

oops, I foolishly scanned looking for policy.kern.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
