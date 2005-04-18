Message-ID: <20050418165241.9635.qmail@web51510.mail.yahoo.com>
Date: Mon, 18 Apr 2005 09:52:40 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Be labeled with SID or security context?
To: SELinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
  In SELinux, sockets inherit the SID of its creating
process. 
  Then, can we say that sockets are labeled with the
SID of its creating process? (i.e. Can we say that
SELinux uses the SID of a socket's creating process to
label the socket?)
  Or, can we also say that sockets are labeled with
the security context of its creating process ? 
  Which one is better?

Thanks,

Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Plan great trips with Yahoo! Travel: Now over 17,000 guides!
http://travel.yahoo.com/p-travelguide

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
