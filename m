Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA15475
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 01:53:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA14692
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 06:52:51 GMT
Received: from glaurung.green-gryphon.com (cmc3107833-a.mbl1.al.home.com [24.37.208.47])
	by jazzswing.ncsc.mil  with ESMTP id GAA14688
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 06:52:50 GMT
Received: from glaurung.green-gryphon.com (localhost [127.0.0.1])
	by glaurung.green-gryphon.com (8.12.1/8.12.1/Debian -5) with ESMTP id g0K6nVuI003870
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 00:49:31 -0600
To: selinux@tycho.nsa.gov
Subject: Re: starting daemons under Debian
References: <20020118230436.2772532FA2C@lyta.coker.com.au>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Sun, 20 Jan 2002 00:49:29 -0600
In-Reply-To: <20020118230436.2772532FA2C@lyta.coker.com.au> (Russell Coker's
 message of "Sat, 19 Jan 2002 00:04:35 +0100")
Message-ID: <87665xpldy.fsf@glaurung.green-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>"Russell" == Russell Coker <russell@coker.com.au> writes:

 Russell> One thing I have played with is setting the security
 Russell> contexts so that the daemon automatically changes to the
 Russell> correct domain on startup from the sysadm_t domain such as
 Russell> the following (and also a minor matching change to rbac to
 Russell> make it allow root:sysadm_r:sshd_t):

 Russell> domain_auto_trans(sysadm_t , sshd_exec_t, sshd_t)

 Russell> This is minorly ugly, involves more rules than I'd like, but
 Russell> has the benefit that running "sshd" at the command line gets
 Russell> the same result as "/etc/init.d/ssh start".

 Russell> The other option is to divert /sbin/start-stop-daemon which
 Russell> is used by Debian for starting most (should be all) daemons.
 Russell> Then my replacement script would call run_init to run the
 Russell> real start-stop-daemon.

	But you lose the option to start sshd on the command line,
 don't you?


 Russell> Any comments on the relative merits of these two schemes?

	Putting on my Debian hat, I'd prefer the former, all else
 being the same. I'd also like to investigate the possibility of
 packages providing the recommended additions to policy, which can be
 used by the policy admin as a guide to what rules may be needed to
 utilize a package to the fullest capacity (I would not, of course,
 skip the human oversight step and automate the process).

	manoj
-- 
 A Los Angeles judge ruled that "a citizen may snore with immunity in
 his own home, even though he may be in possession of unusual and
 exceptional ability in that particular field."
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024R/C7261095 print CB D9 F4 12 68 07 E4 05  CC 2D 27 12 1D F5 E8 6E
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
