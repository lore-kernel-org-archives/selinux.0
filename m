Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
In-Reply-To: <Xine.LNX.4.64.0709201414120.16685@us.intercode.com.au>
References: <1188340501.11528.14.camel@localhost.localdomain>
	 <46D4F337.1030704@manicmethod.com>
	 <1188382494.6129.35.camel@localhost.localdomain>
	 <1190230883.7323.3.camel@localhost.localdomain>
	 <1190235840.25863.98.camel@moss-spartans.epoch.ncsc.mil>
	 <1190252058.7323.33.camel@localhost.localdomain>
	 <1190293949.12553.23.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0709201414120.16685@us.intercode.com.au>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 10:13:04 -0400
Message-Id: <1190383984.11091.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-20 at 14:16 -0700, James Morris wrote: 
> On Thu, 20 Sep 2007, Stephen Smalley wrote:
> 
> > Don't worry about conflicts with pending patches; just make a clean
> > patch (where a clean patch follows the usual guidelines and doesn't
> > include commented-out code) against some well-defined baseline (linus,
> > mm, or selinux.git).  Using the for-akpm branch of selinux.git makes it
> > easier for James to merge of course, but as -mm includes that branch, it
> > should be the same except as other patches in mm might happen to overlap
> > and except as one happens to lag behind the other.
> 
> Generally, a patch against the latest Linus git will work fine, as that is 
> what -mm is against, and if there are conflicts, they need to be resolved 
> there anyway.

OK.  Thank you for clarifying the process.  As I still need to post the LIM
patches based on the -mm tree to LKML, for this iteration the SELinux integrity
patch will also be against the latest -mm.  Once we are further along in the 
process, when the LIM patches are back in -mm, I will post a git compatible 
SELinux integrity patch.

Mimi Zohar


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
