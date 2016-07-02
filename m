Subject: Re: Fwd: SElinux user tools 2.5 change
To: Steve Lawrence <slawrence@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>,
 Miroslav Grepl <mgrepl@redhat.com>, Lukas Vrabec <lvrabec@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
References: <35737536-B901-44F9-8336-509CDA386932@wal-mart.com>
 <909baadb-ae53-d6c7-be85-c9d645def448@redhat.com>
 <cb19890b-f5eb-6d1f-5a7b-543ff6b435b3@tresys.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <801569d0-26ea-0038-90c6-65945fa8935a@redhat.com>
Date: Sat, 2 Jul 2016 05:43:09 -0700
MIME-Version: 1.0
In-Reply-To: <cb19890b-f5eb-6d1f-5a7b-543ff6b435b3@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 06/30/2016 07:19 PM, Steve Lawrence wrote:
> On 06/30/2016 05:47 PM, Daniel J Walsh wrote:
>>    A customer is asking:
>>
>> The SELinux userspace tools version 2.5 introduced a change to remove the
>> semodule version from the semodule –l output.  This poses problems for people
>> (like us) who are using configuration management tools like Puppet to manage
>> SELinux modules – how is Puppet supposed to know which version of the module is
>> installed?  Should it try to load the module every time?
>>
>> I have raised the issue with Puppet as
>> https://tickets.puppetlabs.com/browse/PUP-5649 but I believe the real question
>> should be, how is a config management system supposed to know which version of a
>> module to try to install?
>>
>> Thanks for any assistance you can provide with this, and we will continue to run
>> in enforcing mode by default for RHEL 7+.
> I would argue version numbers have never really meant anything. Nothing
> forced you to update the module version when you made changes aside from
> convention. So you could easily have two version 1.0's that are
> completely different.
>
> I imagine puppet and other configuration managers have some concept of
> hash verification to determine what files are installed on the target
> machine, and if they need to be updated to something else (similar to
> git). That, to me, seems the better and more conclusive way to ensure
> that the right modules are installed.
>
> There is currently no API to get the hash of a module, but one could
> manually hash the files that are in the policy store. If we need a more
> user friendly method, I imagine it wouldn't be too difficult to add some
> kind of hash to semodule -l output. Do either of those options seem
> reasonable?
>
> - Steve
I can suggest that to the customer and get a change into semanage/semodule.
