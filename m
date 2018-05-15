Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4FFlkfC024596
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 11:47:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID04.oob.disa.mil (Postfix) with SMTP id 40lhlz1z3jz3t8VF
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 15:47:43 +0000 (UTC)
Received: from USFB3CPA02_EEMSG_MP24.eemsg.mil (unknown [192.168.16.19])
 by USFBF3ID04.oob.disa.mil (Postfix) with ESMTP id 40lhly3cZ5z3t8Tf
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 15:47:42 +0000 (UTC)
To: Stephen Smalley <sds@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>, SELinux
 <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <523afc0b-5bfc-8b95-05ee-450679254a47@tycho.nsa.gov>
 <5716ab22-4d3c-1935-41f1-ba848570ccab@tycho.nsa.gov>
 <eab001ca-10ff-1cfe-9436-805840628784@schaufler-ca.com>
 <5db90fec-7640-73d5-2e96-b4c996b7ae8d@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ad30d628-ed11-2dd6-6782-3089bf733702@schaufler-ca.com>
Date: Tue, 15 May 2018 08:47:36 -0700
MIME-Version: 1.0
In-Reply-To: <5db90fec-7640-73d5-2e96-b4c996b7ae8d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 00/23] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/15/2018 5:33 AM, Stephen Smalley wrote:
> On 05/14/2018 05:31 PM, Casey Schaufler wrote:
>> On 5/14/2018 1:07 PM, Stephen Smalley wrote:
>>> On 05/14/2018 03:52 PM, Stephen Smalley wrote:
>>>> On 05/10/2018 08:30 PM, Casey Schaufler wrote:
>>>>> Subject: [PATCH 00/23] LSM: Full security module stacking
>>>>>
>>>>> Here it is, the whole nine yards, broken into mostly
>>>>> review friendly pieces. I believe that it would make
>>>>> a good deal of sense to take this in two bites, with
>>>>> the infrastructure managed blobs going first and the
>>>>> secid conversion coming later. I hope there will be some
>>>>> debate around that.
>>>>>
>>>>> The blob management part is pretty clean by now. I
>>>>> welcome serious review on that. The secid part is more
>>>>> wobbly, but I am convinced that it's the right direction
>>>>> if not perhaps always the best possible implementation.
>>>>> AppArmor in in the process of a major overhaul, and that
>>>>> slowed me down a bit as I had to do new work to convert
>>>>> it to use the new mechanisms.
>>>>>
>>>>> I had experimented with secid "tokens" in the hope of
>>>>> minimizing API changes. That doesn't work. Changing
>>>>> the APIs to use a struct secids pointer in place of a
>>>>> u32 is brutal to the diffstat, but reduces the amount
>>>>> of active code that has to change, and really makes
>>>>> data management easier.
>>>>>
>>>>> If there are two possible ways to do a thing you will
>>>>> find them both in the networking code. AF_UNIX, netfilter,
>>>>> SO_PEERSEC and netlabel each has its own clever ways
>>>>> to manipulate security information. I think I nailed
>>>>> them all, but I'm not betting more than a beer on it.
>>>>>
>>>>> There could be issues in the audit code, although nothing
>>>>> jumped out immediately. The same goes for the integrity
>>>>> subsystem. I haven't tried Infiniband or very many
>>>>> filesystem types that don't com standard with Fedora or
>>>>> Ubuntu.
>>>>>
>>>>> I have fixed everything I've found. If you find something
>>>>> (please look!) let me know.
>>>>>
>>>>> Tested primarily on virtual machines.
>>>>> 	Fedora 25-27 - SELinux, Smack and the two together
>>>>> 	Ubuntu 17.04 - AppArmor and AppArmor + Smack
>>>>>
>>>>> The SELinux test suite completes successfully unless
>>>>> you add in Smack, in which case it fails where you would
>>>>> expect it to due to the different use models for netlabel.
>>>>> Smack tests work as well. AppArmor was tested by booting
>>>>> Ubuntu, but not beyond.
>>>> Getting this during boot with CONFIG_KASAN=y and SELinux+Smack stacked:
>>>>
>>>> [   83.809008] ==================================================================
>>>> [   83.809046] BUG: KASAN: use-after-free in string+0xab/0x180
>>>> [   83.809051] Read of size 1 at addr ffff8803bb3ad508 by task systemd/1...
>> <snip>
>> I haven't seen that one. What distro/version/architecture are you using?
> Fedora 28 / x86_64

OK, found and fixed. Thanks for the report.

>
>>>> Also, networking seems to be dead:
>>>> [   94.522829] Failed to initialize the IGMP autojoin socket (err -13)
>>>> ... <snip> ...
>>>> [  500.736369] Failed to initialize the IGMP autojoin socket (err -13)
>>>>
>>>> And I can't bring up the interface.
>> What you're seeing is SELinux and Smack being unable to agree on the
>> labeling for IP sockets. The socket() call is failing because
>> SELinux and Smack want different CIPSO on the packets from the sockets.
>> Paul and I discussed this at length, and in the end agreed that this is
>> safe, if "inconvenient", behavior. I believe that a netlabel configuration
>> that is useful is possible, but I don't have one to suggest just yet.
>>
>> On Fedora25 and 27 the services using IP sockets eventually time out,
>> after which I can successfully log on. Without being able to create sockets,
>> it's tough to start the interfaces.
> Hmm...SELinux shouldn't be doing anything with CIPSO by default (i.e. without additional config),
> so why is there a conflict just when booting without any SELinux NetLabel configuration at all?

Both SELinux and Smack use netlbl_sock_setattr() in their socket_post_create()
hooks to establish the CIPSO to use if nothing else interferes. An unfortunate
artifact of the Smack "ambient label" implementation is that the default
configuration is going to delete the netlbl attribute for the floor ("_")
label. This will conflict with any value that SELinux sets. :( Smack clearly
needs to have it's use of netlabel revised, and that is work that's going on
in parallel with stacking. That, however, is not an infrastructure issue, it's
an issue with how the two modules use the facilities.
