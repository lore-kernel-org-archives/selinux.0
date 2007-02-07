Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l18L0A9k023410
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 16:00:10 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l18L1FqP008403
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 21:01:16 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l18L0Mq9016133
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 16:00:22 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l18L0MuZ016132
	for selinux@tycho.nsa.gov; Thu, 8 Feb 2007 16:00:22 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17LvlDZ005006
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 16:57:47 -0500
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17Lwto6010628
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 21:58:56 GMT
Received: by an-out-0708.google.com with SMTP id d33so289426and
        for <selinux@tycho.nsa.gov>; Wed, 07 Feb 2007 13:58:55 -0800 (PST)
Message-ID: <f888952b0702071358p74576f3by6641c1a0df4893e6@mail.gmail.com>
Date: Wed, 7 Feb 2007 16:58:55 -0500
From: "Dave Quigley" <dquigley@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Questions regarding loadable policy modules
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
    I have a few questions about loadable policy modules in SELinux.
It has been mentioned before that certain policy language constructs
can't be used within a loadable policy module. Is there a list
somewhere for what these are? Also, I am looking through the reference
policy and I am trying to understand how the build process treats
policy marked with module in modules.conf. I have read through the
section on the reference policy in SELinux by Example and it mainly
describes a Monolithic policy build. The main question I have about
using a modular policy is what in the system is responsible for making
sure the proper modules are loaded if you use this method? My final
question is what exactly are the semantics and implementation details
of the policy_module keyword and what ramifications are there for
having your policy consist of many policy modules. I know each file in
the reference policy has a policy_module macro at the beginning but I
am talking about on a much finer granularity that currently exists.
Does the policy_module keyword provide some sort of isolation for a
module?

Dave Quigley

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
