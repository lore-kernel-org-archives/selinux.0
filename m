Message-ID: <47824819.9040006@manicmethod.com>
Date: Mon, 07 Jan 2008 10:41:13 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: role dominance 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While working on policyrep we've found that role dominance is pretty 
difficult to implement correctly, and apparently there is some ambiguity 
about how it works. The main problem we are running into now is that 
converting the role bitmaps of an old module (compatibility) back to a 
role dominance statement is very difficult.

Also it seems like noone has really used role dominance. During 
conversations about it here Chris PeBenito suggests that he wants 
something like it for refpolicy but a role attribute kind of system may 
be much simpler and easier to implement/understand.

Thoughts?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
