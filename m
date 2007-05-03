Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43DcYIT021307
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 09:38:34 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l43DcYQe002660
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 13:38:34 GMT
Subject: Re: Additional textrel_shlib_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4627A425.7030800@redhat.com>
References: <4627A425.7030800@redhat.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 09:38:10 -0400
Message-Id: <1178199490.445.52.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 13:17 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/system/libraries.fc   2007-04-10 16:13:39.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/system/libraries.fc       2007-04-17 10:00:22.000000000 -0400
> @@ -82,6 +81,7 @@
>  /opt/netbeans(.*/)?jdk.*/linux/.+\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /opt/cxoffice/lib/wine/.+\.so          --      gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /opt/ibm/java2-ppc64-50/jre/bin/.+\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/opt/f-secure/fspms/libexec/librapi.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
>  ifdef(`distro_gentoo',`
>  # despite the extensions, they are actually libs
> @@ -132,6 +132,7 @@
>  /usr/(.*/)?nvidia/.+\.so(\..*)?                --      gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
>  /usr/lib/win32/.*                      --      gen_context(system_u:object_r:shlib_t,s0)
> +/usr/lib/transgaming_cedega/gddb_parser.so --  gen_context(system_u:object_r:shlib_t,s0)
>  
>  /usr/(.*/)?lib(64)?(/.*)?/nvidia/.+\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib(64)?(/.*)?/nvidia/.+\.so(\..*)? --    gen_context(system_u:object_r:textrel_shlib_t,s0)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
