Message-ID: <439F4397.6030206@redhat.com>
Date: Tue, 13 Dec 2005 16:56:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Latest diffs.
References: <439EED4B.4070701@redhat.com> <1134506627.4936.23.camel@sgc>
In-Reply-To: <1134506627.4936.23.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2005-12-13 at 10:48 -0500, Daniel J Walsh wrote:
>   
>> Add crond range_transition to run at SystemHigh for MCS policy
>> Added transition from unconfined_t to run ping at s0.
>> Which brings up a point, when a transition happens should the 
>> application continue to run at the same security level that the prev 
>> context ran at?  Or should all domains start with a default security 
>> level. 
>>
>> In current MCS policy if unconfined_t started ping, it would run at the 
>> with the same mls range as unconfined_t.
>>     
>
> The cron part makes sense, but I don't understand why this would be
> needed for ping.
>
>   
Otherwise ping runs with a range of s0-s0:c0,c255
I think all apps should run at s0 unless a range_transition is stated.
>> Beginning to fix up automouter.  Wants to read sysctl_fs_t.  Also seems 
>> to exec showmount which requires additional privs.
>>
>> allow automount_t self:capability net_bind_service;
>> allow automount_t portmap_port_t:tcp_socket name_connect;
>> allow automount_t reserved_port_t:tcp_socket name_connect;
>> allow automount_t sbin_t:file read;
>>
>> We probably need a policy for the showmount command, rather then adding 
>> these rules to automount.  Anyone want to write some policy?
>>
>> Rules to make dovecot work better.
>>
>> /var/log/proftpd/ should be marked xferlog
>>
>> gpm wants to communicate using unix_stream_socket.
>>
>> More fixes for hal.  Seems hal is now tied into powersaver and needs 
>> some addtional privs.
>> Needs to be able to start init scripts.
>> Added new policy for vbetool, to be execed from hal.
>>     
>
> all merged.  I removed the execmem from hal, since it transitions to
> vbetool, and the comment said it was required for vbetool.
>
>   
>> If you need to signal nis, you need to read the pid file.  This is what 
>> dhcpd does.
>>     
>
> See my previous email.
>
>   
>> spamassassin needs to write to users homedirs in targeted policy.  I 
>> hate it but, it has to work.
>>
>> unconfined_t was not able to read textrel_shlib_t.
>> Added auditallow to show when unconfined_t is running a program that 
>> requires execmem
>>     
>
> merged.
>
>   


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
