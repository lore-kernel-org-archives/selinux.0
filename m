Subject: Re: [RFC][PATCH] collect security labels on user
	processes	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
   James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <200602151141.42778.sgrubb@redhat.com>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <200602151122.37945.sgrubb@redhat.com>
	 <1140021440.14253.411.camel@moss-spartans.epoch.ncsc.mil>
	 <200602151141.42778.sgrubb@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 10:58:13 -0600
Message-Id: <1140022693.11804.41.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-15 at 11:41 -0500, Steve Grubb wrote:
> On Wednesday 15 February 2006 11:37, Stephen Smalley wrote:
> > > It creates parsing problems without a value. If I saw "tty="  and that's
> > > all, I'd think the audit system malfunctioned and file a bugzilla. I
> > > don't want that.
> >
> > OTOH, if I see (null), I tend to assume a bug in the code.  Isn't it
> > saner to just omit the name=value pair altogether if the value is NULL?
> 
> No, cause then I have non-normalized records.
> 
> > Otherwise, you are adding extra processing on the generation and parsing
> > side for no benefit, along with wasting space in the audit message.
> 
> There is a benefit...no missing fields means that the record is normalized. 
> This is a required step before we create a binary format record. 
> 
> There are performance benefits in the kernel as well as user space. The kernel 
> doesn't have to have an "if" statement with 2 nearly identical calls to 
> audit_log_format or 2 back to back calls to the same function adding a new 
> piece of info. 
> 
> In userspace, I can parse it faster since I don't have to backtrack and 
> re-parse from the last good token to look for the next field after deciding 
> one is missing.
> 
> -Steve

Steve,

I agree with you.  Also, we could have 'ausearch' interpret a (null)
differently depending on token.  So perhaps an ausearch on a record
where subj=(null), would return subj=disabled.

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
