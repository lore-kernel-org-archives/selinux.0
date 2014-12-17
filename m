Message-ID: <54918D8B.1020607@tycho.nsa.gov>
Date: Wed, 17 Dec 2014 09:04:59 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andrew Gunnerson <andrewgunnerson@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: "SELinux: ebitmap: truncated map" after editing with libsepol
References: <54914D21.9030800@gmail.com> <54918CF3.4060701@tycho.nsa.gov>
In-Reply-To: <54918CF3.4060701@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/17/2014 09:02 AM, Stephen Smalley wrote:
> On 12/17/2014 04:30 AM, Andrew Gunnerson wrote:
>> Hello all,
>>
>> I have a very simple test program to help with debugging my Android
>> dual booting project. It reads the current policy from
>> /sys/fs/selinux/policy,
>> changes a single type to be permissive, and then loads the new policy
>> by writing it to /sys/fs/selinux/load. The problem is, after editing the
>> policy with sepol, it fails to load and the kernel prints the following
>> message in dmesg: "SELinux: ebitmap: truncated map".
>>
>> The program reads and writes the policy file using the standard fopen
>> and policydb_read/policydb_write calls. I then set a few types to be
>> permissive using the following loop:
>>
>>     ...
>>     char *name;
>>     int is_permissive;
>>     char **types = (null terminated char* array)
>>     char **type;
>>     ...
>>     for (unsigned int i = 0; i < pdb->p_types.nprim - 1; i++) {
>>         name = pdb->p_type_val_to_name[i];
>>         is_permissive = ebitmap_get_bit(&pdb->permissive_map, i + 1);
>>
>>         if (!is_permissive) {
>>             for (type = types; *type; type++) {
>>                 if (strcmp(*type, name) == 0) {
>>                     ebitmap_set_bit(&pdb->permissive_map, i + 1, 1);
>>                     break;
>>                 }
>>             }
>>         }
>>     }
>>     ...
>>
>> I've been trying to debug this for many hours, but I can't seem to figure
>> out why this is happening. Is there a simple mistake I'm overlooking or
>> am I approaching this in a completely wrong way?
>>
>> Thanks in advance! Any help is greatly appreciated!
>>
>> Andrew Gunnerson
>>
>>
>> PS: This is running on Android 5.0 with libsepol 2.4-rc4 and kernel
>> 3.4.0-g88fbc66.
> 
> The implementation of /sys/fs/selinux/load requires you to write the
> entire policy in a single write(2) call, so you can't use stdio methods
> for writing the policy image.  policydb_write() the image to memory and
> then call security_load_policy() on that memory region.

You can use policydb_to_image() to write a policydb to a memory region,
obtaining a (data, len) pair describing the region, and then call
security_load_policy() on that pair.

> Also, you can see a working example of a program that does this kind of
> thing (but on files rather than directly to /sys/fs/selinux/load) in
> sepolicy-inject,
> https://bitbucket.org/joshua_brindle/sepolicy-inject
> 
> Any particular reason you are building a pre-release upstream libsepol
> rather than the one included in AOSP (external/libsepol)?  Admittedly,
> that is only built for the host, not the device, presently, so you'd at
> least need to change that.
> 
