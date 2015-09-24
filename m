Subject: Re: Cil Macros
To: Dan <dtdevore64@yahoo.com>, selinux@tycho.nsa.gov
References: <56037F3F.4050200@yahoo.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5603EAA2.2080805@tycho.nsa.gov>
Date: Thu, 24 Sep 2015 08:20:50 -0400
MIME-Version: 1.0
In-Reply-To: <56037F3F.4050200@yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/24/2015 12:42 AM, Dan wrote:
> Hello everyone, I've been trying to play around with macros with the CIL
> language and have come across some problems on how they work. I'm just trying to
> simple create a macro that will do a type transition with a process called
> mytest_t domain.
>
> Here is what I have so far:
>
>
>
>
> (macro mytest_t_domain_auto_trans ((ARG1))
>    (typeattributeset cil_gen_require application_domain_type)
>    (call domain_trans (ARG1))
>    (allow ARG1 mytest_t (process (exec read write getattr transition)))
> )
>

You are probably getting a message saying invalid syntax.
The macro definition needs to say what the argument is, like this:
(macro mytest_t_domain_auto_trans ((type ARG1))

We use (typeattributeset cil_gen_require SOME_TYPE) when converting pp files to 
cil to make optional blocks work when a type is required, but not used. I don't 
think that you need it here.

I hope that helps.

Jim

>
>
> ...but when I try to run it it obviously doesn't work. If anyone has any input
> on what I am doing wrong I'm all ears. Thanks.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
