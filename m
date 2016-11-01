Subject: Re: Discussion on setting the /proc/self/oom_score_adj file label.
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
References: <649de230-05ee-5b12-70dd-ac4f64cf9020@redhat.com>
 <4c7501e1-8645-0559-ad1e-358452086c43@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <7ac0844f-6b1f-18f5-7b14-3b806b9aa205@redhat.com>
Date: Tue, 1 Nov 2016 08:33:09 -0400
MIME-Version: 1.0
In-Reply-To: <4c7501e1-8645-0559-ad1e-358452086c43@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 11/01/2016 08:31 AM, Stephen Smalley wrote:
> On 11/01/2016 07:50 AM, Daniel J Walsh wrote:
>> I wrote a blog http://danwalsh.livejournal.com/75282.html which talks
>> about chrome sandbox and its attempt to change its parents oom_score_adj
>> value.  Which is labeled unconfined_t, the question has come up on
>> Twitter to be able to change the label on just this object.
>>
>> I think we discussed this before, but how difficult would it be to
>> change individual file labels under /proc/self/?
> Technically feasible, already on the kernel todo list,
> https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo
>
> However, I agree with Dominick here - the parent shouldn't run in
> unconfined_t in the first place.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
Sure, We could label chrome to run as some other label,but then you end
up in multiple unconfined domains
running, or end up attempting to confine chrome, which is a loosing
battle, in the general use case.
