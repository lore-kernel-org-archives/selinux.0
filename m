Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o286hpmj017444
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 01:43:52 -0500
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o286hUD1007694
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 06:43:31 GMT
Message-ID: <4B949C72.4040104@ak.jp.nec.com>
Date: Mon, 08 Mar 2010 15:42:58 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Roys <joshua.roys@gtri.gatech.edu>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] mod_selinux: setcon earlier
References: <4B917BCF.7060200@gtri.gatech.edu>
In-Reply-To: <4B917BCF.7060200@gtri.gatech.edu>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/03/06 6:46), Joshua Roys wrote:
> Hello,
> 
> I am wondering if the attached patch creates the actual intended 
> behavior? Specifically, at which point httpd calls setcon() when the 
> selinuxServerDomain option is set.
> 
> The current code ends up calling setcon after sockets have been opened, 
> at least if the prefork mpm is in use. Here's the current path: apache 
> calls these hooks in this order: pre_config, check_config, open_logs, 
> post_config. The prefork mpm opens the listening sockets in open_logs, 
> and mod_selinux does setcon() in post_config. However, I noticed that 
> the selinuxServerDomain option has the EXEC_ON_READ option set... and I 
> noticed issues with labeled networking having the setcon() called after 
> the listening sockets are opened.

Hmm. The purpose of selinuxServerDomain allows to drop unnecessary
categories on the starting up time, although mod_selinux.pp set it
to translate into 's0 - mcs_systemhigh'. So, the listener sockets
also should be created in the configured domain.
It seems to me what you pointed out is fair enough.

However, I cannot agree to change security context of the server
which it parses the configuration file, because we can call setcon()
in the open_logs hook earlier than listener sockets are created using
APR_HOOK_FIRST, not APR_HOOK_MIDDLE.

Thanks,

> The attached patch deletes (well, in this version just comments out...) 
> the mod_selinux post_config hook, and calls the routine directly from 
> the set_server_domain option-processing hook. This, because of the 
> EXEC_ON_READ option, is executed immediately upon finding a 
> selinuxServerDomain option in a httpd config file. Thus, setcon() is 
> called before sockets are opened.
> 
> Josh

-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
