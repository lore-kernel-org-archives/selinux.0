Subject: Re: [RFC PATCH V2] libselinux: Add selinux_restorecon function
To: Richard Haines <richard_c_haines@btinternet.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <560AF385.1090407@tycho.nsa.gov>
 <212239354.5552563.1443712727654.JavaMail.yahoo@mail.yahoo.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56181D68.5030700@tycho.nsa.gov>
Date: Fri, 9 Oct 2015 16:02:48 -0400
MIME-Version: 1.0
In-Reply-To: <212239354.5552563.1443712727654.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/01/2015 11:18 AM, Richard Haines wrote:
>> On Tuesday, 29 September 2015, 21:25, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 09/27/2015 08:06 AM, Richard Haines wrote:
>>>   The selinux_restorecon(3) man page details this function that relies
>>>   on the selabel_digest(3) function available from [1] (as not yet
>>>   part of upstream libselinux).
>>>
>>>   It has been built using the work from Android where an SHA1 hash
>>>   of the specfiles is held in an extended attribute to enhance
>>>   performance. Also contains components from policycoreutils/setfiles.
>>>
>>>   The utils/selinux_restorecon.c utility demonstrates the functionality.
>>>
>>>   [1] http://marc.info/?l=selinux&m=144274383217343&w=2
>>>
>>>   Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
>>>   ---
> ------------ snip --------------
>>>   +
>>>   +extern int selinux_restorecon(const char **pathname_list,
>>>   +                    const char **exclude_list,
>>>   +                    const char *fc_path,
>>>   +                    unsigned int restorecon_flags);
>>
>
>> This is a more cumbersome interface for typical users than the Android one.
>
> To make this easier would you prefer it to just take a single pathname and the
> flags (and maybe the fc_path as well, or add another interface to take it as
> discussed below)

Yes, it would be preferably to keep the default interface simple, and 
provide other interfaces to set non-default behaviors that go beyond 
simple flags.

> The only reason I put the exclude_list is to allow filesystems that don't have
> xattr support to be excluded by the caller. This could probably be resolved by
> always setting the FTS_XDEV flag with the caller ensuring they cover their
> relevant filesystems.

Well, setfiles does have the -e option, so providing a way to set an 
exclude list makes sense; it just doesn't necessarily have to be part of 
the default interface as opposed to a separate set_exclude_list 
interface called before invoking restorecon.

>
> ---------------- snip ----------------------
>
>>>   +    fc_sehandle = selabel_open(SELABEL_CTX_FILE, fc_opts,
>> NUM_SELABEL_OPTS);
>>>   +    if (!fc_sehandle) {
>>>   +        selinux_log(SELINUX_ERROR,
>>>   +                "Error obtaining file context handle: %s\n",
>>>   +                            strerror(errno));
>>>   +        return -1;
>>>   +    }
>>
>> Android only does this once, not on every call to restorecon.
>> Caller that wants to use selabel_open() itself with custom options can
>> use selinux_android_set_sethandle() after selabel_open() call;
>
>> otherwise, callers don't ever have to specify selabel_open() args.
>
> I could implement a similar interface to selinux_android_file_context_handle
> (I guess that is what you are referring to) that would also take the fc_path
> if this would be useful, it then keep selinux_restorecon simple and in line
> with Android.

No, you would need an interface like set_sehandle(), which sets the 
handle used internally by restorecon to a handle provided by the caller 
(where that handle might originate from a direct selabel_open call by 
the caller if it wants full control, or from a call to 
selinux_android_file_context_handle if it just needs a reference to the 
handle for use elsewhere).
