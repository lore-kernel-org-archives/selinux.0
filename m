Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05046
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 09:49:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26457
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 14:47:41 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA26452
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 14:47:40 GMT
Date: Tue, 5 Nov 2002 09:49:22 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Giorgio Zanin <giorgio.zanin@inwind.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: type transition
In-Reply-To: <3DC6CAB2.3070008@inwind.it>
Message-ID: <Pine.LNX.4.33.0211050916500.30663-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 4 Nov 2002, Giorgio Zanin wrote:

> what's the difference between the following statements:
>
> type_transition TYPE_A TYPE_B:process TYPE_C
>

  This rule states how a process transitions. If a process is currently in
domain TYPE_A, and execs a file of type TYPE_B, then the process will
transition to domain TYPE_C. However, the policy must allow this
transition, hence:


>
> allow TYPE_A TYPE_C:process transition

  This rule states that a process in domain TYPE_A is allowed to
transition to domain TYPE_C.
  You should look at the SELinux Policy doc for more information, at
http://www.nsa.gov/selinux/policy2-abs.html
  You can also refer to the original SELinux report:
http://www.nsa.gov/selinux/slinux-abs.html.


 --
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
