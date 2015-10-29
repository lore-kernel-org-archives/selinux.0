Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9T2KNGO017452
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 22:20:23 -0400
Subject: Re: Macro help
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
References: <56314B29.7020007@yahoo.com> <5631621A.5070904@tresys.com>
From: Dan <dtdevore64@yahoo.com>
Message-ID: <5631825E.7040807@yahoo.com>
Date: Wed, 28 Oct 2015 22:20:14 -0400
MIME-Version: 1.0
In-Reply-To: <5631621A.5070904@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Yeah you were right, I can't believe I missed that simple mistake
because I had another macro that had the parenthesis correct to look at
but must have missed it. Thanks a lot man.

On 10/28/2015 08:02 PM, Steve Lawrence wrote:
> On 10/28/2015 06:24 PM, Dan wrote:
>> Hello everyone I have hit another bump with the cil macros. I am trying
>> to make a macro that covers the domain_type and domain_type_entry file
>> interfaces equivalent in Cil with macros that will confine a simple
>> shell script( and if anyone has any input to what I can do better or if
>> I am going about this in the wrong way please say so), but it says it
>> doesn't understand my "call usersubject_domain_type" line and won't
>> build for some reason. Here is what I have so far. Any help is much
>> appreciated, thanks.
>>
>>
>> (macro usersubject_domain_type ((type ARG1)) (type ARG2))
>>         (typeattributeset domain ARG2)
>>         (typeattributeset exec_type ARG1)
>>         (typeattributeset corenet_unlabeled_type ARG2)
>>         (typeattributeset entry_type ARG1)
>>         (typeattributeset file_type ARG1)
>>         (typeattributeset non_security_file_type ARG1)
>>         (typeattributeset non_auth_file_type ARG1)
>>
>>
>> (call usersubject_domain_type (myshell_exec_t myshell_t))
> 
> The parenthesis aren't quite correct in the macro parameter list. You're
> closing the parameter list too early, so the macro defines only a single
> parameter, ARG1, and the body of the macro only contains the definition
> of a type called ARG2. Re-indenting what you have shows it more clearly:
> 
>   (macro usersubject_domain_type ((type ARG1))
>     (type ARG2))
> 
>   (typeattributeset domain ARG2)
>   (typeattributeset exec_type ARG1)
>   (typeattributeset corenet_unlabeled_type ARG2)
>   (typeattributeset entry_type ARG1)
>   (typeattributeset file_type ARG1)
>   (typeattributeset non_security_file_type ARG1)
>   (typeattributeset non_auth_file_type ARG1)
> 
>   (call usersubject_domain_type (myshell_exec_t myshell_t))
> 
> So it's probably complaining that the macro requires one argument, but
> you're passing in two. To fix this, you just need to move a parenthesis
> around, e.g.:
> 
>   (macro usersubject_domain_type ((type ARG1) (type ARG2))
>     (typeattributeset domain ARG2)
>     (typeattributeset exec_type ARG1)
>     (typeattributeset corenet_unlabeled_type ARG2)
>     (typeattributeset entry_type ARG1)
>     (typeattributeset file_type ARG1)
>     (typeattributeset non_security_file_type ARG1)
>     (typeattributeset non_auth_file_type ARG1)) ;notice the extra paren
> here closing the maro
> 
>   (call usersubject_domain_type (myshell_exec_t myshell_t))
> 
> - Steve
> 
