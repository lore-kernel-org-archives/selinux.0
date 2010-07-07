Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o67DSF5F008578
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 09:28:15 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o67DRLvA005269
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 13:27:21 GMT
Received: by pvg2 with SMTP id 2so559750pvg.12
        for <selinux@tycho.nsa.gov>; Wed, 07 Jul 2010 06:28:14 -0700 (PDT)
Message-ID: <4C348113.4020709@gmail.com>
Date: Wed, 07 Jul 2010 06:28:51 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3]libsepol
References: <1278455010-23244-1-git-send-email-justinmattock@gmail.com> <1278455010-23244-3-git-send-email-justinmattock@gmail.com> <201007072114.07279.russell@coker.com.au>
In-Reply-To: <201007072114.07279.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/07/2010 04:14 AM, Russell Coker wrote:
> On Wed, 7 Jul 2010, "Justin P. Mattock"<justinmattock@gmail.com>  wrote:
>> --- a/libsepol/src/services.c
>> +++ b/libsepol/src/services.c
>> @@ -1050,7 +1049,6 @@ int hidden sepol_load_policy(void *data, size_t len)
>>          /* Install the new policydb and SID table. */
>>          memcpy(policydb,&newpolicydb, sizeof *policydb);
>>          sepol_sidtab_set(sidtab,&newsidtab);
>> -       seqno = ++latest_granting;
>>
>>          /* Free the old policydb and SID table. */
>>          policydb_destroy(&oldpolicydb);
>
> Is latest_granting used for anything else?  If it's not being used then it
> should be removed too.  If it is being used then failing to increment it
> breaks something.
>

doing a grep for all packages shows me this:(no grep in the kernel or 
elsewhere

selinux/libsepol/src/services.c:112:static uint32_t latest_granting = 0;
selinux/libsepol/src/services.c:335:    avd->seqno = latest_granting;
selinux/libsepol/src/services.c:1053:   seqno = ++latest_granting;


Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
