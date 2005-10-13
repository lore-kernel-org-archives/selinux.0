Message-ID: <434E3D75.8060009@cornell.edu>
Date: Thu, 13 Oct 2005 06:56:53 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] [ SEMANAGE ] Debug v3, some database things
References: <434CC592.70001@cornell.edu>	 <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>	 <434D35B1.7060409@cornell.edu> <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil> <434D3D33.90104@cornell.edu> <434E38C2.9030602@cornell.edu>
In-Reply-To: <434E38C2.9030602@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bugfix:
Can you please add ( ) around every dereference of handle_arg in 
msg_write (for both semanage and sepol)
I can send a followup patch if you prefer. Macros are evil...

Warning:
The following code is no longer valid - this is now a syntax error.
if (blah) DEBUG(a); else ..

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
