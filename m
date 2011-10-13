Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9DE9SZM012388
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2011 10:09:28 -0400
Received: from out5.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9DE9REu014329
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2011 14:09:28 GMT
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D819D21D96
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2011 10:09:26 -0400 (EDT)
Message-Id: <1318514966.7386.140660985510889@webmail.messagingengine.com>
From: "Damian Gerow" <dgerow@afflictions.org>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1318513975.17008.2.camel@moss-pluto>
References: <1318478183.9025.140258154258765@webmail.messagingengine.com>
 <1318513975.17008.2.camel@moss-pluto>
Subject: Re: Upstart not transitioning to target domain
Date: Thu, 13 Oct 2011 10:09:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, October 13, 2011 9:52 AM, "Stephen Smalley"
<sds@tycho.nsa.gov> wrote:
> > What am I doing wrong?
> 
> Is the filesystem mounted nosuid?  If so, that will suppress the domain
> transition.

That was exactly what was causing the problem.  I'm now seeing the
expected AVC denials for foobard_t.

Thank you!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
