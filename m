Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9LJGs2Y029207
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 15:16:54 -0400
Received: by mail-ee0-f53.google.com with SMTP id t10so3918205eei.12
        for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 12:16:52 -0700 (PDT)
Received: from yow-turd.ottawa.windriver.com ([128.224.252.2])
        by mx.google.com with ESMTPSA id w6sm36621954eeo.12.2013.10.21.12.16.50
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Oct 2013 12:16:50 -0700 (PDT)
From: Joe MacDonald <joe@deserted.net>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] Repair two build failures on older host
Date: Mon, 21 Oct 2013 15:16:38 -0400
Message-Id: <1382383000-16439-1-git-send-email-joe@deserted.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was building from source today on one of my older (Ubuntu 12.04.3)
installations and ran into a couple of minor issues.  The former wouldn't show
up on any host with a reasonable modern libpcre, but I don't know how the
combination of flags (-Werror -Wshadow) builds elsewhere.  I suspect I'm missing
something.

-- 
-Joe.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
