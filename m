Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9QFhrfe000487
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2007 11:43:53 -0400
Received: from web36605.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l9QFhnh3002009
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2007 15:43:49 GMT
Date: Fri, 26 Oct 2007 08:43:48 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: What domain should the X server run in
To: russell@coker.com.au, Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200710262252.31838.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <440116.95399.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:

> On Friday 26 October 2007 03:27, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> > Is the X server part of the user's session or not?
> 
> It probably would be best to have the X server run in a domain specific to
> the 
> user.  Even without the domain-type issues if we want to use labelled 
> networking to control access to X servers (let's not assume there is a strict
> 
> 1:1 mapping of X servers to user sessions) in a MLS/MCS environment then 
> having an X server instance per user makes sense.
> 
> > If it is, then it should always run as user_xserver_t, and the display
> > managers should be "fixed" to label the X server with the user's context
> > at login time.
> >
> > It if isn't, then it should always run in the same domain, and
> > startx/xinit should be "fixed" to transition into this context.
> >
> >  From my perspective I would favor the latter option for now since it's
> > easier to write policy for.  The user's individual windows can be
> > labeled with a per-user type, maintaining separation.
> 
> Why would either option be easier for policy writing?  Getting both to work 
> (as has currently been done) is tricky - and we have had repeated breakage 
> along the way.  For ease of policy writing we would support exactly one of 
> the options.
> 
> I think that having the display manager start a new X server for each login 
> will give the best result.

That certainly has advantages, including making the object reuse
argument worlds simpler. In the Unix world it has been done both ways.
Some instances treated the X server as a user application.
Trix4.0.5epl, B1 evaluated, did it this way. Others made the X server a
policy enforcing mechanism, and ran it as a system process.

The important thing is that you have to decide if the X server is a
policy enforcing entity or if it is not. Once you've made that choice
it's pretty clear what you need to do. And who's going to get upset.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
