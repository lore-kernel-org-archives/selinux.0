Subject: Re: can't start X window in enforce mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Michael Reilly <michaelr@cisco.com>, lky <lky77@sjtu.edu.cn>,
   SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <200310131752.11106.russell@coker.com.au>
References: <000901c390ef$d8b3c770$5d38a8c0@lky>
	 <3F89E077.9030802@cisco.com>  <200310131752.11106.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066143647.5054.178.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 11:00:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-13 at 03:52, Russell Coker wrote:
> On Mon, 13 Oct 2003 09:15, Michael Reilly wrote:
> > I had both problems.  I added the dontaudit memory devices
> > as mentioned in the file macros/program/xserver_macros.te.
> >
> > I have the second problem and have not yet solved it.  Nothing is logged
> > and I cannot figure out what is wrong.
> 
> Try doing
> grep -v dontaudit policy.conf > new-policy
> mv new-policy policy.conf
> 
> Then load the policy and see what happens.

There should likely be a policy Makefile target to generate and load
a policy that does not suppress any auditing.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
