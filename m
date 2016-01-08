Subject: Re: Labeling nsfs filesystem
To: Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Iooss
 <nicolas.iooss@m4x.org>, <selinux@tycho.nsa.gov>
References: <568ECC43.40500@m4x.org> <568ED656.5030106@tycho.nsa.gov>
 <568FB2FA.3010702@tresys.com> <568FC404.1030307@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <568FC6BA.2060505@tresys.com>
Date: Fri, 8 Jan 2016 09:24:58 -0500
MIME-Version: 1.0
In-Reply-To: <568FC404.1030307@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/8/2016 9:13 AM, Stephen Smalley wrote:
> On 01/08/2016 08:00 AM, Christopher J. PeBenito wrote:
>> On 1/7/2016 4:19 PM, Stephen Smalley wrote:
>>> On 01/07/2016 03:36 PM, Nicolas Iooss wrote:
>>>> Hello,
>>>>
>>>> Since Linux 3.19 targets of /proc/PID/ns/* symlinks have lived in a fs
>>>> separated from /proc, named nsfs [1].  These targets are used to enter
>>>> the namespace of another process by using setns() syscall [2].  On old
>>>> kernels, they were labeled with procfs default type (for example
>>>> "getfilecon /proc/self/ns/uts" returned system_u:object_r:proc_t:s0).
>>>> When using a recent kernel with a policy without nsfs support, the
>>>> inodes are not labeled, as reported for example in Fedora bug #1234757
>>>> [3].  As I encounter this issue on my systems, I asked yesterday on the
>>>> refpolicy ML how nsfs inodes should be labeled [4].
>>>>
>>>> After digging a little bit about the possibilities, here is a
>>>> summary of
>>>> the options I have considered so far.
>>>>
>>>> Option 1: define a new type to label nsfs inodes, nsfs_t.  This
>>>> works as
>>>> expected (c.f. [5] for more details).
[...]
>>> Only option 1 makes sense to me.
>>
>> I don't understand the usage of nsfs which makes this confusing, but why
>> doesn't option 3 make sense?  Since it's under a particular /proc/pid
>> entry, doesn't it make sense to label the object as the domain's type?
> 
> The symlink is under a particular /proc/pid directory, but the target is
> per-namespace, not per-process.

In that case, I agree with the genfscon approach.  I originally thought
it was per-process.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
