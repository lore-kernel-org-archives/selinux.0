Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2TGuXDo006774
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 11:56:33 -0500 (EST)
Received: from mout.perfora.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2TGrfcp026306
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 16:55:33 GMT
Subject: Selinux checkpolicy parse error
From: Christopher Warner <chris@servertogo.com>
To: selinux@tycho.nsa.gov, cwarner@kernelcode.com
Content-Type: text/plain
Date: Tue, 29 Mar 2005 07:10:32 -0500
Message-Id: <1112098232.21770.70.camel@jasmine>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey guys/gals,

I'm applying Selinux (1.22) to a native distro built inhouse for the
company that I work for.

I've lovingly applied the required patches to the relevant programs that
require Selinux (from fedora without subsequent fedora dependency where
found, so it works with inhouse distro). Now I am trying to configure
the default policy and am not sure as to why it's not working. It seems
that there is something wrong with checkpolicy and parsing. I've tried
to search the mailing list but the interface via nsa.gov is kludgy and
ineffective for searching the archive. There seems to have been a
resolution regarding checkpolicy but the communication between the two
parties was private or missing from the list. Should there be a better
interface to previous archived messaging I'd like to know.

Here is the respective error:

 -bash-3.00# make
/usr/bin/checkpolicy  -o policy.19 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
types/file.te:92:ERROR 'syntax error' at token ':' on line 3329:
type shadow_t, file_type, secure_file_type;
allow auth shadow_t: file { getattr read };
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.19] Error 1

The line from policy.conf:
allow auth shadow_t : file { getattr read };

Syntax seems to be correct; I'm currently using flex version 2.5.4.
Kernel version 2.6.11.5, i'm patched up with everything from cvs.

Essentially I would just like to create a simple policy to get things
working. I'd try to start with something simple but the way the policy
is intertwined with context's etc would require me to basically start
rewriting from there and I'm not sufficiently experienced enough with
Selinux to do so yet. If there is no way to do so beyond that I am
willing to put the required effort and time in. However, I suspect there
is a more succinct and quicker way to get up and started.

Any guidance would be greatly appreciated.

Thanks,
Christopher Warner


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
