Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l98J97aq002349
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 15:09:08 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l98J96MG015457
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 19:09:07 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l98J944n024301
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 15:09:04 -0400
Subject: Shell redirection and denials
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Mon, 08 Oct 2007 15:08:57 -0400
Message-Id: <1191870537.14569.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One of Dan's constant sources of avcs is something like:

/usr/sbin/my_confined_app > some_file

Because the file is created by the shell, opened, and the FD handed to
the application avcs can occur on read and write.

Getting rid of these via policy is next to impossible - the destination
file type is usually governed by the directory and we don't actually
want to allow that access directly to the confined application. I'd like
to see if there is some other way to get rid of these denials.

I see two possible solutions:

1) Make the shell create and pass a descriptor to a pipe to the
application - the shell itself would read / write to the file. This
seems, to me, to more accurately reflect how we want to enforce the
permissions.

2) Allow applications to confer access by passing the file descriptor
(more like capabilities). This more closely matches how Unix actually
works and, of course, is a huge source of vulnerabilities. Allowing this
type of scheme just for shells might not be that bad.

Has either of these been investigated? 1 seems pretty simple - is there
something I'm missing here (perhaps the redirection should outlast the
shell lifetime?).

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
