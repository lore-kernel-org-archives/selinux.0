Subject: Re: [RFC][PATCH] selinux: distinguish non-init user namespace
 capability checks
To: Stephen Smalley <stephen.smalley@gmail.com>
References: <1459958221.7680.2.camel@gmail.com> <570559FF.1050207@tresys.com>
 <CAB9W1A3pcuV14u+kD0rYTQYYoKydocTDdLav4V6Xp1quD_nohw@mail.gmail.com>
CC: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <57055C9C.5050706@tresys.com>
Date: Wed, 6 Apr 2016 14:59:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAB9W1A3pcuV14u+kD0rYTQYYoKydocTDdLav4V6Xp1quD_nohw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/6/2016 2:55 PM, Stephen Smalley wrote:
> On Wed, Apr 6, 2016 at 11:48 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
>> On 4/6/2016 11:57 AM, Stephen Smalley wrote:
>>> Distinguish capability checks against a target associated
>>> with the init user namespace versus capability checks against
>>> a target associated with a non-init user namespace by defining
>>> and using separate security classes for the latter.
>>>
>>> This is needed to support e.g. Chrome usage of user namespaces
>>> for the Chrome sandbox without needing to allow Chrome to also
>>> exercise capabilities on targets in the init user namespace.
>>
>> Is there any reason not to define a new pair of commons (cap, cap2) in
>> refpolicy?  This is more of a question of what you did in the below
>> hunks vs. the refpolicy patch you had in the other email which didn't
>> have commons.
> 
> Ah, good point.  Just wasn't thinking very hard about the refpolicy patch ;)
> That should work.

In that case, I've got a local patch for refpolicy, using commons, ready
to go when this patch set starts making its way upstream.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
