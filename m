Message-ID: <20041223055909.94522.qmail@web51507.mail.yahoo.com>
Date: Wed, 22 Dec 2004 21:59:09 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Where is the SID stored in file system and process respectively?
To: SELinux@tycho.nsa.gov
Cc: sds@epoch.ncsc.mil, fedora-selinux-list@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
  As we know, In SELinux, when we first access a file,
the file system should first send the security context
of the file from its extended attribute to security
server. the security server will give a SID back to
the file for later use. Since then, every time when we
access the file, there is no need for the file system
to send the security context of the file again.
instead, it will send the SID of the file to security
server. 
  But, Where is the SID (which is assigned by security
server for the file) stored in the file system? and
How is the SID calculated? 
  
  As for process in selinux, Where is the SID (which
also is assigned by security server ) stored with the
process? 
  Is the security context of the process only exist in
the selinux security server and the process only need
to deal with the SID that is related to the security
context? 
  Will the process itself handle its own security
context?


  Thank you.

=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Dress up your holiday email, Hollywood style. Learn more. 
http://celebrity.mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
