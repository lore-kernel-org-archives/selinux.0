Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA13740
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 19:59:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA04822
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 23:57:47 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id XAA04818 for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 23:57:45 GMT
Date: Fri, 23 Aug 2002 09:59:12 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>, "M. H." <metalhead00@hotmail.com>,
        selinux@tycho.nsa.gov
Subject: Re: restrict access by user identity
Message-ID: <20020822235912.GI11786@snoopy.apana.org.au>
References: <Pine.GSO.4.33.0208221358250.29931-100000@raven> <20020822205144.E6FAA6B15@lyta.coker.com.au> <20020822212851.EE0308932@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020822212851.EE0308932@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 22, 2002 at 11:28:51PM +0200, Russell Coker wrote:
> Now I'm stuck on what to do with the following from file_contexts/types.fc:
> /tmp/orbit.*        system_u:object_r:user_tmp_t
> /tmp/.ICE-unix(|/.*)     system_u:object_r:user_tmp_t
> 
> As I don't have /tmp/orbit.* and I don't know what the .ICE-unix on my system 
> is for I'm not sure what to do with them.

Not sure if this helps:

[509] [snoopy:unstable:bam] ~ >fuser -v /tmp/.ICE-unix/29869 

                     USER        PID ACCESS COMMAND
/tmp/.ICE-unix/29869 bam       29869 f....  gnome-session

Of course, I still don't know what it is there for, it doesn't
appear to be orbit related either (although I might be mistaken).
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
