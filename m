Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA28954
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 06:55:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA06878
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 10:53:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA06874
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 10:53:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: SE-Linux packages
Date: Fri, 27 Sep 2002 12:54:48 +0200
Cc: selinux@tycho.nsa.gov
References: <20020920022148.GA12250@snoopy.apana.org.au> <200209241354.35906.russell@coker.com.au> <20020927060905.GG15981@snoopy.apana.org.au>
In-Reply-To: <20020927060905.GG15981@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200209271254.48690.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Sep 2002 08:09, Brian May wrote:
> On Tue, Sep 24, 2002 at 01:54:35PM +0200, Russell Coker wrote:
>  > However, there seem to be two policy errors, and I cannot see how to fix
>  >
> > > them:
> > >
> > > 1. run_deb_t is defined twice; once in run_deb.te, and once in
> > > dpkg.te (run_program macro).
> >
> > run_deb.te should not exist any more.  The diff created by
> > dpkg-buildpackage seems to have problems with deleted files.
>
> You will have to delete it in debian/rules I think.
>
> Deleted files are not supported in the diff files for Debian packages.
>
> Of course, it shouldn't fail if the files are already deleted.

It doesn't really matter though.  This is only a problem for you and I at the 
moment.  The auto-builders aren't building the packages due to compilation 
errors.  If someone builds their own package they can still decide to remove 
that file after installing the package and get a working system.

I expect that a new upstream release isn't too far off, Steve has just 
released a patch for a new policy version and I'm sure he'll want to get that 
officially released soonish...

> > > 2. mailman_queue_gph_t is not defined but required by the
> > > su_mini_domain macro.
> >
> > I don't know the best way to solve this.  It would probably be best for
> > you to devise a solution as you use gnome-pty-helper, it's difficult for
> > me to solve problems that don't occur for me...
>
> I could solve it, but I do not know what the original author was
> intending.

The intention is for minimal su functionality in the mini-domain.

> For instance in su_macros.te,  su_mini_domain, it has:
>
> ifdef(`gnome-pty-helper.te',
> `allow $1_su_t $1_gph_t:fd use;
> allow $1_t $1_gph_t:fd use;')

I've moved the above out of the minidomain.

I've put the result on http://www.coker.com.au/selinux/policy.tgz let me know 
if it works.

> 1. Why is gph_domain not used instead?

I don't know.  I've never done anything with gph stuff apart from copy other 
people's policy around.  You are probably the best person to sort these 
things out as you are the most active gph-SE user who's not totally busy on 
other things.

> 2. If I copy the following line to the top of su_mini_domain:
>
> type $1_gph_t, domain, gphdomain;
>
> I get duplicate symbols being defined.

That's not the right approach.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
