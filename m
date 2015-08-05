Subject: Re: How do you relabel all SELinux file contexts of an offline
 system's file system?
To: Jason Zaman <jason@perfinion.com>, Bond Masuda <bond.masuda@jlbond.com>
References: <55C13DA1.2070601@jlbond.com>
 <20150805065406.GA17019@meriadoc.omgwtfbbq>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55C2036E.2060609@tycho.nsa.gov>
Date: Wed, 5 Aug 2015 08:37:02 -0400
MIME-Version: 1.0
In-Reply-To: <20150805065406.GA17019@meriadoc.omgwtfbbq>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/05/2015 02:54 AM, Jason Zaman wrote:
> On Tue, Aug 04, 2015 at 03:33:05PM -0700, Bond Masuda wrote:
>> Hello,
>>
>> Normally, if I need to ensure that all the SELinux file contexts are
>> correct, I run:
>>
>> restorecon -R -v /
>>
>> However, in the current situation, I need to do that on a system that is
>> offline, where I have it's root and entire file system mounted under
>> /mnt. I tried:
>>
>> chroot /mnt /usr/sbin/restorecon -R -v /mnt
>>
>> hoping it would have the same effect, but it does not appear to. When I
>> boot the offline system, it shows a lot of SELinux mislabelings.
>>
>> Is there a way to fix SELinux file contexts of another system while it
>> is offline?
>>
>> Thanks for any help...
>> -Bond
> 
> Look at setfiles, you want something like this:
> 
> setfiles -vr /mnt/ /etc/selinux/strict/contexts/files/file_contexts /mnt/
> 
> from setfiles(8):
>        -r rootpath
>               use an alternate root path.

A couple of caveats:

- If using the -r option of setfiles rather than chroot'ing to the root
of the offline system, you want to specify the file_contexts file from
the policy of the offline system, not the file_contexts of the host on
which you are running, e.g setfiles -r
/mnt/etc/selinux/targeted/contexts/files/file_contexts /mnt.

- Not all of the contexts defined by the offline system's file_contexts
may be valid under the policy of the host on which you are running (e.g.
if they run different distributions or even different releases of the
same distribution), which will normally prevent setting those contexts
(the kernel won't recognize them).  If you have this issue, you'll need
to run setfiles as root in a special domain, setfiles_mac_t, that is
allowed to set contexts unknown to the host policy, and likely chrooted
so that it doesn't ask the kernel whether the contexts are valid via
/sys/fs/selinux/context.  That is how livecd-creator supported creating
images for other releases.

It would help to know what kinds of "mislabelings" you are encountering
on the offline system when it is booted, e.g. what files were
mislabeled, what contexts were they supposed to have and what contexts
did they have, and were these cases where the host file_contexts
differed from the offline system file_contexts.
