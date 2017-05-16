Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4GHrpYt002403
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 13:53:53 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: Jason Zaman <jason@perfinion.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 8/9] semanage: Update semanage to allow runtime
 labeling of ibendports
Date: Tue, 16 May 2017 17:53:46 +0000
Message-ID: <DB5PR05MB16710582607A7A47EF4A4F92C4E60@DB5PR05MB1671.eurprd05.prod.outlook.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-9-git-send-email-danielj@mellanox.com>
 <20170516164835.GA9284@meriadoc.perfinion.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/16/2017 11:48 AM, Jason Zaman wrote:
> On Mon, May 15, 2017 at 11:42:40PM +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Update libsepol and libsemanage to work with ibendport records. Add local
>> storage for new and modified ibendport records in ibendports.local.
>> Update semanage to parse the ibendport command options to add, modify,
>> and delete them.
>>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>
>> ---
>> v1:
>> Jason Zaman:
>> - Use SETools directly to query types in seobject.py
>>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index 41b0aca..037c9ae 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -1565,6 +1565,245 @@ class ibpkeyRecords(semanageRecords):
>>                  rec += ", %s" % p
>>              print rec
>>  
>> +class ibendportRecords(semanageRecords):
>> +    try:
>> +        q = setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get_installed_policy()), attrs=["ibendport_type"])
>> +        valid_types = sorted(str(t) for t in q.results())
> Super minor nit pick here: set() (or even frozenset()) is probably
> better than sorted() since you appear to only just check membership.
>
> I probably wouldnt bother updating unless there is a v2 for some other
> reason.
>
> And if want it on this or an updated version:
> Acked-by: Jason Zaman <jason@perfinion.com>
>
> -- Jason
>
Thanks Jason, I'll have to rebase over a patch Stephen submitted the other day, so there will be a v2 and I'll address this in it.
