Subject: Re: new user domain (FC3)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: Holger Burde <hburde@t-online.de>, SELinux@tycho.nsa.gov
In-Reply-To: <200503041845.j24Ijqb2016599@turing-police.cc.vt.edu>
References: <1109945251.5546.12.camel@marvin.warpnet.com>
	 <200503041845.j24Ijqb2016599@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 09:22:47 -0500
Message-Id: <1110205367.29984.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-03-04 at 13:45 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 04 Mar 2005 15:07:30 +0100, Holger Burde said:
> > Hi;
> > 
> > I am looking for Infos on how to add new user domains to the FC3
> > targeted Policy. Any examples/papers available ? The only example 
> > one i found depends on a user.te file in $SEHOME/domains which is not
> > available in FC3-targeted (examples based on that do not work).
> 
> New user domains won't work in -targeted because the whole idea of targeted is
> "dump all 'real' users in -unrestricted_t and only really enforce on some of
> the daemon_t types".  You need  to run -strict to have the separation needed
> to make multiple user domains make any sense at all..

Right.  Also, note that -strict does include an unconfined_t domain as
well, so you can put specific daemons and applications into it if you
truly want that, so it is easier to start with -strict and "unprotect"
specific programs if you want user domains + some program domains than
to add user domains to -targeted.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
