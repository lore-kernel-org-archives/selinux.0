Message-ID: <53FF8DE9.6070302@tycho.nsa.gov>
Date: Thu, 28 Aug 2014 16:15:37 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc1
References: <53FCA845.1030001@tresys.com> <20140827150608.GA6701@siphos.be>
 <53FE02E5.6080506@tresys.com>
 <CAPzO=NyyP-m8jPBujd-vnG9XHo2FymskgQBH3fKPt448NznZdA@mail.gmail.com>
In-Reply-To: <CAPzO=NyyP-m8jPBujd-vnG9XHo2FymskgQBH3fKPt448NznZdA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/28/2014 03:58 PM, Sven Vermeulen wrote:
> On Wed, Aug 27, 2014 at 6:10 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>> The only action that should be required post upgrade is migration from
>> /etc/selinux to /var/lib/selinux. There is detailed information about
>> this process on the GitHub "Policy Store Migration" wiki page [2], but
>> the jist of it is after upgrading, execute the the
>> semanage_migrate_store script installed by default to
>> /usr/libexec/selinux. The script has additional options that can be used
>> to do things like remove the old store or prevent rebuilding the policy.
>> Run the script with --help for a description of the options.
>>
>> Please let us know if there are any questions/issues.
> 
> Hi Steve
> 
> (Sorry for the direct mail in the previous remark, gmail doesn't like
> to automatically reply to the mailinglist)
> 
> When running the semanage_migrate_script I get the following problem:
> 
> Migrating from /etc/selinux/mcs/modules/active to /var/lib/selinux/mcs/active
> Attempting to rebuild policy from /var/lib/selinux
> sysnetwork: Warning: 'else' blocks in optional statements are
> unsupported in CIL. Dropping from output.
> Segmentation fault
> 
> The segmentation fault comes up at the following python code:
> 
> rc = semanage.semanage_commit(handle)
> 
> In the logs, I get:
> 
> [ 2403.250065] semanage_migrat[25752]: segfault at 28 ip
> 000003044dd14c5b sp 000003d2272a1140 error 4 in
> libsepol.so.1[3044dcb2000+8f000]
> 
> The system has grsecurity enabled as well, but grsecurity should give
> more output if it was preventing something. I'll investigate this more
> tomorrow-evening.

Can you provide a copy of your original policy prior to conversion?
