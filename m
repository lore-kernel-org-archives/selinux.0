Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9HEZso7014760
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 10:35:54 -0400
Received: from mailhost.cdltd.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9HEYXpC020126
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 14:34:34 GMT
Received: from exch.cdltd.co.uk (fw.cdltd.co.uk [193.132.127.247])
	by mailhost.cdltd.co.uk (8.14.1/8.12.11) with ESMTP id m9HEWbMU007783
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 15:34:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Creating new types
Date: Fri, 17 Oct 2008 15:34:26 +0100
Message-ID: <DAE2574A7F44F44ABE07381C36213DFA05BC3349@exch.cdltd.co.uk>
From: "Paul Cocker" <paul.cocker@tntpost.co.uk>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Today is my first day of working with SELinux (so forgive any
terminology mixups), newly discovered after it blocked a disclaimer
script I was using in conjunction with altermime to attach text to
e-mail being processed by postfix.

Anyway, having been pointed at a very helpful HOWTO on the CentOS pages
I was able to work through the first few flagged issues. But now I've
run into one I want a different solution for than "add more permissions
to existing type".

One of the elements of the script is writing to /var/spool/filter, a
directory used for no other purpose. I believe it wishes to create
subfolders, something SELinux is not allowing under the CentOS 5.2 type
var_spool_t. I tried changing the type to postfix_spool_t, but this had
the same problem.

Rather than setup a module which grants permissions that postfix_spool_t
doesn't need, I'd like to setup a new type and assign it to this
directory. Problem is, I haven't been able to find documentation on how
to do this, so I'm hoping someone can point me in the right direction.

Paul Cocker




TNT Post is the trading name for TNT Post UK Ltd (company number: 04417047), TNT Post (Doordrop Media) Ltd (00613278), TNT Post Scotland Ltd (05695897), TNT Post North Ltd (05701709), TNT Post South West Ltd (05983401), TNT Post Midlands Limited (6458167)and TNT Post London Limited (6493826). Emma's Diary and Lifecycle are trading names for Lifecycle Marketing (Mother and Baby) Ltd (02556692). All companies are registered in England and Wales; registered address: 1 Globeside Business Park, Fieldhouse Lane, Marlow, Buckinghamshire, SL7 1HY.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
