Subject: Re: I have begun merging XWindows Controls into Rawhide.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200802262026.15197.russell@coker.com.au>
References: <47C2CBA1.5040807@redhat.com> <1203957368.32061.74.camel@gorn>
	 <47C32259.10505@tycho.nsa.gov>  <200802262026.15197.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 08:42:28 -0500
Message-Id: <1204033348.32061.168.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-26 at 20:26 +1100, Russell Coker wrote:
> On Tuesday 26 February 2008 07:17, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:

> > > This comes back to forthcoming effort for trying to use RBAC for role
> > > separation.  That would eliminate the structural complexity we see due
> > > to using TE for the role separation
> >
> > Is work being done on this?  I recall you said you were interested in
> > taking on this task.
> 
> Is this going to involve using roles on filesystem objects?  If not then how 
> would you distinguish the files created by different roles?

Yes, the plan is to use roles on objects.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
