Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9QIFeoj018131
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2007 14:15:40 -0400
Received: from web36604.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9QIFdfN003377
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2007 18:15:39 GMT
Date: Fri, 26 Oct 2007 11:15:34 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: What domain should the X server run in
To: russell@coker.com.au, casey@schaufler-ca.com
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200710270256.34064.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <239140.31261.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:

> On Saturday 27 October 2007 01:43, Casey Schaufler <casey@schaufler-ca.com> 
> wrote:
> > > Why would either option be easier for policy writing?  Getting both to
> > > work (as has currently been done) is tricky - and we have had repeated
> > > breakage along the way.  For ease of policy writing we would support
> > > exactly one of the options.
> > >
> > > I think that having the display manager start a new X server for each
> > > login will give the best result.
> >
> > That certainly has advantages, including making the object reuse
> > argument worlds simpler. In the Unix world it has been done both ways.
> > Some instances treated the X server as a user application.
> > Trix4.0.5epl, B1 evaluated, did it this way. Others made the X server a
> > policy enforcing mechanism, and ran it as a system process.
> 
> My recollection of playing with Trix some years ago is that it enforced
> policy 
> in the X server (and for full functionality required turning off some GL 
> features that would allow reading/writing outside window borders).

That was (maybe still is) Trix6.5. As the corporate coffers dwindled
the features included in the evaluation deminished and the windowing
environment, although included in the product, was not included in
the LSPP evaluation.

> > The important thing is that you have to decide if the X server is a
> > policy enforcing entity or if it is not. Once you've made that choice
> > it's pretty clear what you need to do. And who's going to get upset.
> 
> You make a good point about the conceptual design being clearer if you either
> 
> have the X server as a user application or as a policy enforcing system 
> service.
> 
> But it seems to me that the best result is to have it running on behalf of a 
> user but enforcing access control.  As an analogy consider a SETUID 
> application such as /bin/passwd, it has policy (or rather enforces policy 
> requested by the PAM configuration in a modern system) and is run by the user
> 
> but transitions to a context that has greater privs.

If you are counting on the program to make access control decisions
the analysis/assurance/trust required is the same regardless of the
runtime attributes of the process. That includes the analysis of the
SELinux policy. Once you have elevated the program to Security Enforcing
status everything about it has to be called into question. Running it
with limited privilege via capabilities, userid, or policy attributes
can help with the analysis, but it can't remove the analysis.

> We could of course have the password change operation on a Unix system be a 
> system service that a user connects to (I'm sure that I'm not the only person
> 
> to have written a CGI-BIN script to change passwords over https or something 
> conceptually similar).  There is nothing preventing a Unix system being 
> implemented with passwd, chfn, etc all talking over Unix domain sockets to a 
> privileged server process that does the work (it would probably be easier to 
> secure than the current way of doing things).

Believe it or not, the first Unix system to be evaluated under the
Orange Book scheme did exactly that, back in 1987. Gould C2. It was
a commercial failure because it didn't look enough like "real" Unix.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
