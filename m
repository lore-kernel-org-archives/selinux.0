Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA01956
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 18:19:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA19316
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 23:18:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA19312
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 23:18:22 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Date: Sat, 16 Mar 2002 00:19:22 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203150854350.15480-100000@raven>
MIME-Version: 1.0
Message-Id: <20020315231922.EE0931ECB7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 15 Mar 2002 15:00, Stephen Smalley wrote:
> > To solve this I was thinking of having an automatic transition from
> > sysadm_t to dpkg_t when dpkg_exec_t programs are run.  Then there would
> > be an automatic transition from dpkg_t when running initrc_exec_t
> > binaries (all the start scripts) which stops run_init from needing a
> > password.
> >
> > What do you think of this idea?
>
> I'm not sure I understand.  run_init (or something similar) still needs to
> be used when running the init scripts so that they are executed from the
> proper security context.  run_init re-authenticates for the same reason as
> newrole - to ensure that the user really wants to perform the transition,
> as opposed to some malicious code run by the user.  If you eliminate the
> user interaction for dpkg, how do you provide the same guarantee?  Or, if
> you are willing to give up that guarantee, then why not just drop the
> authentication out of your copy of run_init entirely.

OK.  What if I make it the proceedure to use run_init to run dpkg or dselect 
for package installation or replacement?

The idea of dropping the authentication out of run_init or doing any major 
change to decrease the security of my setup is not something that I am 
prepared to consider.

My problem is that in the usual Debian package installation process the 
program dselect will run dpkg multiple times, each invocation may install 
multiple packages.  Each package installation may run multiple scripts that 
may end up starting daemons, in many cases the daemon start scripts will be 
run with standard input directed to be from /dev/null.  So if there is to be 
any authentication in the package installation process then it has to be 
before dselect is started.

Am I on the right track now?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
