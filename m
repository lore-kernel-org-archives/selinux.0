Message-ID: <3EA021A5.4020603@redhat.com>
Date: Fri, 18 Apr 2003 12:02:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: SUDO package
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com> <200304181408.55003.russell@coker.com.au>
In-Reply-To: <200304181408.55003.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have placed the latest sudo code in

ftp://people.redhat.com/dwalsh/SELinux/sudo

This code seems to work with the provided policy.  I have provided a src 
rpm,
and binary i386.rpm (for 8.0) and the two policy files.  

The binary i386 will install the policy files and reload the updated 
policy.  It
also does a chsid on the /usr/bin/sudo.  

This is my first try at writing Policy so please send me comments.


Thanks,
Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
