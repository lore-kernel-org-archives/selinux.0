Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4CNNuFq009244
	for <selinux@tycho.nsa.gov>; Sun, 12 May 2013 19:23:56 -0400
Received: by mail-we0-f169.google.com with SMTP id x54so5790036wes.0
        for <selinux@tycho.nsa.gov>; Sun, 12 May 2013 16:23:54 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id bs20sm5473487wib.0.2013.05.11.11.55.45
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 11:55:46 -0700 (PDT)
Date: Sat, 11 May 2013 20:54:47 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH/RFC 0/2] Test failures when building sepolgen
Message-ID: <20130511185446.GA933@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please find the following two patch suggestions for test failures while
building sepolgen (and running its provided tests). Asking a bit for
comments as well since I'm not sure if a fix should go either way (i.e.
update test or update code).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
