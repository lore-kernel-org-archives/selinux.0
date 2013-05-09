Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r49IYZjq031719
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2013 14:34:35 -0400
Received: by mail-we0-f175.google.com with SMTP id p57so3248336wes.6
        for <selinux@tycho.nsa.gov>; Thu, 09 May 2013 11:34:33 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id ff10sm6184261wib.10.2013.05.09.11.34.31
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 11:34:32 -0700 (PDT)
Date: Thu, 9 May 2013 20:33:36 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Disabling rules
Message-ID: <20130509183336.GA16336@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I was wondering if we could include a method for users or administrators to
remove (or disable) particular allow statements from the policy, without the
need to unload the module that provides the policy and replace it with a
similar policy (offering the same types and such, but just doesn't include
those rules the admin doesn't want to enable).

>From my understanding, I think this has been discussed in the past, but not
accepted due to it becoming a mess (for admins) to maintain such policies:
in one module, rules would be allowed, and in another denied again.

Still, we can disable dontaudits, disable an entire module or put a
particular domain in permissive mode. Perhaps we could look into disabling
certain statements as well? 

The reason I ask is that administrators might want to some just a fraction
of the granted permissions in the default policy, without having to maintain
an entire policy themselves. This could be useful for temporarily working
around possible vulnerabilities.

For (policy) developers as well, this could be a useful feature. One can
selectively disable some rules and test out the impact. For instance,
suppose we want to reduce the number of "open" permissions on certain files.
Historically, "open" was granted as well, but we might want to look into
inherited read/write access (without "open"). With such feature, we can test
out the impact without the need to do the (intensive) policy updates first.
Afterwards, the policy can then be properly reduced.

I was considering using constraints to implement this myself (locally), but
constraints cannot be added to modules (need to be in base according to the
selinuxproject wiki).

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
