Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8NNjpsJ015841
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 19:45:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8NNjo2R027270
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 23:45:50 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h8NNjm1A027267 for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 23:45:49 GMT
Date: Wed, 24 Sep 2003 09:47:00 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Some minor thoughts on syntax/semantics
Message-ID: <20030923234700.GA16193@snoopy.apana.org.au>
References: <20030923150926.GG21997@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030923150926.GG21997@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 23, 2003 at 04:09:27PM +0100, Dale Amon wrote:
> There seems to be a bit of mental gymnastics involved
> in reading allow statements. They are written like this:
> 
> allow  this_t   that_t:class  {this that and the other};
> 
> but semantically we want to think of it as:
> 
> "Allow a domain this_t to do {this that and the other} 
> from something like that_t:class"
> 
> So I wonder if there was a reason you didn't go for
> a similar syntax, eg
> 
> allow  this_t {this that and the other}  that_t:class;

Personally I read it as "Allow <src_type> to access <dest_type> using
these <operations>."

I consider this similar to object orientated style with C++, Java,
Perl, or PHP languages where you say:

object->method

Not that I am justifying the decisions behind the current syntax (I
wasn't involved), but I don't have any problem with current order of the
parameters.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
