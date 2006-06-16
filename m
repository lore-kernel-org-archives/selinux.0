Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5GIgmYO001611
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 14:42:48 -0400
Received: from web36601.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k5GIgljX028384
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 18:42:47 GMT
Message-ID: <20060616184232.89055.qmail@web36601.mail.mud.yahoo.com>
Date: Fri, 16 Jun 2006 11:42:32 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: polyinstantiating /tmp and gdm
To: russell@coker.com.au, casey@schaufler-ca.com
Cc: janak@us.ibm.com, selinux@tycho.nsa.gov
In-Reply-To: <200606162333.47419.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:

> On Wednesday 14 June 2006 04:11, Casey Schaufler
> <casey@schaufler-ca.com> 
> wrote:
> > --- Russell Coker <russell@coker.com.au> wrote:
> > > Maybe a better option is to have the socket
> created
> > > under /var/run/.X11-unix
> >
> > Each of that daemons is going to have to
> > enforce (at least) MLS if you do this. While
> > this does make sense for the more sophisticated
> > programs (MLS X11 has been done, but my
> 
> You seem to be confusing separate issues here.

Wouldn't be the first time.

> Changing the directory used as the parent of the
> directory containing the 
> socket makes no difference.  In either case the
> directory needs to have a low 
> enough level that all the X programs can read it,
> and for both /tmp 
> and /var/tmp there's a range of SystemLow-SystemHigh
> so there's no issue in 
> that regard.

So long as the X server (or whatever server
you have) is policy enforcing this is true.
For SELinux there's a lot more to policy
than just MLS. My point is that if a process
in one domain can communicate with a process
in another domain through the server that's
Not Right.

If you put one .X11-unix in /var/run that
everyone opens the server must obtain the
security attributes explicitly for each client.
If you put a seperate .X11-unix in each
instance of /tmp you have the implicit
attributes found on the UDS.

... unless I missed the discussion wherein
/var/run was polyinstantiated, in which case
nevermind.

> As for the issue of making the X server
> enforce MLS, isn't that part of the 
> plan for security enhanced X?

One would expect. The X server for SELinux is
going to have to enforce the entire policy,
not just MLS to pass a CC evaluation. Ah,
the joy of application objects.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
