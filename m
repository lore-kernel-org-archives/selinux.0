Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p74JGbNu009117
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 15:16:37 -0400
Received: from qmta12.westchester.pa.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p74JGaUa004898
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 19:16:36 GMT
Message-ID: <4E3AF003.8030802@tresys.com>
Date: Thu, 04 Aug 2011 15:16:19 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 029/155] policycoreutils: fixfiles clean up /var/run and
References: <4E39B5E6.8000100@redhat.com> <1312469767.20973.53.camel@moss-pluto> <CACLa4ptckXGt6XEqDMnmeZhV3AzVwnL=ktSTtVTFGg+A=Ajcug@mail.gmail.com>
In-Reply-To: <CACLa4ptckXGt6XEqDMnmeZhV3AzVwnL=ktSTtVTFGg+A=Ajcug@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/4/2011 1:33 PM, Eric Paris wrote:
> Is there a reasonable way for a script to determine
> SECINITSID_UNLABELED?  You're right though, it does sound like a good
> todo.

cat /selinux/initial_contexts/unlabeled

> On Thu, Aug 4, 2011 at 10:56 AM, Stephen Smalley<sds@tycho.nsa.gov>  wrote:
>> On Wed, 2011-08-03 at 16:56 -0400, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>>
>>> This patch looks good to me. acked.
>>
>> > From dff45c3977973dfbdbc7261b6fef05215d3515d8 Mon Sep 17 00:00:00 2001
>> From: Eric Paris<eparis@redhat.com>
>> Date: Sun, 10 Jul 2011 13:35:32 +0200
>> Subject: [PATCH 029/155] policycoreutils: fixfiles clean up /var/run and
>>   /var/lib/debug
>>
>> clean up /var/run and /var/lib/debug just like we do for /tmp and
>> /var/tmp since they can easily get unlabeled files.
>>
>> Signed-off-by: Eric Paris<eparis@redhat.com>
>> ---
>>   policycoreutils/scripts/fixfiles |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
>> index 1da3fb2..c5c92bf 100755
>> --- a/policycoreutils/scripts/fixfiles
>> +++ b/policycoreutils/scripts/fixfiles
>> @@ -142,6 +142,8 @@ rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
>>   find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) \( -type s -o -type p \) -delete
>>   find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
>>   find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
>> +find /var/run \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t var_run_t {} \;
>> +[ -e /var/lib/debug ]&&  find /var/lib/debug \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t lib_t {} \;
>>   exit $?
>>   }
>>
>>
>> Does it bother anyone else that you are hardcoding policy types into
>> your scripts here?  What happens when someone wants to use a different
>> policy that doesn't define those types?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
