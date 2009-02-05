Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n15H86sA000458
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2009 12:08:06 -0500
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n15H4uR3004069
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2009 17:04:56 GMT
Received: by qw-out-1920.google.com with SMTP id 5so142569qwc.30
        for <selinux@tycho.nsa.gov>; Thu, 05 Feb 2009 09:08:04 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 5 Feb 2009 11:08:04 -0600
Message-ID: <cadfc0e40902050908n5391c4b4l417714fe87a47f29@mail.gmail.com>
Subject: problem with capabilities inheritance and auditing in python
From: Xavier Toth <txtoth@gmail.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've set the capabilities on a script that runs some python code with
auditing calls in it but I'm not getting audit records written to the
audit log. From what I've read I thought the +i would all the
capability to be inherited across execve but this doesn't appear to be
the case. Can anyone help me understand what's going wrong here? Is
there a way in the python code to get the capabilities to see if
indeed cap_audit_write was inherited?

sudo /usr/sbin/setcap cap_audit_write+pei audit_test

-------------------------------------------------------- audit_test
-----------------------------------------------------------------------

#!/bin/sh
/usr/bin/python2 audit_test.py

--------------------------------------------------------
audit_test.py -------------------------------------------------------------------
import audit
import traceback
import errno
import sys, os

def test():
   msg = "foo"
   try:
       audit_fd = audit.audit_open()
       if audit_fd < 0:
           print("Error connecting to audit daemon")
           sys.exit(1)
   except:
       print("Failed to connecting to audit daemon:  %s : %s" % (
sys.exc_info()[0], traceback.format_exc()))
       sys.exit(1)

   hostname = 'unknown'
   hostaddr = 'unknown'
   ttyname = 'unknown'
   try:
       hostname = socket.gethostname()
       try:
           hostaddr = socket.gethostbyname(hostname)
       except:
           hostaddr = 'unknown'
   except:
           hostname = 'unknown'

   try:
       ttyname = os.readlink('/proc/self/fd/0')
       if ttyname.find('/dev') != 0:
           ttyname = 'notatty'
   except:
       ttyname = 'unknown'

   try:
       print "call audit_log_user_message"
       rc = audit.audit_log_user_message(audit_fd,
audit.AUDIT_LABEL_LEVEL_CHANGE, msg, hostname, hostaddr, ttyname, 0);
       rc = audit.audit_log_user_message(audit_fd,
audit.AUDIT_TRUSTED_APP, msg, hostname, hostaddr, ttyname, 0);
       if rc < 0:
           print("Error writing to audit")
           sys.exit(1)
   except:
       print("Failed to write audit:  %s : %s" % ( sys.exc_info()[0],
traceback.format_exc()))
       sys.exit(1)


if __name__ == '__main__':
   test()

--------------------------------------------------------------------------------------------------------------------------------------------------------


Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
