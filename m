Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16298
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 08:13:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA24789
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 13:10:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA24785
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 13:10:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: FOSDEM report
Date: Sun, 9 Feb 2003 22:02:22 +0100
Cc: Colin Leroy <colin@colino.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200302092202.22424.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Today I gave a 1 hour talk on SE Linux at FOSDEM.  It wasn't a scheduled talk 
but they made room for me at the last minute.

The audience was very attentive and knowledgable (about half the audience had 
tried out SE Linux in my hacking contest) and asked some really good 
questions.  This was fortunate as my talk went faster than expected and I had 
covered the material in half the time, but the questions lasted until the 
security people wanted to lock the doors.


The hacking contest had two parts.  The first part was to read or write a file 
in the home directory of user "easy" when starting from UID=0 
context=root:user_r:user_t.

Colin Leroy was the first (and AFAIK only) person to solve this.  Firstly he 
put in a cron job for user "easy" to do "ls" on the easy home directory (mode 
0700 which prevented root from inspecting it directly even though both "root" 
and "easy" were in user_r) and discovered the file /home/easy/FLAG but 
couldn't read it because it was owned by root and more 0600.

Then he discovered that he could use the command:
EDITOR=vi /home/easy/FLAG crontab -e -u easy

To get at the file.

I did some experiments later and discovered that I could do "crontab -e -u 
easy" and then use the ":r" and ":w" commands in vi.

The reason is that the user_crontab_t domain has dac_override access.  I 
experimented with removing dac_override and found that it still works OK for 
my setup, I am still not sure about all the implications of this for other 
installations.  However I have not been able to think of a situation where 
this is really required.

Also I noticed that user_crontab_t had capability net_bind_service and could 
think of no possible reason for that so I removed it from my tree.

The next thing that occurred to me is that vi should not run in the 
user_crontab_t anyway, so I put in a domain_auto_trans rule to transition to 
user_t when running { bin_t sbin_t exec_type } so that the editor can run in 
user_t and not have any special access.  I am still experimenting with this, 
but it will probably mean that I can significantly reduce the access of 
user_crontab_t.  Also I attended Solar Designer's presentation, and if I 
installed some of his patches for crond and crontab then I could remove 
setuid access from user_crontab_t as well.


Another thing that Colin noticed is that as there was no crontab entry for my 
account "rjc" he could create one to run cron jobs as rjc:user_r:user_crond_t 
which gets him access to my identity.  However as I had not allowed 
transitions from user_r to staff_r or sysadm_r that did not gain much.


So the end result of the hacking contest is that Colin got the best work in 
exceeding the access I had intended to grant.  Of course it has to be noted 
that the majority of SE Linux administrators will not grant hostile users 
access to the root account, so this is not a security issue in SE Linux, but 
it is something that we should tighten up to reduce the risk of a security 
hole in crontab being exploited for further access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
