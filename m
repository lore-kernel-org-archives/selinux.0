Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFemal028332
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:40:51 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BBCE02153D
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:40:50 -0400 (EDT)
Message-ID: <1332862820.15547.17.camel@lenny>
Subject: Re: [PATCH 55/73] policycoreutils: Disable user restorecond by
 default
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Tue, 27 Mar 2012 11:40:20 -0400
In-Reply-To: <4F71DDF3.6010407@redhat.com>
References: <4F71DDF3.6010407@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why even build/install it then?

Seems like this should be a configure option like:
--disable-user-restorecond



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
