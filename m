Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4BCTpar025070
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 08:29:51 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4BCTosM004205
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 12:29:50 GMT
Message-ID: <4DCA8187.2050505@tresys.com>
Date: Wed, 11 May 2011 08:31:03 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I believe you will need this patch also to build reference policy.
References: <4DC003DF.3000909@redhat.com>
In-Reply-To: <4DC003DF.3000909@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/03/2011 09:32 AM, Daniel J Walsh wrote:
> Otherwise you end up with a conflict.

> checkpolicy-filename.patchdiff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 427c189..1331c04 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -219,10 +219,11 @@ PERMISSIVE			{ return(PERMISSIVE); }
>  {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
>  {digit}+|0x{hexval}+            { return(NUMBER); }
>  {alnum}*                        { return(FILENAME); }
> +\.({alnum}|[_\.\-])*	        { return(FILENAME); }
>  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> -{alnum}+([_\.]|{alnum})+      { return(FILENAME); }
> +{letter}+([-_\.]|{alnum})+      { return(FILENAME); }
>  ([_\.]){alnum}+                 { return(FILENAME); }
>  #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
>  #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }

Can't these be merged? I know I merged something similar earlier, but is
it really necessary to have 3 regexs for filename?

\.?({alnum}|[_\.\-])*	        { return(FILENAME); }

Or am I missing something?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
