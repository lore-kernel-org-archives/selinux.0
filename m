Subject: Re: dumb newbie questions
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1119278717.30000.10.camel@rodan.ncc.com>
Mime-Version: 1.0
Date: Mon, 20 Jun 2005 09:45:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-19 at 23:45, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 19 Jun 2005 22:34:47 CDT, "R. Steven Rainwater" said:
> perl -e 'print "Hello World!\n"'
> 
> doesn't generate any AVCs on my system when run as a normal
> user.  So that's a straw man.

I quoted the source of my one line perl test script and error message it
generated in a previous post. It doesn't run on my system, which is
using CentOS 4.1. All my scripts have been working fine on a non-selinux
box. I'm not writing any new scripts (other than the one line test
script), just trying to move an existing website and associated scripts
to an selinux box. Some of the perl scripts run fine, other don't run at
all, generating the avc errors. See my previous post for the details.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
