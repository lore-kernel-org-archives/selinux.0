Message-ID: <43511027.8080309@cornell.edu>
Date: Sat, 15 Oct 2005 10:20:23 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [ SEMANAGE ] User and port apis - policy database
References: <43510C78.1080209@cornell.edu>
In-Reply-To: <43510C78.1080209@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By the way, I don't particularly enjoy writing the same APIs and relay 
functions for each record (even though I didn't actually write them 5 
times, I just ran an example through sed). If you prefer I can try to 
come up with some macro scheme to write them once, and include ".c" file 
or something like that... but that would complicate things....

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
