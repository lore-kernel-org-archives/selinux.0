Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HC8bWt008606
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 08:08:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9HC8amR011354
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 12:08:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9HC8Zjp011350 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 12:08:36 GMT
Subject: Re: process context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: kamal <kamalnee@iitk.ac.in>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <3F8FC612.2090105@iitk.ac.in>
References: <3F8EEA16.8090908@ipen.br>
	 <200310171327.31980.russell@coker.com.au>  <3F8FC612.2090105@iitk.ac.in>
Content-Type: text/plain
Message-Id: <1066392503.31764.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 17 Oct 2003 08:08:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-17 at 06:36, kamal wrote:
> But why does this happen? I also had the same problem, and because getty 
> process is not labeled properly, login fails to get default context.
> 
> Output of "ls --context /sbin/init" is:
> -rwxr-xr-x  root     root     system_u:object_r:init_exec_t    /sbin/init

As with the other poster, your problem may be that you aren't loading
the policy prior to executing /sbin/init, or you are loading the policy
via /sbin/init but failing to re-execute it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
