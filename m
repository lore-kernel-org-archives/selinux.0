From: "A Almeida" <skubey@hotmail.com>
To: SELinux@tycho.nsa.gov
Subject: postmaster/postgres policy files
Date: Fri, 02 Aug 2002 11:50:51 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F88TF4ia5wAz8AWiZAt0001366f@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since the message quoted below was posted in February, has anyone written 
policy files for postgres/postmaster that you'd be willing to share?

If not, the thing to do seems to make a new label for the executable
postmaster (which is a symlink to postgres).  It should be labelled
something like system_u:object_r:postgres_t instead of 
system_u:object_r:bin_t.  Then, a TE file defining policy and transitioning 
initrc_t to postgres_t would be needed.

This seems to be the safe approach from studying the mail list.  However, 
I'd not want to reinvent the wheel if someone has already written policy for 
postgres/postmaster.

If you have comments, thoughts, suggests, or would be willing to share an 
already written postmaster.te or postgres.te file, would be appreciated.

-Morgan

-- original message from Beth Meighan bmeighan@bbn.com --

The only dialogue I saw on this mail list about Postgres had ended with the 
Postgres system processes in initrc_t domain and the recommendation to move 
them into their own domain. Has anyone made domains and types for Postgres? 
If so, would you be willing to share your .te file and any other policy 
files you edited?

Thank you in advance,
Beth Meighan



_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
