Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA11177
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 03:09:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA11091
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 08:09:03 GMT
Received: from hotmail.com (law2-f71.hotmail.com [216.32.181.71])
	by jazzswing.ncsc.mil  with ESMTP id IAA11087
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 08:09:03 GMT
From: "Red Phoenix" <redph0enix@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: Linux auditing subsystem
Date: Fri, 09 Nov 2001 20:09:10 +1200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F71TfSr0fVwcdZ0001f7c8@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys,

You've probably already spotted it on one or more of the linux news sites, 
but the team at InterSect Alliance have recently released a tool called 
SNARE. SNARE (System iNtrusion Analysis and Reporting Environment) is an 
open source (GPL) kernel-module auditing system that has a core goal of 
reducing the "cost of entry" for host-based intrusion detection and system 
auditing on Linux. We are trying to make system event logs less of a chore, 
and more of a resource. We've mentioned the possibility of developing such a 
facility previously on the SELinux mailing list, and we're glad to say that 
we've finally completed the tool.

One of the key components that we believe has been missing from the Linux 
operating system, is a comprehensive auditing and event-logging facility. 
The lack of such security functionality, and that fact that it exists in 
commercial operating system rivals such as Windows NT and Solaris, has been 
reported as a signficant reason why organisations and government departments 
have been reticent in taking up Linux, despite the significant cost savings 
that would otherwise have resulted from areas such as licencing and 
management.

Hopefully, SNARE will go a little way to removing such reluctance, and may 
encourage the migration to C2-style accreditation for the operating system.

The fact that SNARE is built around a dynamically loadable kernel module, 
means that there is no binary kernel bloat, and it can be treated just like 
a hardware driver; loaded optionally by the user if they want to take 
advantage of the included features.

With the new focus on security worldwide, supporting government efforts 
towards more targetted audit analysis by incorporating a core auditing 
facility into SELinux might be considered advantageous.

Summary information on SNARE is available for those who are interested -
http://www.intersectalliance.com/news/Snare_Press_Release.html.

More detailed information, including documentation is available from the 
SNARE project page -
http://www.intersectalliance.com/projects/Snare/index.html.

Should you be interested in more information, please feel free to drop us an 
email. This hotmail address is checked on a moderately regular basis. More 
frequent checks are made on the email address specified at the web site 
contact page.

Regards,

Leigh.
--
Leigh Purdie, Director - InterSect Alliance Pty Ltd
http://www.intersectalliance.com/


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
