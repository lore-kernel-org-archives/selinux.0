Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UExMgn019410
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 10:59:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UExLkH011947
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 14:59:21 GMT
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need
	-Z?)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: russell@coker.com.au, bug-coreutils@gnu.org, selinux@tycho.nsa.gov
In-Reply-To: <87odmayiw0.fsf@rho.meyering.net>
References: <87tzw3x9mo.fsf@rho.meyering.net>
	 <200703302237.35950.russell@coker.com.au> <87odmayiw0.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 10:56:54 -0400
Message-Id: <1175266614.3102.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 15:13 +0200, Jim Meyering wrote:
> Russell Coker <russell@coker.com.au> wrote:
> > On Friday 30 March 2007 21:18, Jim Meyering <jim@meyering.net> wrote:
> >> Regarding the --context=C (-Z C) option that is now accepted by
> >> mkdir, mknod, mkfifo, and install, I am inclined to
> >
> > Currently mkdir, mknod, and mkfifo support a -m option to set the mode.
> > Install has options to also set the owner and group.
> 
> Hi Russell,
> 
> Thanks for the quick feedback.
> As implied here,
> 
>     http://www.redhat.com/archives/fedora-list/2006-August/msg02264.html
> 
> I agree that one should be able to get the effect you want.  However,
> adding a -Z option to each and every affected program is not the only way.
> 
> What did you think of the proposal (in the link above) for
> 
>     fscon CTX mkdir /new/directory
> 
> IMHO, it's not so much less "user friendly" than this equivalent:
> 
>     mkdir -C CTX /new/directory
> 

I still think that this is problematic from a user perspective (in
addition to the implementation issues). It is not as much the
complication of using the command - though that is not ideal. It is more
that I think it will be much harder for the user to find fscon than an
option if they do not know that they exist.

If there are some selinux options in coreutils it would be natural for a
user to look for other options to accomplish what you want. In this case
I don't think that most users would, upon not finding an option, think
to look for a completely separate tool.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
