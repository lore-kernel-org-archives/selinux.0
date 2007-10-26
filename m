From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: casey@schaufler-ca.com
Subject: Re: What domain should the X server run in
Date: Sat, 27 Oct 2007 02:56:29 +1000
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <440116.95399.qm@web36605.mail.mud.yahoo.com>
In-Reply-To: <440116.95399.qm@web36605.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710270256.34064.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 27 October 2007 01:43, Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> > Why would either option be easier for policy writing?  Getting both to
> > work (as has currently been done) is tricky - and we have had repeated
> > breakage along the way.  For ease of policy writing we would support
> > exactly one of the options.
> >
> > I think that having the display manager start a new X server for each
> > login will give the best result.
>
> That certainly has advantages, including making the object reuse
> argument worlds simpler. In the Unix world it has been done both ways.
> Some instances treated the X server as a user application.
> Trix4.0.5epl, B1 evaluated, did it this way. Others made the X server a
> policy enforcing mechanism, and ran it as a system process.

My recollection of playing with Trix some years ago is that it enforced policy 
in the X server (and for full functionality required turning off some GL 
features that would allow reading/writing outside window borders).

> The important thing is that you have to decide if the X server is a
> policy enforcing entity or if it is not. Once you've made that choice
> it's pretty clear what you need to do. And who's going to get upset.

You make a good point about the conceptual design being clearer if you either 
have the X server as a user application or as a policy enforcing system 
service.

But it seems to me that the best result is to have it running on behalf of a 
user but enforcing access control.  As an analogy consider a SETUID 
application such as /bin/passwd, it has policy (or rather enforces policy 
requested by the PAM configuration in a modern system) and is run by the user 
but transitions to a context that has greater privs.

We could of course have the password change operation on a Unix system be a 
system service that a user connects to (I'm sure that I'm not the only person 
to have written a CGI-BIN script to change passwords over https or something 
conceptually similar).  There is nothing preventing a Unix system being 
implemented with passwd, chfn, etc all talking over Unix domain sockets to a 
privileged server process that does the work (it would probably be easier to 
secure than the current way of doing things).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
