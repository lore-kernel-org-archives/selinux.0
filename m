Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5DIWbrT014390
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 14:32:37 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5DIWVP2012790
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 14:32:31 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 13 Jun 2004 18:32:30 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BZZ9g-0002GN-OW
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 17:52:28 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BZZjn-00076p-E5
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 18:29:47 +0000
Date: Sun, 13 Jun 2004 18:29:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040613182947.GF26207@lkcl.net>
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain> <200406131029.35825.russell@coker.com.au> <20040613012852.GA4210@yggdrasil.localdomain> <20040613075427.GZ2861@lkcl.net> <20040613154033.GA10171@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040613154033.GA10171@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 13, 2004 at 10:40:33AM -0500, Greg Norris wrote:
> On Sun, Jun 13, 2004 at 07:54:27AM +0000, Luke Kenneth Casson Leighton wrote:
> > if i was you i would, as i said, delete the original install and
> > use russell's 1.12-3 policy.
> 
> That's the exact version I'm using already... this was a new
> installation, and 1.12-3 had already hit the archive by the time I
> first attempted it.
 
 i haven't tried 1.12-3, i have 1.12-1 with several modifications / 
 nasty hacks to get things to work to the best of my limited knowledge
 at this point.

 if you're feeling brave i can send you what i have, you could
 always try putting it as /usr/share/selinux/policy/lkcl-braindead
 and then ln -s /etc/selinux to that.

 
> I did try purging and re-installing last night, but that didn't seem to
> change anything.  I'll go ahead and give it another shot, in case I
> overlooked some cleanup.  

 check /var/lib/dpkg/info/*.list for the set of files recorded.

 remember also to set things up with "enforcing=0" which is the
 default _before_ switching over to enforcing=1.

 l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
