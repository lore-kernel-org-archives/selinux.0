From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com
Subject: I have modified the policy for installd over app_data_file
Date: Mon, 23 Jul 2012 10:22:16 -0700
Message-Id: <1343064137-17849-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH 1/1] external/sepolicy: install daemon unlink application data files
According to the comments from Stephen, I modify the permissions to "unlink only".

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
