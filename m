Message-Id: <se67e0d0.047@atlas.snu.edu>
Date: Thu, 06 Mar 2003 23:58:41 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <SELinux@tycho.nsa.gov>
Subject: selinux play machine
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell, i don't know if you just messed up or forgot to set the sid on spasswd but...

Someone changed the root password, it's a pity they weren't responsible enough
to change it back afterwards.  I've changed the SID of the spasswd program
to prevent this happening again...


root@cose:/# spasswd
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully

root@cose:/# newrole -r user_r
Authenticating root.
Password:  

(with the new password)

anyway, i changed it back
just thought i'd let you know....


Joshua Brindle
UNIX Administrator
Southern Nazarene University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
