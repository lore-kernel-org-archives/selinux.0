Message-ID: <20050113180721.17378.qmail@web51502.mail.yahoo.com>
Date: Thu, 13 Jan 2005 10:07:21 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Why root:sysadm_r:pam_t is invalid?
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
  I added some rule in my SELinux policy in FC2. After
that, When I ran 'make load' (in
/etc/security/selinux/src/policy/), the system always
complaints as the following (in /var/log/message):

... ...
Jan 14 01:37:28 lenovo kernel: security:  5 users, 7
roles, 1248 types, 1 bools
Jan 14 01:37:28 lenovo kernel: security:  31 classes,
303633 rules
Jan 14 01:37:28 localhost kernel: security:  context
root:sysadm_r:pam_t is invalid


But, I didn't change anything about pam_t, why it says
that root:sysadm_r:pam_t is invalid?


Thank you.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
