Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA07791
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 01:06:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0I66wI13995
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 06:06:58 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h0I66uf13991 for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 06:06:57 GMT
Date: Sat, 18 Jan 2003 17:06:46 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Cambridge Security Group talk
Message-ID: <20030118060646.GC26168@snoopy.apana.org.au>
References: <200301180149.27476.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301180149.27476.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jan 18, 2003 at 01:49:27AM +0100, Russell Coker wrote:
> One suggestion from the audience was to remove "_t" and "_r" suffixes as the 
> context has all the information necessary to differentiate domains from 
> roles.  Another suggestion was to remove some parts of the context when they 
> aren't needed (such as object_r).  I tried this once but Steve convinced me 
> to revert it.  I am now thinking that perhaps we should review this matter.

I think the benifit of the _t and _r suffixes isn't so much to aid
to computer, but to make the policy more readable by the human user.

> In regard to the permissions on files, it was pointed out in a quite clear 
> fashion that standard Unix has 10 characters in the "ls -l" output to specify 
> the permissions.  Of course this is ignoring the user and group fields which 
> combined make it into a text representation almost as long as a security 
> context.  On my laptop the average length of security contexts I have in use 
> at the moment is 30.5 characters including the two ':' characters.  For unix 
> permissions it's 10, plus 5 for the group, plus <=8 for the user-name which 
> is 25 characters if we include two separators.

I think that the "standard" ls -l output is going to be less important
when 2.5.x is finally released with ACL support...

Which raises another interesting topic, that is 2.5.x supports attrs
(EAs) on ext2 and ext3 (at the minimum; I don't know about reiserfs),
maybe SE-Linux security contexts could be stored in attrs?
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
