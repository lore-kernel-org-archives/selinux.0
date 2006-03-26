Message-ID: <BAY22-F25ADF3AA0F5941B05A0CA3C0DD0@phx.gbl>
From: "Rongdong Lu" <qdmudong@hotmail.com>
To: SELinux@tycho.nsa.gov
Subject: I am add a custom rule, know how 2 do te file, what about fc file, please help
Date: Sun, 26 Mar 2006 01:38:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, List,

Selinux has been driving me real crazy for the last serveral weeks, now 
finally I'am getting some clue.

Here's a problem i am having now. I have a centos4 server, with selinux 
turned on, I can't use php to send out mail. I am using 
selinux-policy-targeted-1.17.30-2.126. I am trying to add a custom rule the 
first time.

here is the error messge in messages log:

Mar 25 20:19:14 example kernel: audit(1143335954.882:36): avc:  denied  { 
execute } for  pid=10036 comm="sh" name="sendmail" dev=sda5 ino=1228853 
scontext=root:system_r:httpd_sys_script_t tcontext=system_u:object_r:var_t 
tclass=file
Mar 25 20:19:14 example kernel: audit(1143335954.882:37): avc:  denied  { 
getattr } for  pid=10036 comm="sh" name="sendmail" dev=sda5 ino=1228853 
scontext=root:system_r:httpd_sys_script_t tcontext=system_u:object_r:var_t 
tclass=file

I know I can use audit2allow to get the rule to add in to a te file, but 
what do I add to the fc file? I couldn't find which is the command trys to 
access sendmail, a process with that pid one didn't exist after the error 
message is generated.

any advice is appeciated, thanks in advance, guys

Ron

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
