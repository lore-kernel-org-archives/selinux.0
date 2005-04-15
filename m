Date: Fri, 15 Apr 2005 09:38:12 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: serue@us.ibm.com, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'James Morris'" <jmorris@redhat.com>,
   selinux-dev@tresys.com, linux-audit@redhat.com
Subject: Re: dcache_lock deadlock due to auditing
Message-ID: <20050415143812.GA7261@sergelap.austin.ibm.com>
References: <200504141606.j3EG6S8R023875@gotham.columbia.tresys.com> <1113495337.373.166.camel@moss-spartans.epoch.ncsc.mil> <20050415130922.GA6231@sergelap.austin.ibm.com> <1113571702.3810.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1113571702.3810.30.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Fri, 2005-04-15 at 08:09 -0500, serue@us.ibm.com wrote:
> > Hi,
> > 
> > Just an update:  the testcases ran fine for 12 hours yesterday with
> > Stephen's patch.  They had to be stopped due to an unrelated reason, and
> > have been restarted today.
> 
> Good.  Below is an updated version of the same patch against 2.6.12-rc2;
> is this consistent with the patch that you have been testing aside from
> minor offset adjustments?

Yes, patch looks the same.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
