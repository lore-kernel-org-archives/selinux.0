Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u12IVxFd020791
 for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2016 13:32:01 -0500
Received: by mail-ob0-f179.google.com with SMTP id ba1so157981121obb.3
 for <selinux@tycho.nsa.gov>; Tue, 02 Feb 2016 10:31:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B0F257.60504@tycho.nsa.gov>
References: <CAB5=j_qPtHM-D0X6qZf151es_erjfBWYMohLx+PF6toFaKaJgg@mail.gmail.com>
 <56B0F257.60504@tycho.nsa.gov>
Date: Tue, 2 Feb 2016 13:31:56 -0500
Message-ID: <CAMN686EKKebVP7Kwj9M+ziZu_-8KSZZsUu3+_Kcg-ahQZtVRYw@mail.gmail.com>
Subject: Re: SELinux file context matching
From: Mike Palmiotto <mike.palmiotto@crunchydata.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Mark Steele <mark@control-alt-del.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Feb 2, 2016 at 1:15 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 02/02/2016 12:48 PM, Mark Steele wrote:
>>
>> Hi list,
>>
>> I've got some file contexts setup for an application, and can't get the
>> file context matching to work as I would expect.
>>
>> [root@dev1 policy]# cat
>> /etc/selinux/targeted/contexts/files/file_contexts | grep cinched
>> /etc/cinched(/.*)?      system_u:object_r:ts_etc_t:s0
>> /var/log/cinched(/.*)?  system_u:object_r:ts_log_t:s0
>> /var/lib/cinched(/.*)?  system_u:object_r:ts_t:s0
>> */usr/lib64/cinched(/.*)?        system_u:object_r:ts_lib_t:s0*
>> /etc/bash_completion.d/cinched_bash_completions
>> system_u:object_r:ts_etc_t:s0
>> /var/log/cinched/audit(/.*)?    system_u:object_r:ts_audit_log_t:s0
>> /usr/sbin/cinched       system_u:object_r:ts_exec_t:s0
>>
>> [root@dev1 policy]# matchpathcon /usr/lib64/cinched/
>> */usr/lib64/cinched      system_u:object_r:lib_t:s0*
>>
>> [root@dev1 policy]# findcon
>> /etc/selinux/targeted/contexts/files/file_contexts -p /usr/lib64/cinched
>> /.*             system_u:object_r:default_t:s0
>> /usr/.*         system_u:object_r:usr_t:s0
>> */usr/lib64/cinched(/.*)?                system_u:object_r:ts_lib_t:s0*
>>
>>
>> This is running on CentOS 7. I was assuming that since my rule has the
>> longest stem, it would be applied.
>>
>> Any suggestions?
>
>
> It would help to see the complete file_contexts file.
> Do you have anything in file_contexts.local that could be overriding it?

Also, it looks like file_context.subs_dist has the entry: '/usr/lib64
/usr/lib' on CentOS 7. Perhaps Mark's file entries should instead be
using /usr/lib/cinched?

--Mike
