Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9K2wIi015576
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:02:58 -0500 (EST)
Received: from web50204.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id iB9K1LPS021178
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:01:21 GMT
Message-ID: <20041209200301.59535.qmail@web50204.mail.yahoo.com>
Date: Thu, 9 Dec 2004 12:03:00 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Single home directory type for all roles.
To: Russell Coker <rcoker@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102615951.4509.50.camel@aeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <rcoker@redhat.com> wrote:

> The problem with such a change is that it interferes
> with the operation
> of "ls -l /tmp" (which is IMHO a fairly important
> operation for a system
> administrator).  I can imagine a situation where one
> user is trying a
> race condition against another user but the
> administrator doesn't notice
> because "ls -l /tmp" doesn't display full
> information.

I apologize in advance for missing any discussions
regrading /tmp over the past year or so. ...

In the U2X world the issue of /tmp was solved
using a variety of implementations of "moldy"
directories. An attribute (in some cases a seperate
file type) was used that identified certain
directories, /tmp in particular, as moldy. The lookup
processing was modified such that when a moldy
directory is encountered an additional path component
based on the process's label is inserted, as:

    /tmp becomes /tmp/<labelname>

and then resolution continues. A process with a
"moldy" attribute of it's own is does not have the
additional component added, addressing the admin
issue. Some systems created the subdirectories on
reference, others required it be done
administratively. There are similar tricks that
can be played with variable symlinks.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
