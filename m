Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8FGiYsJ024837
	for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2013 12:44:34 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1555712eak.36
        for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2013 09:44:31 -0700 (PDT)
Message-ID: <1379263465.20256.6.camel@d30>
Subject: Is this a bug in sesearch, or ...?
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Sun, 15 Sep 2013 18:44:25 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was explaining the concept of (type) attributes using the domain type
attribute as an example on IRC, and a sharp person embarrassed me by
noting that the following rule returns nothing where he would have
expected something:

sesearch -A -d -s domain -c process -p fork

Why does this not return anything? Is is because the target is "self"?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
