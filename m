Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA27490
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2002 13:19:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04875
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2002 18:18:47 GMT
Received: from smtpproxy2.mitre.org (smtpproxy2.mitre.org [128.29.154.90])
	by jazzswing.ncsc.mil  with ESMTP id SAA04871
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2002 18:18:47 GMT
Message-ID: <3C5ADC13.A4B39A60@mitre.org>
Date: Fri, 01 Feb 2002 13:18:59 -0500
From: Jen Schommer <jschommer@mitre.org>
MIME-Version: 1.0
To: Justin Smith <jsmith@mcs.drexel.edu>
CC: selinux@tycho.nsa.gov
Subject: Re: Strange behavior of httpd
References: <1012394639.1422.6.camel@jsmith.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin,

I worked on the example Apache policy for Selinux.  

The files you reference seem to be semaphore files.  Apache is using
these files to globally synchronize two or more of it's processes. The
behavior you describe seems legitimate, therefor it is ok to create
these types and give Apache permisison to them. The same will be done
for the example Apache policy in Selinux. 

I am not sure what changed in the Apache environment, where the policy
is running, to make Apache want to globally synchronzie it's proceses. 

Jen

> After running for more than a week on a fixed policy, httpd suddenly
> wants more privileges and refuses to serve web pages without them:
> 
> It, and cgi scripts it runs, are trying to access files in /var/cache
> and /var/run
> 
> /var/cache/ssl_gcache_data.sem
> 
> and
> 
> /var/run/httpd.mm.995.sem
> 
> I made up a new file type for the /var/run file, 'httpd_var_run_sem_t'
> and could do that for the ssl_gcache_data.sem file but wonder why this
> apparent change of behavior after so long.
> 
> I apologize if this is off-topic.
> 
> --
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
