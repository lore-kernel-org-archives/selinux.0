Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4BLYhJO023402
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 17:34:43 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4BLYgtY026961
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 21:34:42 GMT
Message-ID: <4DCB00EE.10607@redhat.com>
Date: Wed, 11 May 2011 22:34:38 +0100
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I believe you will need this patch also to build reference policy.
References: <4DC003DF.3000909@redhat.com> <4DCA8187.2050505@tresys.com>
In-Reply-To: <4DCA8187.2050505@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/11/2011 01:31 PM, Steve Lawrence wrote:
> On 05/03/2011 09:32 AM, Daniel J Walsh wrote:
>> Otherwise you end up with a conflict.
> 
>> checkpolicy-filename.patchdiff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
>> index 427c189..1331c04 100644
>> --- a/checkpolicy/policy_scan.l
>> +++ b/checkpolicy/policy_scan.l
>> @@ -219,10 +219,11 @@ PERMISSIVE			{ return(PERMISSIVE); }
>>  {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
>>  {digit}+|0x{hexval}+            { return(NUMBER); }
>>  {alnum}*                        { return(FILENAME); }
>> +\.({alnum}|[_\.\-])*	        { return(FILENAME); }
>>  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
>>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
>> -{alnum}+([_\.]|{alnum})+      { return(FILENAME); }
>> +{letter}+([-_\.]|{alnum})+      { return(FILENAME); }
>>  ([_\.]){alnum}+                 { return(FILENAME); }
>>  #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
>>  #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }
> 
> Can't these be merged? I know I merged something similar earlier, but is
> it really necessary to have 3 regexs for filename?
> 
> \.?({alnum}|[_\.\-])*	        { return(FILENAME); }
> 
> Or am I missing something?
I believe that if you have

- -{alnum}+([_\.]|{alnum})+      { return(FILENAME); }

This conflicts with NUMBER. And causes other parts of the regular
expression to fail.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3LAO4ACgkQrlYvE4MpobNN8gCgrFE7ID7IrlM/TbxHVjQ5N0e0
R98AoL7Zx20onPIOn+pUb4XtR9UNPiJR
=o5Aj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
