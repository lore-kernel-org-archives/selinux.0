Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r41KRJeB021683
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2013 16:27:20 -0400
Received: by mail-we0-f170.google.com with SMTP id z53so1534712wey.29
        for <selinux@tycho.nsa.gov>; Wed, 01 May 2013 13:27:18 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id q18sm34348416wiw.8.2013.05.01.13.27.16
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 13:27:17 -0700 (PDT)
Date: Wed, 1 May 2013 22:26:32 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Open stdin as read/write
Message-ID: <20130501202632.GB22742@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As per the discussion on the selinux development mailinglist, the tmux
application expects the stdin to be writeable. Although perhaps not the most
proper way, having newrole opening the descriptor in read/write keeps the
behaviour in line with what applications expect.

See also http://marc.info/?l=selinux&m=136518126930710&w=2

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 policycoreutils/newrole/newrole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 8fbf2d0..dfb8c7f 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1223,7 +1223,7 @@ int main(int argc, char *argv[])
 			fprintf(stderr, _("Could not close descriptors.\n"));
 			goto err_close_pam;
 		}
-		fd = open(ttyn, O_RDONLY | O_NONBLOCK);
+		fd = open(ttyn, O_RDWR | O_NONBLOCK);
 		if (fd != 0)
 			goto err_close_pam;
 		fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
