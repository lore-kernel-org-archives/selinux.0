Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JEVei1006489
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:31:40 -0400
Received: from purple.iano.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JEVdfP017077
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:31:39 GMT
Date: Fri, 19 May 2006 10:31:27 -0400
From: Maria Iano <maria@iano.org>
To: Russell Coker <russell@coker.com.au>
Cc: Erich Schubert <erich@debian.org>, selinux@tycho.nsa.gov
Subject: Re: correct way to set context in perl?
Message-ID: <20060519103127.A26098@iano.org>
References: <20060518160656.V26098@iano.org> <1147985248.3617.2.camel@wintermute.xmldesign.de> <20060518171245.Y26098@iano.org> <200605192357.39325.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200605192357.39325.russell@coker.com.au>; from russell@coker.com.au on Fri, May 19, 2006 at 11:57:35PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I agree. Nobody actually needs to deal with the individual files anyway - it's all done by scripts through a web interface. It was just a convenience for me to have the groups of domains all separate. I've decided to move all the zones into the more traditional structure of having all masters under a master directory and all slaves under a slave directory. This will mean that the scripts automatically create the files with the correct types. It will make a directory listing slower but that's not a big deal.

So for now I don't need to know the best approach to have a perl script set the security context of a file. I would guess that I will need to do it at some point in the future - if not for this application then for something else. I would really appreciate if someone could help me understand the best approach for this. Is it best to design and code to avoid having to do it (as in this case where I redesigned the directory structure)? If so, I'd like to know why.

Thanks,
Maria
 
On Fri, May 19, at 11:57%P so wrote Russell Coker (russell@coker.com.au):

> On Friday 19 May 2006 07:12, Maria Iano <maria@iano.org> wrote:
> > Thanks for your response. The master and slave directories are separate.
> > The zones are divided into over a hundred different groups (and growing).
> > Individual users have access to edit zones in some groups and not others.
> > Each group has its own directory. Under each group's directory are the
> > master and slave directories. As new groups are created (by the perl
> > scripts), new directories need to be created (as well as new files) and I
> > need to be able to give them the correct security contexts, and there will
> > be two different types under each group directory.
> 
> Why would each group require a separate slave directory?
> 
> The only reason why a user might need direct access to the slave directory is 
> to read files (for converting a slave into a master) and to unlink files 
> (after removing them from the BIND configuration).
> 
> Given that DNS data is essentially public allowing all groups to read each 
> other's data is not going to do any harm.  Also as the data is regenerated as 
> needed and always kept fresh the unlink problem can be solved by a cron job 
> that runs once per month and deletes old slave files.
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
