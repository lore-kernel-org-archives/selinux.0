Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4CG2Wtn012670
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2011 12:02:32 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4CG2VM8003349
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2011 16:02:31 GMT
Message-ID: <4DCC04E7.6050104@tresys.com>
Date: Thu, 12 May 2011 12:03:51 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I believe you will need this patch also to build reference policy.
References: <4DC003DF.3000909@redhat.com> <4DCA8187.2050505@tresys.com> <4DCB00EE.10607@redhat.com>
In-Reply-To: <4DCB00EE.10607@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/11/2011 05:34 PM, Daniel J Walsh wrote:
> On 05/11/2011 01:31 PM, Steve Lawrence wrote:
>> On 05/03/2011 09:32 AM, Daniel J Walsh wrote:
>>> Otherwise you end up with a conflict.
> 
>>> checkpolicy-filename.patchdiff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
>>> index 427c189..1331c04 100644
>>> --- a/checkpolicy/policy_scan.l
>>> +++ b/checkpolicy/policy_scan.l
>>> @@ -219,10 +219,11 @@ PERMISSIVE			{ return(PERMISSIVE); }
>>>  {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
>>>  {digit}+|0x{hexval}+            { return(NUMBER); }
>>>  {alnum}*                        { return(FILENAME); }
>>> +\.({alnum}|[_\.\-])*	        { return(FILENAME); }
>>>  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
>>>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>>>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
>>> -{alnum}+([_\.]|{alnum})+      { return(FILENAME); }
>>> +{letter}+([-_\.]|{alnum})+      { return(FILENAME); }
>>>  ([_\.]){alnum}+                 { return(FILENAME); }
>>>  #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
>>>  #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }
> 
>> Can't these be merged? I know I merged something similar earlier, but is
>> it really necessary to have 3 regexs for filename?
> 
>> \.?({alnum}|[_\.\-])*	        { return(FILENAME); }
> 
>> Or am I missing something?
> I believe that if you have
> 
> -{alnum}+([_\.]|{alnum})+      { return(FILENAME); }
> 
> This conflicts with NUMBER. And causes other parts of the regular
> expression to fail.
> 

Yeah, I think you're right, but there are still some problems with the
regex. For example, you can't have a file name that starts with an
underscore followed by anything other than an alphanumeric (e.g.
_foo_bar and _foo.txt are syntax errors). This also won't match file
names containing an underscore that begin with a number (e.g. 9foo_bar).

So, I'm wondering if we really gain much from having a separate FILENAME
identifier? Without it, I guess you could have filenames that aren't
valid filenames (e.g. "foo/bar"), but I don't know if that's worth the
complexity. If the only limits are things like can't have forward
slashes, can't equal '.' or '..',  perhaps it would be easier to move
valid file name checking into libsepol?

Is there any other value to the FILENAME identifier?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
