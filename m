Subject: Re: [PATCH] selinux: distinguish non-init user namespace capability
 checks
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
References: <1460137920-17190-1-git-send-email-sds@tycho.nsa.gov>
 <1976950.a3EgWPGDNc@sifl>
 <46d242c8-ca4c-dfea-a93f-73bdc57db1cd@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>, <dwalsh@redhat.com>, Miroslav Grepl
 <mgrepl@redhat.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <5720AF16.1020108@tresys.com>
Date: Wed, 27 Apr 2016 08:22:46 -0400
MIME-Version: 1.0
In-Reply-To: <46d242c8-ca4c-dfea-a93f-73bdc57db1cd@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/26/2016 4:06 PM, Stephen Smalley wrote:
> On 04/26/2016 03:51 PM, Paul Moore wrote:
>> On Friday, April 08, 2016 01:52:00 PM Stephen Smalley wrote:
>>> Distinguish capability checks against a target associated
>>> with the init user namespace versus capability checks against
>>> a target associated with a non-init user namespace by defining
>>> and using separate security classes for the latter.
>>>
>>> This is needed to support e.g. Chrome usage of user namespaces
>>> for the Chrome sandbox without needing to allow Chrome to also
>>> exercise capabilities on targets in the init user namespace.
>>>
>>> Suggested-by: Dan Walsh <dwalsh@redhat.com>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>>  security/selinux/hooks.c            | 14 +++++++-------
>>>  security/selinux/include/classmap.h | 28 ++++++++++++++++++----------
>>>  2 files changed, 25 insertions(+), 17 deletions(-)
>>
>> Applied, thanks.
> 
> I pushed the test for these new checks to a branch of selinux-testsuite
> (#userns) because the test can't be used without a corresponding update
> to policy to define the new classes, so I will wait to merge to master
> until rawhide gets the new class definitions.  Also, I'll need to make
> the test code conditional on kernel version so that it won't fail on
> kernels that predate the support.  Will this change be in 4.7?

I've pushed the class definitions for refpolicy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
