Subject: Re: [PATCH] pam_namespace : allow use of X while polyinstantiating
	/tmp - v3
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: Tomas Mraz <tmraz@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, dwalsh@redhat.com, sgrubb@redhat.com,
        klaus@atsec.com, sds@tycho.nsa.gov, russell@coker.com.au,
        selinux@tycho.nsa.gov
In-Reply-To: <1150965442.3351.7.camel@perun.kabelta.loc>
References: <1150820592.31280.2.camel@localhost.localdomain>
	 <200606220735.k5M7ZOUI016994@turing-police.cc.vt.edu>
	 <1150965442.3351.7.camel@perun.kabelta.loc>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 13:54:59 -0400
Message-Id: <1150998899.30134.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-22 at 10:37 +0200, Tomas Mraz wrote:
> On Thu, 2006-06-22 at 03:35 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 20 Jun 2006 12:23:12 EDT, Janak Desai said:
> > > This patch updates pam_namespace to allow the use of graphical display
> > > manager while polyinstantiating /tmp. It applies on top of the 06/18/06
> > > version of pam_namespace (pam-0.99.4.0-5.src.rpm) in rawhide. 
> > 
> > I hit another bug...
> > 
> > > diff -Naurp pam_namespace0620/modules/pam_namespace/pam_namespace.c pam_namespace0620+patch/modules/pam_namespace/pam_namespace.c
> > > --- pam_namespace0620/modules/pam_namespace/pam_namespace.c	2006-06-20 14:49:34.000000000 +0000
> > > +++ pam_namespace0620+patch/modules/pam_namespace/pam_namespace.c	2006-06-20 14:49:44.000000000 +0000
> > ....
> > 
> > > @@ -776,12 +778,19 @@ static int create_dirs(const struct poly
> > >       * directory as arguments.
> > >       */
> > >  
> > > +inst_init:
> > > +    osighand = signal(SIGCHLD, SIG_DFL);
> > > +    if (osighand == NULL) {
> > > +        pam_syslog(idata->pamh, LOG_ERR, "Cannot set signal value");
> > > +        return PAM_SESSION_ERR;
> > > +    }
> > > +
> > 
> > Of course, SIG_DFL and NULL are both zero - which means this throws an
> > error if we try to set it to SIG_DFL and it already *was*.  I suspect
> > the 'if' condition should be:
> > 
> > 	if (osighand == SIG_ERR) {
> Of course it should be compared to SIG_ERR and not NULL. Thanks for
> finding this.

Yes, thanks for find this and other problems. I was using pam_unix
sources to see how signal handlers are managed by pam modules. It too
takes non-NULL return values as good previous signal handler value. I
should have looked at the man page as well.

Tomas, should I send a patch with just this change or the create a
v4 version of the patch? I am going to be unavailable in about an hour
so I can do this on Monday.

-Janak


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
