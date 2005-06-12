Message-ID: <20050612172106.46491.qmail@web51505.mail.yahoo.com>
Date: Sun, 12 Jun 2005 10:21:06 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Questions about "labeled networking" and "network message" 
To: James Morris <jmorris@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear sir,

In "Networking in NSA Security-Enhanced Linux" (
http://www.linuxjournal.com/article/7764 ), you wrote:

"It is likely that some form of labeled networking
will be implemented for SELinux. This is where
network traffic itself is labeled and typically is
used in military and government environments
dealing with classified information." 


What I want to ask is:
What is the purpose of "labeled networking"? Is there
any use of it?
and, How to understand the statement:"typically is
used in military and government environments
dealing with classified information."? Would you
please give me a scenario of the statement?



You also wrote in the paper:

"Network interfaces are labeled as follows: 
netifcon interface context default_msg_context
The default_msg_context parameter is intended to be
used for labeling messages arriving on the interface,
but is not currently used. "


Then,
Does this means that messages, whether sending or
receiveing in SELinux, are not associated with any
security context/SID at all now? and Does SELinux not
control them because there are no security context/SID
associated with them?
Or, Are these messages just labeled with some other
kind of security context/SID? 


Thank you very much.

Best Regards,
Park Lee


		
__________________________________ 
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
