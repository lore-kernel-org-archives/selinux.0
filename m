Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i436XIRb003278
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 02:33:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i436V4Zx027257
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 06:31:04 GMT
Received: from mars.sisgroup.com.au (mars.sisgroup.com.au [202.155.174.40])
	by jazzswing.ncsc.mil  with ESMTP id i436V2Jv027226
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 06:31:03 GMT
Received: from amavis (localhost [127.0.0.1])
	by postoffice.sisgroup.com.au (Postfix) with ESMTP id D8A6C4ED28
	for <selinux@tycho.nsa.gov>; Mon,  3 May 2004 16:32:50 +1000 (EST)
Received: from postoffice.sisgroup.com.au ([127.0.0.1])
	by amavis (ares [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10917-02 for <selinux@tycho.nsa.gov>;
	Mon, 3 May 2004 16:32:50 +1000 (EST)
Date: Mon, 3 May 2004 16:32:50 +1000
From: kris-selinux@sisgroup.com.au
To: selinux@tycho.nsa.gov
Subject: Re: preserving user-set contexts
Message-ID: <20040503063250.GB4354@ares.sisgroup.com.au>
References: <1082752649.12608.111.camel@nexus.verbum.private> <1082989812.22940.43.camel@moss-spartans.epoch.ncsc.mil> <1083116682.3390.34.camel@nexus.verbum.private> <1083152961.25987.20.camel@moss-spartans.epoch.ncsc.mil> <1083157990.8370.19.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1083157990.8370.19.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 28, 2004 at 09:13:10AM -0400, Colin Walters wrote:
> > >   For the
> > > httpd_user_content_t problem, we could add an attribute e.g.
> > > "customizable_type".  setfiles would by default not relabel that have
> > > this type.
> > 
> > And how do you control the ability to set this attribute?
> 
> Ah, sorry; I meant a SELinux policy attribute, not an xattr.  So
> checkpolicy could gather these and perhaps write out a separate
> "customizable_types" file.  setfiles would parse this and by default not
> relabel files with one of these types.
> 
possibly a more restrictive setup with pairs of types where setfiles
will not relabel a file to the target type if it's current source type
is an allowed variant.  i.e. (From the Debian policy which I'm not
actually using so I might be getting this very wrong...)

	httpd_user_script_ro_t  ->  httpd_user_content_t
	httpd_user_script_rw_t  ->  httpd_user_content_t
	httpd_user_script_ra_t  ->  httpd_user_content_t

then any file covered by a regexp for httpd_user_content_t will not be
relabelled if it's current type is httpd_user_script_r[oaw]_t;

-- 
Kris Shannon <kris@sisgroup.com.au>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
