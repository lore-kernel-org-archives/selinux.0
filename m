Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAFHX1TR029148
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 12:33:01 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAFHWFcx006684
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 17:32:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Latest Diffs
Date: Thu, 16 Nov 2006 04:33:06 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <453E2A8C.4070207@redhat.com> <200611152049.38615.russell@coker.com.au> <455B18AE.6050901@redhat.com>
In-Reply-To: <455B18AE.6050901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611160433.09138.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 16 November 2006 00:39, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > I think it's best if Red Hat compiles just don't include dpkg.te.
> >
> > Have apt-get and yum run in the same context in Fedora.
>
> That is the way it is now, but it is unacceptable to upstream.  Chris
> does not like the conflicting
> file context.

There is no conflict if rpm.te and dpkg.te are never included in the same 
build.

Having a one-line .fc supposed conflict (it's not a conflict if the two .fc 
files in question are never used at the same time) is much better than 
massively hacking up an entire .te file.

> >>>> squid wants to rw_tmpfs for diskd mode.
> >>>
> >>> I'm wondering if this is tmpfs_t because there is no squid_tmpfs_t+type
> >>> transition, or if it is because the machine is targeted.
> >>
> >> Not sure, this was in the old policy as well.  Never used squid.
> >
> > I believe that it was a mistake in the Squid policy.
>
> I have just recently received an AVC requiring it, which is why I put it
> back.

Do you have any more information?  If the user is doing something odd like 
using tmpfs for squid backing store then it's not something we want to 
support in policy in that manner.  Maybe we could have restorecon run on the 
Squid spool directory to cater for the case of using tmpfs for it if people 
want to do that.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
