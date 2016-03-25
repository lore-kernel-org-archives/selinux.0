Subject: Re: what is /sys/fs/selinux/policy_capabilities/redhat1
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Daniel J Walsh <dwalsh@redhat.com>
References: <56F5152E.3050602@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56F52FA5.6050601@tycho.nsa.gov>
Date: Fri, 25 Mar 2016 08:31:33 -0400
MIME-Version: 1.0
In-Reply-To: <56F5152E.3050602@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/25/2016 06:38 AM, Dominick Grift wrote:
> 
> I noticed that object what is it for?

Red Hat reserved a policy capability when they were testing
ptrace_child, which they ultimately discarded.  So it is presently
unused and maybe could be reclaimed?  I assume ptrace_child never made
it into any RHEL release?

Oddly, I see that current Fedora policy still defines a ptrace_child
permission in class process, even though the kernel knows nothing about it.
