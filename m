Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA27886
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 19:29:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA10216
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 23:27:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA10212 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 23:27:55 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: revising the su decision
Date: Sat, 13 Jul 2002 01:29:15 +0200
References: <200207121546.KAA74379@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200207121546.KAA74379@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <20020712232915.70A7C44D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Jul 2002 17:46, Jesse Pollard wrote:
> The separation now means that a root compromise is not all that usefull.
>
> Consider what happes if a root compromise performs a "su - root". It
> currently looks like the compromise would suddenly get whatever role has
> been assiged to root.

You are assuming here that root:user_r:user_t can su to any domain without a 
password, and that a default su to a domain will get the maximum SE Linux 
privs.

The former assumption is not what I had been thinking of, and the latter is a 
matter of policy.

I had imagined that the ability to do "su - account" without a password would 
depend on both UID=0 and being sysadm_r:sysadm_t.

> The advantage of the newrole is to REQUIRE a password before gaining
> sysadm_r.

Yes, but that doesn't stop us from having one program doing both
"newrole -r sysadm_r" and "su -" functionality.

> Now, If you merge the newrole functions into su and remove the automatic
> su to itself (ie su root when root still requires a password, AND su to
> any account requires a password), then my objections are much weaker.

How about su to any account without a password gets the same result as such a 
su operation now, the source UID must be 0 and the context doesn't change.

I think that your disagreement is due to imagining a different way of 
implementing it to that which I had imagined.


Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
