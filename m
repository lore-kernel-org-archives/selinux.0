Message-Id: <200211072015.PAA07352@moss-shockers.ncsc.mil>
Date: Thu, 7 Nov 2002 15:15:01 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: default_context file
To: SELinux@tycho.nsa.gov, carstengrohmann@gmx.de
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


 
> I've don't understand the new default_context file. Could anybody explain 
> it? I understand the entries for login and ssh, but the line for the crond 
> I to stupid.
> The crond can use both partial context (user_r:user_crond_t and 
> system_r:system_crond_t) but I don't unterstand the selection mechanism. 

The daemons (crond, sshd) and login ask the in-kernel security server to
compute the set of legal SIDs for the user that can be reached from their
own SID, and then uses the optional /etc/security/default_contexts and 
$HOME/.default_contexts files to determine a default when multiple SIDs
are possible.  crond is a little different than sshd and login since it
also has a special case for system cron jobs.  A partial context in
a default_contexts file is ignored if it doesn't exist in the set of
legal SIDs returned by the security server.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
