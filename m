Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA20313
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 14:41:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA04755
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 19:41:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil  with ESMTP id TAA04751
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 19:41:26 GMT
Date: Mon, 26 Feb 2001 14:40:55 -0500 (EST)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200102261940.OAA10081@coalstove.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: New to list
Cc: mlucas@imagelinks.com
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

The NSA Security-enhanced Linux Team hasn't been working with
Beowulf clusters, so there haven't been any specific modifications so
far to deal with them.  My guess, based on my relatively limited knowledge
of clusters is that you may have to adjust the policy somewhat to deal
with resources that you want to share in non-typical ways.

We're currently working on a port to a 2.4 series kernel, and there have
been a couple of questions on the list from people exploring RedHat 7, so
I wouldn't be surprised if a future release works with RedHat 7. or 7.1.

Our experience so far is somewhat limited, but upgrading to new releases
doesn't seem like it's going to be extremely painful.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

> Just signed up on the list.  We are building BeoWulf clusters as 
> geospatial rendering engines and are working with several government 
> agencies in the process.  I'm hoping that we can apply the excellent 
> work of this group towards improving our system and satisfying the 
> various security concerns as our systems begin to integrate with 
> various secure networks.  We are currently running RH 6.2, but plan 
> on remaining current with the major releases (will probably wait for 
> 7.1 and the 2.4 kernel for the next upgrade).
> 
> Have there been a specific modifications with regards to clusters?
> 
> How difficult is it going to be to upgrade as new releases appear?
> 
> We host http://www.remotesensing.org which hosts open source 
> development for remote sensing and GIS.  One project that may be of 
> interest to this group is the Configuration File Management (CFM) 
> system.  This will remotely manage configuration files on 
> heterogeneous systems, report discrepancies and correct the 
> configuration files if required.  It is open source and we have used 
> it in our business to successfully manage the configuration of 
> internal and external machines.
> 
> Looking forward to working with the group.
> 
> Mark
> 
> -- 
> **********************
> Mark R Lucas
> Chief Technical Officer
> ImageLinks Inc.
> 4450 W Eau Gallie Blvd
> Suite 164
> Melbourne Fl 32934
> 
> 321 253 0011 (work)
> 321 253 5559 (fax)
> 
> mlucas@imagelinks.com
> **********************

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
