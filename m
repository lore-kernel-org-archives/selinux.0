Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h63MwDHa004609
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 18:58:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h63MvKnJ003494
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 22:57:20 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h63MvJhr003489
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 22:57:19 GMT
Subject: Re: Policies.. but where there are?
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Mauro Chiarugi <vlaovic@libero.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030703234800.330f8026.vlaovic@libero.it>
References: <20030703234800.330f8026.vlaovic@libero.it>
Content-Type: text/plain
Message-Id: <1057273088.31584.70.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Jul 2003 18:58:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The policy is built using a Makefile which combines the files with the
policy statements (and M4 macros) into a single policy.conf.  The
policy.conf file is compiled by the checkpolicy program into a file
better parsed by computers than humans.  The compiled output file is
loaded into kernel data structures which are then used during access
control checks.

That is a very brief very high-level answer.  Does it answer your
question?

On Thu, 2003-07-03 at 17:48, Mauro Chiarugi wrote:
> Hi,
> i've just read come docs about SELinux, but i don't have unsterstood
> where these policy (domains, etc.) are saved.. when i compile the
> policy, where are recordered this information? In the kernel? In a file?
> In the filesystem? 
> 
> thanks
> 
> bye bye
> 
> sracatus
-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
