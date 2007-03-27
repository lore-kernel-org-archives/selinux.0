Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2RE4t6C025989
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 10:04:55 -0400
Received: from web86904.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2RE4qfK019336
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 14:04:53 GMT
Message-ID: <20070327140452.56698.qmail@web86904.mail.ukl.yahoo.com>
Date: Tue, 27 Mar 2007 15:04:52 +0100 (BST)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Error in installing RefPolicy possibly some conflict?
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1175003270.3864.309.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the reply.

I am using Fedora core 6. Prior to installing
refpolicy, there was no source code avialable in the
/etc/selinux/... for SELinux policy, making it hard
for me to experiment with refpolicy modules.

Therefore, i installed, refpolicy sources and tried to
follow the way, given on the teresys website for
making and installing a refpolicy module. 

While doing so, i installed alot of other softwares,
like APOL, seedit in the hope to get refpolicy
running.

If you can kindly give me an exmaple, for running
refpolicy with default fedora core 6 distribution.

Thanks.
MA






--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2007-03-27 at 14:35 +0100, JanuGerman wrote:
> > Hi Every one,
> > 
> > I am getting the following error message, while
> trying
> > to install Refpolicy. If some one can help me,
> prior
> > to this, i installed refpolicy, but at startup,
> the
> > system hanged. The output is trancated, and only
> the
> > final part, which creates the problem is copied
> here
> > for reference purposes.
> 
> What distribution are you using as your base?  The
> distributions that
> have SELinux support (Debian, Fedora, Gentoo, RHEL)
> already include
> reference policy, so you don't need to rebuild it
> from scratch unless
> you are making major changes.
> 
> Did you just use the defaults for
> policy/modules.conf (i.e. generated
> via make conf) and for build.conf settings?  In the
> latter case, you
> need to set the build.conf settings appropriately
> whether by editing
> that file or by specifying new values on the make
> command line. 
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 



	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
