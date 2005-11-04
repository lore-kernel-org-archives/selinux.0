Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4DU9MA025806
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 08:30:11 -0500 (EST)
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to use
	libsemanage
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <436AF7BC.5000705@cornell.edu>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 08:20:55 -0500
Message-Id: <1131110455.23420.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 00:55 -0500, Ivan Gyurdiev wrote:
> Note1:  this does not yet work, because now load_policy tries to 
> sabotage my boolean load (by setting preservebools to 1 by default, and 
> not loading anything). What should I do about that? Should anything be 
> done at all, or should we respect the user load_policy flags in 
> /etc/selinux.conf? (which right now I see are undocumented...)

I'm not sure I understand the question.  load_policy is supposed to
preserve current boolean settings across a reload so that a transient
boolean change isn't affected by a policy update.  Examples of transient
boolean changes might include setting of booleans from cron jobs for
time-of-day policies, manual setting of booleans without -P by an admin
to reflect some external event, setting of booleans by an IDS in
response to some detected attack, etc.  That behavior isn't supposed to
change even with the introduction of libsemanage and the use of
SETLOCALDEFS=0 (which only turns off setting the booleans from the
booleans* files upon initial policy load, as they are now set in the
generated kernel binary policy file by libsemanage).

> Note2: if I go and force libsemanage to pass -b flag, it works just 
> fine, but takes forever (10sec) to complete. It's not my fault, the 
> module expand function is just really really slow.

echo "expand-check = 0" >> /etc/selinux/semanage.conf, as I noted
earlier, for development/debugging purposes.  We may want to allow
setting the expand check state on a per-handle basis to disable for
certain kinds of transactions, just as one can presently disable
immediate reload for certain transactions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
