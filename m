Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAN9hiEc010024
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 04:43:44 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 94DEF1A1D8
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 10:43:34 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id bUkLgvuOtEDC for <selinux@tycho.nsa.gov>;
 Mon, 23 Nov 2015 10:43:31 +0100 (CET)
Received: from [IPv6:2a02:578:85fc:1:c84e:489:bf64:5e4f] (unknown
 [IPv6:2a02:578:85fc:1:c84e:489:bf64:5e4f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 58C181A070
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 10:43:31 +0100 (CET)
Subject: Re: (Userspace) AVC denial generated even if allowed by the policy?
To: selinux@tycho.nsa.gov
References: <5652636F.2060609@debian.org> <20151123080806.GA5869@x250>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <5652DFC2.6090309@debian.org>
Date: Mon, 23 Nov 2015 10:43:30 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <20151123080806.GA5869@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 23/11/15 09:08, Dominick Grift a écrit :
> On Mon, Nov 23, 2015 at 01:53:03AM +0100, Laurent Bigonville wrote:
>> Hi,
>>
>> I'm still looking at adding SELinux support in the "at" daemon and I now
>> have the following patch[0].
>>
>> With this patch, at seems to behave like the cron daemon, as explained in
>> the commit log:
>>
>>      - When cron_userdomain_transition is set to off, a process for an
>>        unconfined user will transition to unconfined_cronjob_t. For confined
>>        user, the job is run as cronjob_t.
>>
>>      - When cron_userdomain_transition is set to on, the processes are run
>>        under the user default context.
>>
>> But every time an AVC denial is generated (with cron_userdomain_transition
>> set to off and the user running as staff_u, in permissive with unmodified
>> refpolicy):
>>
>> avc:  denied  { entrypoint } for scontext=staff_u:staff_r:cronjob_t:s0
>> tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file
>>
>> The job runs as (id -Z): staff_u:staff_r:cronjob_t:s0
>>
>> But audit2{allow,why} are saying that this is already allowed in the policy
>>
>> Setting the cron_userdomain_transition boolean to on, I have the following
>> avc:
>>
>> avc:  denied  { entrypoint } for scontext=staff_u:sysadm_r:sysadm_t:s0
>> tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file
> I think this is weird as well since user_cron_spool_t is not actually
> executed as far as i know (and thus is not actually an entrypoint). The entrypoint permission is merely allowed so
> that crond_t/atd_t can calculate access to the target domains.
>
> So i do not see why these entrypoint events are hit in the first place

The code is explicitly doing that, I guess it's the design decision from 
the original writer of the patch:

  /*
  * Since crontab files are not directly executed,
  * crond must ensure that the crontab file has
  * a context that is appropriate for the context of
  * the user cron job. It performs an entrypoint
  * permission check for this purpose.
  */

And that's why there is a entrypoint check:

selinux_check_access(user_context, file_context, "file", "entrypoint", 
NULL);
