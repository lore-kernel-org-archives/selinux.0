Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA28096
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 02:09:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA28385
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 06:07:46 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id GAA28381
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 06:07:43 GMT
Date: Fri, 27 Sep 2002 16:09:05 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE-Linux packages
Message-ID: <20020927060905.GG15981@snoopy.apana.org.au>
References: <20020920022148.GA12250@snoopy.apana.org.au> <200209201747.53722.russell@coker.com.au> <20020924030750.GA28681@snoopy.apana.org.au> <200209241354.35906.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209241354.35906.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 24, 2002 at 01:54:35PM +0200, Russell Coker wrote:
 > However, there seem to be two policy errors, and I cannot see how to fix
> > them:
> >
> > 1. run_deb_t is defined twice; once in run_deb.te, and once in
> > dpkg.te (run_program macro).
> 
> run_deb.te should not exist any more.  The diff created by dpkg-buildpackage 
> seems to have problems with deleted files.

You will have to delete it in debian/rules I think.

Deleted files are not supported in the diff files for Debian packages.

Of course, it shouldn't fail if the files are already deleted.

> > 2. mailman_queue_gph_t is not defined but required by the su_mini_domain
> > macro.
> 
> I don't know the best way to solve this.  It would probably be best for you to 
> devise a solution as you use gnome-pty-helper, it's difficult for me to solve 
> problems that don't occur for me...

I could solve it, but I do not know what the original author was
intending.

For instance in su_macros.te,  su_mini_domain, it has:

ifdef(`gnome-pty-helper.te',
`allow $1_su_t $1_gph_t:fd use;
allow $1_t $1_gph_t:fd use;')

allow $1_su_t privfd:fd use;

# Write to utmp.
allow $1_su_t initrc_var_run_t:file rw_file_perms;

# Use the network.
can_network($1_su_t)
')dnl end su_mini_domain

Which immediately raises two concerns:

1. Why is gph_domain not used instead?

2. If I copy the following line to the top of su_mini_domain:

type $1_gph_t, domain, gphdomain;

I get duplicate symbols being defined.

I can only conclude that su_mini_domain is being called inconsistantly,
maybe sometimes it is called with a call to gph_domain, and sometimes it
is called instead of the call to gph_domain (pure speculation on my
part).
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
