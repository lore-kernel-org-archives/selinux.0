Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA27366
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2001 18:04:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA19697
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2001 23:03:46 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil  with ESMTP id XAA19693
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2001 23:03:45 GMT
Date: Tue, 27 Feb 2001 17:03:59 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200102272303.RAA13833@tomcat.admin.navo.hpc.mil>
To: mlucas@imagelinks.com, selinux@tycho.nsa.gov
Subject: Re: Security approval question
In-Reply-To: <p04320404b6c1cb0a7e2a@[208.24.120.15]>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Mark Lucas <mlucas@imagelinks.com>:
> 
> We are prototyping Linux based clusters for government work and want 
> to eventually obtain the necessary approvals for attaching them to 
> classified networks. Currently they are running as  stand alone 
> systems during initial evaluation. We plan on implementing the 
> seLinux modifications to our system to improve system security.  I'm 
> curious if anyone has been able to obtain security approval for Linux 
> systems on classified networks and if there is a road map that we 
> could follow in our efforts.

I've got several hosts (not clusters) there now. We just treated them
as a regular C2 level systems.

1. The network is already listed system high - all users are authorized
   to any information there, they just may not have need-to-know.
2. User identification (basic UNIX) has been sufficient to pass these
   requirements tests. Having separate audit logs, instead of the combined
   syslog is the major limitation. This is understood, and has normal
   (and documented) accepable operation.
3. (not done here) It should be possible to get a cluster with rsh/nfs/other
   stuff passed by declaring the cluster network as an integral part
   of the system. I tried to get a SGI visualization lab (6 workstations +
   compute server) counted that way, but my management didn't want the
   extra testing that would have required (also, most test teams don't
   seem to understand that either - even when they are from the NSA).
   A reference to this is in 5200.28; E5.1.1.2 Case II. Unified Networks.

By disabling the questionable services (time, echo, rexec, rsh, and any
other oddballs in inetd and portmap) we have been able to pass ST&E exams
sent our way. Oh, be sure to use a current lpd (old ones are vulnerable)
and bind/named (if it is going to be a name server).

Be sure to limit the NFS/lockd/mountd facilities since these are frequently
listed as "vulerablilities" even though the Linux versions tend not
to be a problem. They can be used, but use the access limits at
the router such that hosts that do not need to see the traffic are
blocked  (it also makes it easier to pass the tests...).

I'm hoping to eventually get our systems upgraded to an SELinux version, but
most of our needs are for network control right now (and more experience
first).

Above all - document everything, and verify that the documents match the
real system. Lack of documentation can be forgiven, but the test teams
tend to do more detailed evaluation (staff interviews + scanning) when
it is missing.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
