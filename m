Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1RAclDo019863
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 05:38:48 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1RAXIVe028593
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 10:33:18 GMT
Date: Sun, 27 Feb 2005 10:45:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: RFE: inheritance
Message-ID: <20050227104528.GC28871@lkcl.net>
References: <1109400342.4581.25.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1109400342.4581.25.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Feb 26, 2005 at 01:45:42AM -0500, Ivan Gyurdiev wrote:

> The Java problem is not solved yet.
> The problem is that:
> - Java needs its own domain due to legacy requirements
> - Java should get all the permissions granted to user_t, since
> it's a programming language, not an application to be confined.
> - Calling base_user_macro($1_java_t) will not work IMHO.
> 
> Additionally, I've been looking for a way to inherit 
> from multiple types for a while. I posted about this
> some time ago re: sharing data between samba and httpd.
> It would be nice if there was an easy way to combine 
> the rules for several domains. Somebody wrote a perl script
> about this, but I'm not sure what happened to that.
> 
> So, would it be possible to implement macros like 
> INHERIT_SOURCE( { type 1, type 2, type 3 }, { new_type1, new_type2 })
> INHERIT_TARGET( { type 1, type 2, type 3 }, { new_type1, new_type2 })
> 
> that post-process the policy, and do the following:
 
 an object-orientated meta-macro, that does the work for you.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
