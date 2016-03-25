Subject: Re: what is /sys/fs/selinux/policy_capabilities/redhat1
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>
References: <56F5152E.3050602@gmail.com> <56F52FA5.6050601@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <56F539B9.9080003@redhat.com>
Date: Fri, 25 Mar 2016 09:14:33 -0400
MIME-Version: 1.0
In-Reply-To: <56F52FA5.6050601@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 03/25/2016 08:31 AM, Stephen Smalley wrote:
> On 03/25/2016 06:38 AM, Dominick Grift wrote:
>> I noticed that object what is it for?
> Red Hat reserved a policy capability when they were testing
> ptrace_child, which they ultimately discarded.  So it is presently
> unused and maybe could be reclaimed?  I assume ptrace_child never made
> it into any RHEL release?
>
> Oddly, I see that current Fedora policy still defines a ptrace_child
> permission in class process, even though the kernel knows nothing about it.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
We should probably drop it.
