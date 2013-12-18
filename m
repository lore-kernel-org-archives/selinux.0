MIME-Version: 1.0
In-Reply-To: <52B20217.8030908@tycho.nsa.gov>
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
 <52B20217.8030908@tycho.nsa.gov>
Date: Wed, 18 Dec 2013 13:46:40 -0800
Message-ID: <CACVacMszVX7Yuv1rcuzphQ2YXXCABMb2aQ1CY3zcoaiNmoqHYw@mail.gmail.com>
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
From: Jay Corrales <jscorrales1122@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

ls -Z shows system_u:object_r:awips_exec_t. If execute_no_trans allow
is add, it does not run in the awips_exec_t domain, but in user_t.

On 12/18/13, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/17/2013 11:23 AM, Jay Corrales wrote:
>> Folks,
>>
>> We're running RedHat Enterprise Linux 5 (rhel5) with selinux strict and
>> enforcing mode, and finding that something in our configuration prevents
>> a
>> simple shell script from domain transitioning from user_t to awips_t
>> context. If we run a test virtual machine with a new install of rhel5, it
>> does run OK, but something in our current configuration prevents this
>> result. Wondering if it makes sense to run a tool like apol to find any
>> clues as to why? The audit log (/var/log/audit/audit.log) shows an AVC
>> requiring execute_no_trans for user_t (no listed here).
>
> Here you say you have a execute_no_trans denial.
>
>> [root@localhost ~]# sesearch -a -s user_t -t awips_exec_t -c file -p
>> execute
>
> Here you search for execute permission.
>
> They are different.
>
> Also, what does ls -Z show for the script?
>
>
>
