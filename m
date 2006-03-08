Date: Wed, 8 Mar 2006 10:23:52 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage/src/semanage_store.c:semanage_split_fc
Message-ID: <20060308162352.GA26769@sergelap.austin.ibm.com>
References: <20060306221519.GA25033@sergelap.austin.ibm.com> <440CE9FF.2090201@cornell.edu> <1141830301.6157.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141830301.6157.82.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Mon, 2006-03-06 at 21:03 -0500, Ivan Gyurdiev wrote:
> > Serge E. Hallyn wrote:
> > > In semanage_split_fc(), linex 887 and 893, the file_con fd is not closed
> > > on error.  Trivial patch follows.
> > >
> > >   
> > There's already a cleanup: goto target, I think that should be used instead
> > (after initializing the file descriptors, and making the close 
> > statements conditional).
> > 
> > It'd be nice if close(-1) and fclose(NULL) were no-ops.
> 
> Like this?

Agreed, looks far more maintainable.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
