Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FLQ1L9011490
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 16:26:01 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FLMXw0025028
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 21:22:34 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by open.hands.com (Postfix) with ESMTP id 08DEFC50A
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 21:24:42 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1D1ALP-0007UM-Sk
	for selinux@tycho.nsa.gov; Tue, 15 Feb 2005 21:34:55 +0000
Date: Tue, 15 Feb 2005 21:34:55 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: dynamic context transitions
Message-ID: <20050215213455.GF26294@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

stephen,

i assume it _is_ necessary to perform dynamic auto transitions?

such that i can track to alternative contexts, yes?

e.g. i am running in sshd_privsep_t [because on a fork(),
i deliberately called setcon() to set it that way]

and i now want to be a user-related context, so i do this:

	get_default_context(pw->pw_name,NULL,&scontext)
	setcon(scontext);

and i set up a dynamic_auto_trans(sshd_privsep_t,
                                  sshd_exec_t,
				  sshd_privsep_user_t)

... hang on, that doesn't look right.  surely there should be
four arguments:

	* domain you were in before the setcon
	* domain the setcon asked to be in
	* executable_t
	* domain you want to be in afterwards

so it'd be:

	dynamic_auto_trans(sshd_privsep_t, /* where we were */
		   user_t,               /* from get_default_context() */
		  sshd_exec_t,          /* from the sshd binary */
		  sshd_privsep_user_t) /* what we _really_ want to be */


burblburbl... *gloop* drowning in not-much-understanding...

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
