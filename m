Message-ID: <20041224183055.44205.qmail@web51507.mail.yahoo.com>
Date: Fri, 24 Dec 2004 10:30:55 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: About security field in struct sk_buff
To: SELinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
 In /usr/src/linux/security/selinux/include/objsec.h,
there seems no SELinux security data structure for
struct sk_buff.
  Does this means that SELinux doesn't use the
security field (i.e. the unsigned short security) in
struct sk_buff at all?

  Thank you.

=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
