Subject: Re: SELinux file context matching
To: Mark Steele <mark@control-alt-del.org>, selinux@tycho.nsa.gov
References: <CAB5=j_qPtHM-D0X6qZf151es_erjfBWYMohLx+PF6toFaKaJgg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56B0F257.60504@tycho.nsa.gov>
Date: Tue, 2 Feb 2016 13:15:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAB5=j_qPtHM-D0X6qZf151es_erjfBWYMohLx+PF6toFaKaJgg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/02/2016 12:48 PM, Mark Steele wrote:
> Hi list,
>
> I've got some file contexts setup for an application, and can't get the
> file context matching to work as I would expect.
>
> [root@dev1 policy]# cat
> /etc/selinux/targeted/contexts/files/file_contexts | grep cinched
> /etc/cinched(/.*)?      system_u:object_r:ts_etc_t:s0
> /var/log/cinched(/.*)?  system_u:object_r:ts_log_t:s0
> /var/lib/cinched(/.*)?  system_u:object_r:ts_t:s0
> */usr/lib64/cinched(/.*)?        system_u:object_r:ts_lib_t:s0*
> /etc/bash_completion.d/cinched_bash_completions
> system_u:object_r:ts_etc_t:s0
> /var/log/cinched/audit(/.*)?    system_u:object_r:ts_audit_log_t:s0
> /usr/sbin/cinched       system_u:object_r:ts_exec_t:s0
>
> [root@dev1 policy]# matchpathcon /usr/lib64/cinched/
> */usr/lib64/cinched      system_u:object_r:lib_t:s0*
>
> [root@dev1 policy]# findcon
> /etc/selinux/targeted/contexts/files/file_contexts -p /usr/lib64/cinched
> /.*             system_u:object_r:default_t:s0
> /usr/.*         system_u:object_r:usr_t:s0
> */usr/lib64/cinched(/.*)?                system_u:object_r:ts_lib_t:s0*
>
>
> This is running on CentOS 7. I was assuming that since my rule has the
> longest stem, it would be applied.
>
> Any suggestions?

It would help to see the complete file_contexts file.
Do you have anything in file_contexts.local that could be overriding it?
