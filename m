Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA21395
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 11:15:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA23726
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 15:13:47 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id PAA23721 for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 15:13:43 GMT
Date: Thu, 24 Oct 2002 17:15:35 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: New Apache policy
Message-ID: <20021024171534.A2792@lemuria.org>
References: <20021024160624.B2010@lemuria.org> <200210241643.38762.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210241643.38762.russell@coker.com.au>; from russell@coker.com.au on Thu, Oct 24, 2002 at 04:43:38PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 24, 2002 at 04:43:38PM +0200, Russell Coker wrote:
> The problem with PHP is that it requires giving the httpd_t domain more access 
> than you might otherwise want.

Yes, I know. I will work on a cgi version first and leave the module
version for later, when I feel comfortable with it.


> I am thinking of addressing this by having some macros file doing define() 
> statements for what functionality you want.  So you could do the following if 
> you want PHP:
> define(`use_http_php')

Absolutely, yes.



> Your comment about sysadm terminal access is inaccurate.  Apache2 should work 
> perfectly when started from system boot!

It seems to start up fine at boot. But I need it to work from run_init,
too. No good rebooting the machine each time you change some apache
config.



> I suggest using r_dir_file() for the config entries, it means 1 line of policy 
> instead of 3 and makes it easier to read.

Will do that.



> +# svn_t is the domain for the subversion client programs.
> +# svn_sysadm_t is the domain for the subversion client programs if run by the 
> sysadmin.
> 
> Why not use a macro for this as is done for the user_irc_t, user_ssh_t, etc?

I will check those out and see if I can use them.



> The thing to do with Postfix is to configure it to not use chroot.  I think 
> that configuring Postfix with chroot on SE Linux actually decreases security 
> as the types of the files for the chroot environment (which are re-copied at 
> every system boot) are difficult to manage.
> 
> If you have chroot with Postfix you will have to do MUCH more than 1 line of 
> changes to get it working properly!

Hm, weird. It seems to work just fine with this single line. But I'm
not really using it for now, so that may be the reason.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
