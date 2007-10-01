Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l91Ccmjw013065
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 08:38:48 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l91Cclwd017339
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 12:38:47 GMT
Subject: Re: m4 help
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD49A299@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD49A299@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Mon, 01 Oct 2007 12:36:38 +0000
Message-Id: <1191242198.4282.39.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-28 at 17:52 -0700, Clarkson, Mike R (US SSA) wrote:
> I need help with m4 macros.
> 
> I'm using m4 macros in my file context files to define common paths, so
> that I only have to define them once. Here's an example of what I'm
> doing:
> 
> define(`SDK_HOME',`/opt/oracle/product/AccessServerSDK')
> SDK_HOME/oblix/lib/lib.+\.so.* --
> gen_context(system_u:object_r:shlib_t,s0)
> 
> The above statement works fine. But the below statement does NOT:
> 
> SDK_HOME(/.*)?  gen_context(system_u:object_r:oracle_sp_file_t,s0)
> 
> This expands to:
> /opt/oracle/product/AccessServerSDK?
> gen_context(system_u:object_r:oracle_sp_file_t,s0)
> 
> rather than
> 
> /opt/oracle/product/AccessServerSDK(/.*)?
> gen_context(system_u:object_r:oracle_sp_file_t,s0)
> 
> How can I get m4 to handle this case properly?

To get this to not treat the () as a parameter list for the macro
invocation, you have to insert an empty string:

SDK_HOME`'(/.*)? gen_context(system_u:object_r:oracle_sp_file_t,s0)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
