Date: Tue, 14 Oct 2008 23:18:03 +0000 (GMT)
From: korkishko Tymur <k.tymur@samsung.com>
Subject: Re: Re: Genfscon 'dash' issue
To: Joshua Brindle <method@manicmethod.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, korkishko Tymur <k.tymur@samsung.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Reply-to: k.tymur@samsung.com
Message-id: <31220816.201881224026282823.JavaMail.weblogic@epml03>
MIME-version: 1.0
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you help with that bug.

Also I would like to note that current version of apol tool from Tresys does not fully support policy compiled with the patch to fix dash issue.
If one reads  text-based policy.conf by apol tool, it produces syntax error and an error box saying that the file is not a correct policy.
But apol tool reads nice that policy in compiled form (binary).

So, it would be nice if Tresys developers could fix that issue in apol tool.

---
Tymur Korkishko
Samsung Electronics
 
 

------- Original Message -------
Sender : Joshua Brindle<method@manicmethod.com>
Date   : Oct 15, 2008 04:09 (GMT+09:00)
Title  : Re: Genfscon &#39;dash&#39; issue

Stephen Smalley wrote:
> On Tue, 2008-10-14 at 02:00 +0000, korkishko Tymur wrote:
>   
>> I have checked policy_parse.y. It has following rule for genfscon:
>>  
>> genfs_context_def    : GENFSCON identifier path &#39;-&#39; identifier security_context_def
>>     {if (define_genfs_context(1)) return -1;}
>>     | GENFSCON identifier path &#39;-&#39; &#39;-&#39; {insert_id("-", 0);} security_context_def
>>     {if (define_genfs_context(1)) return -1;}
>>      | GENFSCON identifier path security_context_def
>>     {if (define_genfs_context(0)) return -1;} 
>>
>> The rule for path definition (in policy_scan.l) has already included &#39;-&#39; (dash):
>>
>> "/"({alnum}|[_.-/])*            { return(PATH); } 
>>
>> In my understanding (maybe wrong), path is parsed first (and path might include &#39;-&#39;) and only then separate &#39;-&#39; is parsed. 
>> But it still produces an error if path definition is correct and includes &#39;-&#39;.
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
>  POLICYCAP            { return(POLICYCAP); }
>  permissive |
>  PERMISSIVE            { return(PERMISSIVE); }
> -"/"({alnum}|[_.-/])*            { return(PATH); }
> -{letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*    { return(IDENTIFIER); }
> +"/"({alnum}|[_\.\-/])*            { return(PATH); }
> +{letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*    { return(IDENTIFIER); }
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

 
 
 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
