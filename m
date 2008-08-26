Message-ID: <48B41B92.50608@redhat.com>
Date: Tue, 26 Aug 2008 11:04:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] selinux: add support for installing a dummy policy
References: <20080822193413.GA8401@us.ibm.com> <1219676185.2627.1.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1219676185.2627.1.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> On Fri, 2008-08-22 at 14:34 -0500, Serge E. Hallyn wrote:
>> In August 2006 I posted a patch to the selinux list generating a minimal
>> SELinux policy.  This week, David P. Quigley posted an updated version
>> of that as a patch against the kernel.  In addition to some fixes, also
>> had nice logic for auto-installing the policy.
>>
>> I've gone ahead and hooked it into the kernel Makefile logic.  The way I
>> have it here, doing 'make scripts' ends up compiling 'mdp', after which
>> you must
>> 	cd scripts/selinux
>> 	sh install_policy.sh
>>
>> That isn't as nice as being able to do
>> 	make selinux_install
>> the way David had it, but it avoids mucking with the top-level
>> Makefile.  Which is preferred?
>>
>> In any case, this seems like a good thing to have in the kernel
>> tree, to facilitate simple selinux boot tests.
>>
>> Following is David's original patch intro (preserved especially
>> bc it has stats on the generated policies):
>>
>> ======================================================================
>> For those interested in the changes there were only two significant
>> changes. The first is that the iteration through the list of classes
>> used NULL as a sentinel value. The problem with this is that the
>> class_to_string array actually has NULL entries in its table as place
>> holders for the user space object classes.
>>
>> The second change was that it would seem at some point the initial sids
>> table was NULL terminated. This is no longer the case so that iteration
>> has to be done on array length instead of looking for NULL.
>>
>> Some statistics on the policy that it generates:
>>
>> The policy consists of 523 lines which contain no blank lines. Of those
>> 523 lines 453 of them are class, permission, and initial sid
>> definitions. These lines are usually little to no concern to the policy
>> developer since they will not be adding object classes or permissions.
>> Of the remaining 70 lines there is one type, one role, and one user
>> statement. The remaining lines are broken into three portions. The first
>> group are TE allow rules which make up 29 of the remaining lines, the
>> second is assignment of labels to the initial sids which consist of 27
>> lines, and file system labeling statements which are the remaining 11.
>>
>> In addition to the policy.conf generated there is a single file_contexts
>> file containing two lines which labels the entire system with base_t.
>>
>> This policy generates a policy.23 binary that is 7920 bytes.
>> ======================================================================
>> (then a few versions later...):
>> ======================================================================
>> The new policy is 587 lines (stripped of blank lines) with 476 of those
>> lines being the boilerplate that I mentioned last time. The remaining
>> 111 lines have the 3 lines for type, user, and role, 70 lines for the
>> allow rules (one for each object class including user space object
>> classes), 27 lines to assign types to the initial sids, and 11 lines for
>> file system labeling. The policy binary is 9194 bytes.
>> ======================================================================
>>
>> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> [Snip...]
> 
> I'm not sure if I have to sign off on this but just in case.
> 
> Signed-off-by: David Quigley <dpquigl@tycho.nsa.gov>
> 
> Dave
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
How easy would it be to go from this dummy policy to a policy that
confined only one application?  IE If I wanted to pull in the bind
policy, what would be needed.

This is a question that often comes up.  I don't want anything confined
except this one app?

I would figure syslog would be a problem right off, others?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
