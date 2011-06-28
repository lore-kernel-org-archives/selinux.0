Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5SD2iSj003939
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 09:02:44 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5SD2hgJ003850
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 13:02:43 GMT
Received: by wwf22 with SMTP id 22so141739wwf.30
        for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 06:02:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E08B41F.80608@trentalancia.com>
References: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
	<4E08B41F.80608@trentalancia.com>
Date: Tue, 28 Jun 2011 06:02:42 -0700
Message-ID: <BANLkTimY8OOEzZjfA=z=vfY_p3+XN3N8EQ@mail.gmail.com>
Subject: Re: login process unable to execute /bin/sh
From: Sam Gandhi <samgandhi9@gmail.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Guido,

On Mon, Jun 27, 2011 at 9:47 AM, Guido Trentalancia
<guido@trentalancia.com> wrote:
> Hello Sam !
>
> At a very first sight, I have spotted something...
>
> On 27/06/2011 17:44, Sam Gandhi wrote:
>>
>> I have labelled login and sh as shown below.
>>
>> -rwxr-xr-x    1     25024 Jun 24 22:20 system_u:object_r:login_exec_t
>>  /bin/login
>> -rwxr-xr-x    1          15 Jun 24 18:40 system_u:object_r:bin_t
>>    /bin/sh
>>
>> Following is output of ps -Z
>>       1 system_u:system_r:init_t         S    init
>>   583 system_u:system_r:local_login_t  S    login -- root
>>
>> But when I login I see these messages :
>>
>> Jan  1 10:00:23 192.168.137.1 kernel: type=1400 audit(23.040:40): avc:
>>  granted  { transition } for  pid=596 comm="getty" path="/bin/login"
>> dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
>> tcontext=system_u:system_r:local_login_t tclass=process
>
> This is one way, granted.
>
>> Jun 28 01:30:17 192.168.137.1 kernel: type=1400
>> audit(1309188617.348:46): avc:  denied  { transition } for  pid=833
>> comm="login" path="/bin/sh" dev=ubifs ino=93
>> scontext=system_u:system_r:local_login_t
>> tcontext=root:system_r:initrc_t tclass=process
>
> Now this is the other way, there's no rule !
>
>> I do see following statement in policy.conf (monolithic)
>>
>> allow local_login_t initrc_t:process transition;
>
> Perhaps, you should try adding the other rule ?
>
> allow initrc_t local_login_t:process transition;

I already have the above rule in the policy.

Jan  1 10:00:37 192.168.137.1 kernel: type=1400 audit(37.230:44): avc:
 granted  { transition } for  pid=600 comm="getty" path="/bin/login"
dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
tcontext=system_u:system_r:local_login_t tclass=process

Am I wrong in assuming that getty is not an issue because audit
message indicates that when getty executed program /bin/login , domain
transition was done successfully to local_login_t

Jan  1 10:00:39 192.168.137.1 kernel: type=1400 audit(39.090:45): avc:
 denied  { transition } for  pid=812 comm="login" path="/bin/sh"
dev=ubifs ino=93 scontext=system_u:system_r:local_login_t
tcontext=root:system_r:initrc_t tclass=process

One more piece of information I didn't include in previous email was,
/bin/sh is labeled as shell_exec_t and I do see following rules in my
policy.conf.

type_transition initrc_t shell_exec_t:process initrc_t;
allow initrc_t shell_exec_t:file { read { getattr execute } Ballow
initrc_t shell_exec_t:file { read getattr lock execute ioctl };
allow initrc_t shell_exec_t:file entrypoint;

allow local_login_t shell_exec_t:file { read { getattr execute } };
type_transition local_login_t shell_exec_t:process initrc_t;
allow local_login_t shell_exec_t:file { read { getattr execute } };
allow local_login_t shell_exec_t:file { { read getattr lock execute
ioctl } execute_no_trans };
allow local_login_t shell_exec_t:file entrypoint;

The best as I understand allow rules, the local_login_t rules above
says, when process running in context local_login_t (login program in
my case) tries to execute program of type shell_exec_t it should be
allowed, and process should transition to context initrc_t (because of
type_transition statement above).

Still puzzled as to why I keep getting local_login deny message
(help!). I am running the system with  'auditallow domain
domain:process transition;'  and I don't see any other domain
transitions happening when I try to login to my system.

-Sam


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
