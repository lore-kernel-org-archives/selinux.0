Subject: Re: selabel_lookup_raw() doesn't find correct context for path with
 double slashes
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <070cda6f-fcdf-1cd0-9989-9cc97eaaf49d@debian.org>
 <1496323462.27759.2.camel@tycho.nsa.gov>
Cc: 863854-forwarded@bugs.debian.org
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <a06c7239-39a9-b2c1-e045-52e138f2fcde@debian.org>
Date: Thu, 1 Jun 2017 15:37:41 +0200
MIME-Version: 1.0
In-Reply-To: <1496323462.27759.2.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 01/06/17 à 15:24, Stephen Smalley a écrit :
> On Thu, 2017-06-01 at 11:29 +0200, Laurent Bigonville wrote:
>> Hello,
>>
>> While investigating a bug about systemd/udev not setting the proper
>> context on the hwdb.bin file, Michael Biebl discovered that
>> apparently
>> the selabel_lookup_raw() function is not coping properly with paths
>> with
>> double slashes (like "//lib/udev/hwdb.bin")
>>
>> Shouldn't the selabel_lookup*() functions be more resilient to this
>> case? Or should application canonicalize (with realpath()?) the path
>> before calling these functions?
>>
>> Regards,
>>
>> Laurent Bigonville
>>
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863854
> AFAICS, it already does this, and has done so for a long time.
>
> $ selabel_lookup -r -b file -k //lib/udev/hwdb.bin
> Default context: system_u:object_r:bin_t:s0
>
> $ selabel_lookup -r -b file -k /lib/udev/hwdb.bin
> Default context: system_u:object_r:bin_t:s0
>
> (The output may differ on your system due to policy differences - mine
> was on Fedora - but the point is that the resulting context is the same
> with and without the double slashes.)
Thanks for the reply.

Interesting, this doesn't seem to be the case in debian unstable 
(SELinux userspace 2.6) and I'm using the refpolicy here on my test machine:

$ /usr/sbin/selabel_lookup -r -b file -k //lib/udev/hwdb.bin
Default context: system_u:object_r:default_t:s0

$ /usr/sbin/selabel_lookup -r -b file -k /lib/udev/hwdb.bin
Default context: system_u:object_r:bin_t:s0


> The relevant code is:
> https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/label_file.c#L716
>
> The commit was:
> https://github.com/SELinuxProject/selinux/commit/8f007923dd4ff89652479587d96e22bc63dbf822
>
> That said, if further canonicalization beyond duplicate slash removal
> is needed (ala realpath), that is on the caller.  That is done for
> example by selinux_restorecon(3), if SELINUX_RESTORECON_REALPATH is
> passed to it.
