Subject: Re: Newbie question on fixfiles
To: Thomas Downing <tdowning@bomgar.com>, selinux@tycho.nsa.gov
References: <1464190.SZXTM0cE5o@juss> <56ABA942.9020701@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56ABB3CB.9020306@tycho.nsa.gov>
Date: Fri, 29 Jan 2016 13:47:39 -0500
MIME-Version: 1.0
In-Reply-To: <56ABA942.9020701@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/29/2016 01:02 PM, Stephen Smalley wrote:
> On 01/29/2016 12:25 PM, Thomas Downing wrote:
>> Hi,
>>
>> I need to get SELinux running on an appliance we are building, not
>> based on a
>> distro that already supports SELinux.
>>
>> I've got all the userspace stuff built, (including setools3) without any
>> warnings or errors. I followed instructions for installing and loading
>> refpolicy, no warnings or errors.  (Except the python tools, which all
>> import
>> selinux.py, which does not seem to be included in the source tree.)
>>
>> I'm booting with kernel options "security=selinux selinux=1", and
>> dmesg shows
>> SELinux initializing, and no errors or warnings.
>>
>> sestatus output:
>>
>> SELinux status:                enabled
>> SELinuxfs mount:            /sys/fs/selinux
>> SELinux root directory:        /etc/selinux
>> Loaded policy name:        refpolicy
>> Current mode:                permissive
>> Mode from config file:        permissive
>> Policy MLS status:            disabled
>> Policy deny_unknown status:    denied
>> Max kernel policy version:        30
>>
>> Problem is: fixfiles does not actually label anything, and the
>> underlying reason
>> is that none of the mounted disk filesystems (all ext4) have option
>> 'seclabel'.
>>
>> Any pointers?
>>
>> Also, given the absence of the seclabel option, I question if the
>> kernel part
>> of SELinux is in fact really happy...and if it isn't, I'm dead in the
>> water
>> anyway.
>
> This implies that you haven't loaded a policy into the kernel. Normally
> this is done by init; both sysvinit and systemd should already include
> the necessary bits but you may have to enable them in your configure.

Sorry, I didn't read that carefully enough - your sestatus output would 
suggest that you have loaded a policy.

What's the actual output you got from SELinux during boot?

What's your kernel version?
