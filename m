Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA19303
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 08:38:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA24192
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 12:36:50 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id MAA24188 for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 12:36:48 GMT
Message-ID: <3D2987B0.9010703@evoworks.evoserve.com>
Date: Mon, 08 Jul 2002 20:38:08 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [patch] Re: problem with "-" in libraries
References: <Pine.GSO.4.33.0207080820340.19100-200000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sat, 6 Jul 2002, Debian User wrote:
>
>  
>
>>Im developing a policy for a cramfs based selinux system. I cant specify the
>>contexts for libraries with a "-" in the names like "libpthread-0.9.11.so".
>>Checkpolicy does not accept such names int genfs_contexts. I am trying to work
>>around this by recompiling everything using modified library names. Can the
>>checkpolicy compiler be modified to accept this names?
>>    
>>
>
>The attached patch fixes the checkpolicy scanner to accept "-" in path
>tokens.  This patch has also been committed to the sourceforge CVS tree.
>  
>
Will apply thanks. I discovered that genfs_context  are used as 
prefixes. My policy worked somewhat by specifying only the names before 
the dash. I was able to make my system work but this is much better.

>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>  
>
>------------------------------------------------------------------------
>
>Index: module/checkpolicy/policy_scan.l
>===================================================================
>RCS file: /cvsroot/selinux/nsa/selinux/module/checkpolicy/policy_scan.l,v
>retrieving revision 1.5
>diff -u -r1.5 policy_scan.l
>--- module/checkpolicy/policy_scan.l	3 Jul 2002 20:39:47 -0000	1.5
>+++ module/checkpolicy/policy_scan.l	8 Jul 2002 12:17:16 -0000
>@@ -130,7 +130,7 @@
> T1				{ return(T1); }
> t2 |
> T2				{ return(T2); }
>-"/"({letter}|{digit}|_|"."|"/")*	{ return(PATH); }
>+"/"({letter}|{digit}|_|"."|"-"|"/")*	{ return(PATH); }
> {letter}({letter}|{digit}|_)*	{ return(IDENTIFIER); }
> {digit}{digit}*                 { return(NUMBER); }
> #[^\n]*                         { /* delete comments */ }
>  
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
