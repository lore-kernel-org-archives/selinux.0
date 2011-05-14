Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4E1Lwgb017325
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2011 21:22:02 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4E1LvOY012024
	for <selinux@tycho.nsa.gov>; Sat, 14 May 2011 01:21:57 GMT
Message-ID: <4DCDD92E.20506@redhat.com>
Date: Sat, 14 May 2011 03:21:50 +0200
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I believe you will need this patch also to build reference policy.
References: <4DC003DF.3000909@redhat.com> <4DCA8187.2050505@tresys.com> <4DCB00EE.10607@redhat.com> <4DCC04E7.6050104@tresys.com> <4DCC066A.7020702@redhat.com> <4DCD6BF1.2020605@tresys.com>
In-Reply-To: <4DCD6BF1.2020605@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/13/2011 07:35 PM, Steve Lawrence wrote:
> On 05/12/2011 12:10 PM, Daniel J Walsh wrote:
>> On 05/12/2011 06:03 PM, Steve Lawrence wrote:
>>> On 05/11/2011 05:34 PM, Daniel J Walsh wrote:
>>>> On 05/11/2011 01:31 PM, Steve Lawrence wrote:
>>>>> On 05/03/2011 09:32 AM, Daniel J Walsh wrote:
>>>>>> Otherwise you end up with a conflict.
>>>>
>>>>>> checkpolicy-filename.patchdiff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
>>>>>> index 427c189..1331c04 100644
>>>>>> --- a/checkpolicy/policy_scan.l
>>>>>> +++ b/checkpolicy/policy_scan.l
>>>>>> @@ -219,10 +219,11 @@ PERMISSIVE			{ return(PERMISSIVE); }
>>>>>>  {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
>>>>>>  {digit}+|0x{hexval}+            { return(NUMBER); }
>>>>>>  {alnum}*                        { return(FILENAME); }
>>>>>> +\.({alnum}|[_\.\-])*	        { return(FILENAME); }
>>>>>>  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
>>>>>>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>>>>>>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
>>>>>> -{alnum}+([_\.]|{alnum})+      { return(FILENAME); }
>>>>>> +{letter}+([-_\.]|{alnum})+      { return(FILENAME); }
>>>>>>  ([_\.]){alnum}+                 { return(FILENAME); }
>>>>>>  #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
>>>>>>  #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }
>>>>
>>>>> Can't these be merged? I know I merged something similar earlier, but is
>>>>> it really necessary to have 3 regexs for filename?
>>>>
>>>>> \.?({alnum}|[_\.\-])*	        { return(FILENAME); }
>>>>
>>>>> Or am I missing something?
>>>> I believe that if you have
>>>>
>>>> -{alnum}+([_\.]|{alnum})+      { return(FILENAME); }
>>>>
>>>> This conflicts with NUMBER. And causes other parts of the regular
>>>> expression to fail.
>>>>
>>
>>> Yeah, I think you're right, but there are still some problems with the
>>> regex. For example, you can't have a file name that starts with an
>>> underscore followed by anything other than an alphanumeric (e.g.
>>> _foo_bar and _foo.txt are syntax errors). This also won't match file
>>> names containing an underscore that begin with a number (e.g. 9foo_bar).
>>
>>> So, I'm wondering if we really gain much from having a separate FILENAME
>>> identifier? Without it, I guess you could have filenames that aren't
>>> valid filenames (e.g. "foo/bar"), but I don't know if that's worth the
>>> complexity. If the only limits are things like can't have forward
>>> slashes, can't equal '.' or '..',  perhaps it would be easier to move
>>> valid file name checking into libsepol?
>>
>>> Is there any other value to the FILENAME identifier?
>>
>>
>> Well without these changes files that begin with . like .ssh were not
>> accepted.   If you can generate a way so any blob of characters could be
>> treated as a file, then I am fine with it.
>>
>> We need to say
>>
>> 000  Is a filename
>> .ssh
>> device-mapper
>>
>> I have attached the name transition rules that we have added to F16
> 
> How about changing the filename_trans syntax a bit, and wrap the file
> name in quotes, e.g.
> 
>     type_transition foo_t bar_t:file baz_t "filename";
> 
> This way there can be a single simple filename regex (nothing else is
> wrapped in quotes), with a little magic to strip off the quotes.
> 
> With d4c230386653db reverted, the below patch implements that.
> 
> I'm hesitant to make the quote change for genfscon and fs_use, though.
> What was the reasoning for changing those identifiers to filenames? Maybe
> something else would make more sense.
> 
> ---
> 
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 34e485d..d135e08 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -81,6 +81,7 @@ typedef int (* require_func_t)();
>  %type <require_func> require_decl_def
>  
>  %token PATH
> +%token FILENAME
>  %token CLONE
>  %token COMMON
>  %token CLASS
> @@ -341,7 +342,7 @@ cond_rule_def           : cond_transition_def
>  			| require_block
>  			{ $$ = NULL; }
>                          ;
> -cond_transition_def	: TYPE_TRANSITION names names ':' names identifier identifier ';'
> +cond_transition_def	: TYPE_TRANSITION names names ':' names identifier filename ';'
>                          { $$ = define_cond_filename_trans() ;
>                            if ($$ == COND_ERR) return -1;}
>  			| TYPE_TRANSITION names names ':' names identifier ';'
> @@ -380,7 +381,7 @@ cond_dontaudit_def	: DONTAUDIT names names ':' names names ';'
>                            if ($$ == COND_ERR) return -1; }
>  		        ;
>  			;
> -transition_def		: TYPE_TRANSITION  names names ':' names identifier identifier ';'
> +transition_def		: TYPE_TRANSITION  names names ':' names identifier filename ';'
>  			{if (define_filename_trans()) return -1; }
>  			| TYPE_TRANSITION names names ':' names identifier ';'
>                          {if (define_compute_type(AVRULE_TRANSITION)) return -1;}
> @@ -739,6 +740,9 @@ identifier		: IDENTIFIER
>  path     		: PATH
>  			{ if (insert_id(yytext,0)) return -1; }
>  			;
> +filename		: FILENAME
> +			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) return -1; }
> +			;
>  number			: NUMBER 
>  			{ $$ = strtoul(yytext,NULL,0); }
>  			;
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 48128a8..d727f1c 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -216,6 +216,7 @@ POLICYCAP			{ return(POLICYCAP); }
>  permissive |
>  PERMISSIVE			{ return(PERMISSIVE); }
>  "/"({alnum}|[_\.\-/])*	        { return(PATH); }
> +\"({alnum}|[_\.\-])+\"			{ return(FILENAME); }
>  {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
>  {digit}+|0x{hexval}+            { return(NUMBER); }
>  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
This is fine with me, we just have to coordinate an update in
selinux-policy for F16.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3N2S4ACgkQrlYvE4MpobORYwCgivJ/Tu1w9FGbloYp/UWV8rms
NOsAnAriR07ZVUeXhmkrE9ixZuuu/niY
=7i/o
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
