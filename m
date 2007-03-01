Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21EbulI001060
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 09:37:56 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l21EdEP7022510
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:39:18 GMT
Subject: Re: Add MATLAB policy to run as a java_exec_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@localhost.localdomain
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200702261950.l1QJocI1031866@localhost.localdomain>
References: <200702261950.l1QJocI1031866@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 09:39:37 -0500
Message-Id: <1172759977.11157.86.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:50 -0500, dwalsh@localhost.localdomain wrote:
> ===File /tmp/patches/nsaserefpolicy_policy_modules_apps_java.fc===
> --- nsaserefpolicy/policy/modules/apps/java.fc	2007-01-25 08:13:58.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/apps/java.fc	2007-02-26 11:04:22.000000000 -0500
> @@ -18,3 +18,8 @@
>  /usr/bin/grmic  	--	gen_context(system_u:object_r:java_exec_t,s0)
>  /usr/bin/grmiregistry  	--	gen_context(system_u:object_r:java_exec_t,s0)
>  /usr/bin/jv-convert  	--	gen_context(system_u:object_r:java_exec_t,s0)
> +# MATLAB Policy
> +/usr/matlab/bin/(.*/)?MATLAB.	--	gen_context(system_u:object_r:java_exec_t,s0)
> +/usr/local/matlab/bin/(.*/)?MATLAB.	--	gen_context(system_u:object_r:java_exec_t,s0)
> +/opt/matlab/bin/(.*/)?MATLAB.	--	gen_context(system_u:object_r:java_exec_t,s0)
> +/opt/local/matlab/bin/(.*/)?MATLAB.	--	gen_context(system_u:object_r:java_exec_t,s0)
> ============================================================

Merged with a little reorganization.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
