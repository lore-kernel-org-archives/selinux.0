Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12CAP53021611
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 07:10:26 -0500 (EST)
Subject: Re: File Browsing apps and getattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107301148.3429.10.camel@cobra.ivg2.net>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
	 <1107264384.6956.2.camel@cobra.ivg2.net>
	 <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1107283354.7117.13.camel@cobra.ivg2.net>
	 <1107287529.26936.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1107301148.3429.10.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107345834.890.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 07:03:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 18:39, Ivan Gyurdiev wrote:
> On Tue, 2005-02-01 at 14:52 -0500, Stephen Smalley wrote:
> > On Tue, 2005-02-01 at 13:42, Ivan Gyurdiev wrote:
> > > Would it be acceptable to have dontaudit getattr on dir_file_class_set
> > > for file browsing applications. I currently have a rule like that in the
> > > mplayer policy? If not, how would you suggest the denials be suppressed?
> > 
> > I think we want to avoid suppressing the audit for all file types, i.e.
> > not use file_type by itself.  Possibly a file_type - security_type as
> > per Dan's suggestion.  Also, we may be able to legitimately add
> > permission for some of these types, possibly adding usercanread to them,
> > but it just requires a case-by-case review.
> 
> But the audit message can be triggered by legitimate usage (ls -l /etc,
> ls -l /var). It doesn't make sense to me to log legitimate usage of a
> program as an error. 

etc_t and var_t are unlikely to fall under "security_type", so file_type
- security_type would cover them.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
