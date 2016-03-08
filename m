Subject: Re: initial_sid context via libsepol
To: Richard Haines <richard_c_haines@btinternet.com>, William Roberts
 <bill.c.roberts@gmail.com>
References: <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
 <1439711485.8727172.1457442762500.JavaMail.yahoo@mail.yahoo.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <56DED861.8060101@tresys.com>
Date: Tue, 8 Mar 2016 08:49:21 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
In-Reply-To: <1439711485.8727172.1457442762500.JavaMail.yahoo@mail.yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 3/8/2016 8:12 AM, Richard Haines wrote:
> On Tuesday, 8 March 2016, 1:32, William Roberts <bill.c.roberts@gmail.com> wrote:
>> On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 03/07/2016 01:44 PM, Stephen Smalley wrote:
>>> On 03/07/2016 10:41 AM, Richard Haines wrote:
>>>>> On Saturday, 5 March 2016, 14:48, Richard Haines
>>>>>> <richard_c_haines@btinternet.com> wrote:
>>>>>> On Friday, 4 March 2016, 21:18, "Roberts, William C"
>>>>>> <william.c.roberts@intel.com> wrote:
>>>>>>>
>>>>>>> How can one obtain the same value as
>>>>>>> /sys/fs/selinux/initial_contexts/file via libsepol?
>>>>>>
> 
> From what I can see the only ways for you to get the context of a specifically
> named initial sid, is to:
> 
> 1) If working on the active policy then read /sys/fs/selinux/initial_contexts
> for the specific name.
> 
> 2) If working on a binary policy that has been loaded by libsepol for
> investigation, then I guess the official answer would be "you cannot do
> this", simply because the names are not held in the binary policy.
> 
> What you could do is:
> 
> a) Load the initial_sid_to_string.h or the policy initial_sids file and search
> through it for a match. This will give the offset and would (by magic) give
> the initial SID value (e.g. "file" = 5) as it just so happens that the
> initial SIDs start at '1' in a standard SELinux system. You can then obtain
> the context string.
> 
> b) Or you could just say they start at 1 and I know "file" is the 5th entry !!
> 
> c) Modify policy, kernel etc. to add the names.
> 
> Unless someone knows another way !!!!

I realize this is about libsepol, but if you happen to have setools3
available, it can also retrieve this information, e.g.

$ seinfo --initialsid=node -x
                node:  system_u:object_r:node_t:s0

So in your program you could use the libapol library functions and look
it up in /sys/fs/selinux/policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
