Date: Sat, 12 Jul 2003 13:41:13 -0400
From: Subba Rao <subba9@cablespeed.com>
To: "NSA's SELinux" <SELinux@tycho.nsa.gov>
Subject: Question about MACs
Message-ID: <20030712174113.GL29762@cablespeed.com>
Reply-To: Subba Rao <subba9@cablespeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello, 

I have a very basic question regarding mandatory access controls(MACs).  

Using the following diagram: 

---------------------         ---------------------
|    Subject         |        |     Object         |
---------------------         ---------------------
|    Clearance       |        |    Classification  |
|  Ex - Top Secret   |        |  Ex - Top Secret   |
|                    |        |                    |
---------------------         ---------------------


In the MAC model the "need-to-know" flag, restricts the subject to access the
object.  Is this flag, part of the subject's attributes or the object's
attributes? 

Thank you in advance. 

-- 
Subba Rao
subba9@cablespeed.com
------------------------------------------------------------------------------
Old American Wild West saying:       God created men but Colt made them equal.
Today:                  Linus created Linux and Linux made IT companies equal.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
