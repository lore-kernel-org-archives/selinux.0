Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06823
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 13:59:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA24799
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 18:57:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA24795
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 18:57:20 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Vamshi Krishna K" <vamshi@cmcltd.com>
Subject: Re: SELinux and Tomcat web server
Date: Wed, 13 Nov 2002 18:21:10 +0100
References: <1138.172.16.16.31.1037107565.squirrel@webmail> <200211121941.07340.russell@coker.com.au> <006a01c28acd$acd8e6e0$1f1010ac@VISIC31>
In-Reply-To: <006a01c28acd$acd8e6e0$1f1010ac@VISIC31>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200211131821.10491.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Nov 2002 05:32, Vamshi Krishna K wrote:
> Do you have any policy which is similar to what we are talking about.
> Something like what is given for a Apache server.

Not really.

> (I had been poking with
> that (apache.te) for sometime now to see how it works but I am afraid
> Tomcat is a bit different from it, what with it's interactions with Java
> subsystem.) Or a bare policy for the context in disussion can also be
> helpful. Please give me some links from where I can start off. I am not
> fully confident of my understanding of the whole stuff as yet and would be
> grateful for any help.

How about starting with the following:

jserver.te:
daemon_domain(jserver)
tmp_domain(jserver)
log_domain(jserver)

jserver.fc:
/usr/sbin/whatever	system_u:object_r:jserver_exec_t
/var/cache/jserver(.*)?	system_u:object_r:jserver_tmp_t
/var/log/jserver(.*)?	system_u:object_r:jserver_log_t

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
