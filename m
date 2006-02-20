Message-ID: <43FA11E1.7070003@redhat.com>
Date: Mon, 20 Feb 2006 14:00:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>, Joshua Brindle <jbrindle@tresys.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Audit log denials for strict policy
References: <43F88282.5070404@cornell.edu> <43F9F986.5050604@redhat.com> <43F9FD5E.1040302@cornell.edu> <43FA0CB2.4000507@redhat.com> <43FA101E.8020206@cornell.edu>
In-Reply-To: <43FA101E.8020206@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> No I think this is a sorting problem in file_contexts file.
>>
>> Does var_log_t come after wtmp_t?
>>
> Yes, but that shouldn't mean anything, this file should get sorted in 
> matchpathcon (so I've been told..)
>
> The two specs are:
>
> /var/log/wtmp.*         --      system_u:object_r:wtmp_t:s0
> /var/log/.*                     system_u:object_r:var_log_t:s0
We seem to have a sorting problem within matchpathcon on strict policy.

Strict policy labels wtmp file in a loadable module, but the sorting 
algorithm is using var_log_t????

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
