Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9VINdWt020728
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 13:23:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9VINcKl025779
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 18:23:38 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
        by jazzband.ncsc.mil  with ESMTP id h9VINb5m025773 for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 18:23:38 GMT
Date: Fri, 31 Oct 2003 19:23:36 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: successfull loaded policy on s390, 64bit
Message-ID: <20031031182336.GA18092@wavehammer.waldi.eu.org>
References: <20031024210709.GA17189@wavehammer.waldi.eu.org> <Pine.LNX.4.53.0310301830290.6332@rmt-desk.bmc.com> <20031031085045.GA29900@wavehammer.waldi.eu.org> <1067609436.30233.370.camel@moss-spartans.epoch.ncsc.mil> <20031031145312.GA9652@wavehammer.waldi.eu.org> <1067621560.30233.431.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1067621560.30233.431.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 31, 2003 at 12:32:40PM -0500, Stephen Smalley wrote:
> You'll have to continue to submit patches to the list if you want these
> changes upstreamed.  I've raised various concerns with some of the
> patches submitted to date that still haven't been resolved AFAIK.

I know, but please note that i just began to study at university, so I
need to manage that time consuming process first.

> Also, as a side note, access via svn:// may not be open to many (I seem
> to be having a problem with it), so exporting access via http:// would
> be better,

No, the support of http and the seperate svn protocol are equal.
Berkeley DB just have some large problems with slightly wrong
permissions, and the error message clearly explains this.

Bastian

-- 
I have never understood the female capacity to avoid a direct answer to
any question.
		-- Spock, "This Side of Paradise", stardate 3417.3

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
