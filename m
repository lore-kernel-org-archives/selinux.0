Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA13077
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2002 07:43:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA17459
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2002 12:42:31 GMT
Received: from jsmith.org (pool-141-158-40-34.phil.east.verizon.net [141.158.40.34])
        by jazzband.ncsc.mil  with ESMTP id MAA17455 for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2002 12:42:30 GMT
Subject: Strange behavior of httpd
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 30 Jan 2002 07:43:59 -0500
Message-Id: <1012394639.1422.6.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After running for more than a week on a fixed policy, httpd suddenly
wants more privileges and refuses to serve web pages without them:

It, and cgi scripts it runs, are trying to access files in /var/cache
and /var/run

/var/cache/ssl_gcache_data.sem

and

/var/run/httpd.mm.995.sem

I made up a new file type for the /var/run file, 'httpd_var_run_sem_t'
and could do that for the ssl_gcache_data.sem file but wonder why this
apparent change of behavior after so long.

I apologize if this is off-topic.

--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
