Message-ID: <48F4EE77.3070602@manicmethod.com>
Date: Tue, 14 Oct 2008 15:09:43 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: k.tymur@samsung.com, "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Genfscon 'dash' issue
References: <18936577.156001223949655112.JavaMail.weblogic@epml17> <1223996244.5193.50.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1223996244.5193.50.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-10-14 at 02:00 +0000, korkishko Tymur wrote:
>   
>> I have checked policy_parse.y. It has following rule for genfscon:
>>  
>> genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
>> 	{if (define_genfs_context(1)) return -1;}
>> 	| GENFSCON identifier path '-' '-' {insert_id("-", 0);} security_context_def
>> 	{if (define_genfs_context(1)) return -1;}
>> 	 | GENFSCON identifier path security_context_def
>> 	{if (define_genfs_context(0)) return -1;} 
>>
>> The rule for path definition (in policy_scan.l) has already included '-' (dash):
>>
>> "/"({alnum}|[_.-/])*	        { return(PATH); } 
>>
>> In my understanding (maybe wrong), path is parsed first (and path might include '-') and only then separate '-' is parsed. 
>> But it still produces an error if path definition is correct and includes '-'.
>>
>> Any ideas/patches how to fix grammar rules are welcomed.
>>     
>
> This looks like a bug in policy_scan.l - we are not escaping (via
> backslash) special characters in the pattern and thus the "-" (dash) is
> being interpreted rather than taken literally.  The same would seemingly
> apply for "." (dot), and would seem relevant not only to PATH but also
> for IDENTIFIER.  The patch below seems to fix this issue for me:
>
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 9bc6e10..b55c659 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -207,8 +207,8 @@ policycap |
>  POLICYCAP			{ return(POLICYCAP); }
>  permissive |
>  PERMISSIVE			{ return(PERMISSIVE); }
> -"/"({alnum}|[_.-/])*	        { return(PATH); }
> -{letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
> +"/"({alnum}|[_\.\-/])*	        { return(PATH); }
> +{letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
>  {digit}+                        { return(NUMBER); }
>  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>
>   


merged in checkpolicy-2.0.18


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
