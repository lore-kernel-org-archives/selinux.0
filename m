Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9BCTsRv027954
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2010 08:29:54 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o9BCTrDd009494
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2010 12:29:53 GMT
Message-ID: <4CB30341.3000200@tresys.com>
Date: Mon, 11 Oct 2010 08:29:53 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Subject: Re: [refpolicy] ERROR 'syntax error' at token ':c' on line 42:
References: <AANLkTimEezzq9XqJSpO3B4LY3NWQLiD2CN-0Z4Wd764U@mail.gmail.com>
In-Reply-To: <AANLkTimEezzq9XqJSpO3B4LY3NWQLiD2CN-0Z4Wd764U@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/10/10 02:17, Justin Mattock wrote:
> This is also hitting when building a module for the policy(below)
> basically start the system(opensuse 11.4) then do:
>
> dmesg>  dmesg
> audit2allow -i dmesg -M Zonemod
> compilation failed:
> Zonemod.te:42:ERROR 'syntax error' at token ':c' on line 42:
> allow auditd_t device_t:chr_file { read write open };
> #============= auditd_t ==============
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> /usr/bin/checkmodule:  loading policy configuration from Zonemod.te

What are the lines above that one that supposedly has an error?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
