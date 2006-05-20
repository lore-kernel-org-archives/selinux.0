Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4K03UP9020006
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 20:03:31 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4K03PfP021276
	for <selinux@tycho.nsa.gov>; Sat, 20 May 2006 00:03:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: fc5 policy patch
Date: Sat, 20 May 2006 10:03:06 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200605200005.12042.russell@coker.com.au> <446DDF0E.2080803@redhat.com>
In-Reply-To: <446DDF0E.2080803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605201003.09975.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 20 May 2006 01:06, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> > Attached is a patch against policy 2.2.38-1.fc5, the most significant
> > thing it does is to get Amavis and Clamav working.
> >
> > I notice that Dan has just sent a patch against the rawhide policy to the
> > list with a slightly different set of Amavis changes.  Without reviewing
> > them carefully it seems to me that Dan's patch won't make a default
> > fedora-extras anti-virus system work.  Some of the things that are done
> > with the fedora-extras packages aren't optimal in regard to SE Linux
> > (such as the locations of some of the PID files and socket files).
> >
> > My patch makes the anti-virus setup basically work.  Due to the
> > complexity of the system there is a possibility of corner cases that I've
> > missed, but the only way we will discover that is to get this policy
> > released and have people try it.
>
> See questions in the patch.
>
> > ------------------------------------------------------------------------
> >
> > diff -ru serefpolicy-2.2.38.orig/policy/modules/services/amavis.fc
> > serefpolicy-2.2.38/policy/modules/services/amavis.fc ---
> > serefpolicy-2.2.38.orig/policy/modules/services/amavis.fc	2006-05-08
> > 23:54:01.000000000 +1000 +++
> > serefpolicy-2.2.38/policy/modules/services/amavis.fc	2006-05-19
> > 23:36:05.000000000 +1000 @@ -7,5 +7,7 @@
> >  /var/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
> > 
> > /var/lib/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0
> >)
> > /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,
> >s0)
> > -/var/run/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_run_t,s
> >0) +/var/run/amavis(d)?/amavisd.lock
> > --	gen_context(system_u:object_r:amavis_var_run_t,s0)
>
> Why would you make this change?  Why not
>
> -/var/run/amavisi(d)?(/.*)?			gen_context(system_u:object_r:amavis_var_run_
>t,s0)

As mentioned above the Fedora Extras packages are doing some sub-optimal 
things, one of these is having the clamd.amavisd program use 
the /var/run/amavisd directory for it's pid file.  Allowing clamd_t to write 
to a directory of type amavis_var_run_t seems to provide little benefit and 
some extra pain, and we have Unix permissions to provide some protection on 
access to that directory.

> > /var/run/clamav(/.*)?			gen_context(system_u:object_r:clamd_var_run_t,s0)
> > /var/run/clamav/clamd.ctl	-s	gen_context(system_u:object_r:clamd_sock_t,s
> >0)
> > +/var/run/amavis(d)?/clamd.pid	--	gen_context(system_u:object_r:clamd_var
> >_run_t,s0)
>
> This looks like a bug?

That is of course a matter of opinion.  The Unix-only people would say that 
two processes in the same UID should share the same directory, it's only for 
SE Linux that we would want a different directory.


Policy evolves, and we will revisit these issues at some future time.  
Packages change too, the Amavis and Clamav packages will hopefully change a 
few things in this regard.  But in the mean time the policy as I provided 
works reasonably well.

I guess that one thing we might consider is merging the clamd_t and amavis_t 
domains, the people who wrote them seem to think that they don't need to be 
protected from each other...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
