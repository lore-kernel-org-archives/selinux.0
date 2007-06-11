Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BLhqQc012408
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 17:43:52 -0400
Received: from web36608.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BLholu024926
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 21:43:51 GMT
Date: Mon, 11 Jun 2007 14:43:50 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
To: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <20070611204336.GA30846@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <620792.60154.qm@web36608.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > Extend SELinux to allow capabilities to be granted authoritatively.
> > Introduces a new cap_override access vector to indicate when the
> > secondary module (i.e. capability or dummy) check should be skipped.
> > Handle the new class gracefully even if the policy does not yet have
> > it defined.
> 
> Cool.
> 
> If we decide to have this take the place of the file capabilities i
> guess we're all set, but if both are going upstream, do you think
> CONFIG_SECURITY_FILE_CAPABILITIES and selinux should be mutually
> exclusive?

We're already living in a non-stacking LSM environment, so whatever
SELinux wants to do with capabilities is Stephen's affair, I suppose.
I assume that this is in preparation for file based capabilities
and dealing with interactions with them. My only concern is that you
seem to be sneaking around the "additional restrictions" LSM model,
with the justification being that the bit you're taking authority over
is also an LSM module. I am not convinced that you're completely
within the spirit of the thing, although I would hesitate to accuse
you of not playing nicely quite yet.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
