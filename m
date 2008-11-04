Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA4LTbIB031894
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2008 16:29:37 -0500
Subject: Re: SELinux on NFS.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <1225830495.30407.48.camel@heimdal.trondhjem.org>
References: <490F780E.4020806@redhat.com>
	 <1225820777.31157.302.camel@moss-terrapins.epoch.ncsc.mil>
	 <1225830495.30407.48.camel@heimdal.trondhjem.org>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 16:09:33 -0500
Message-Id: <1225832973.31157.335.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-11-04 at 15:28 -0500, Trond Myklebust wrote:
> On Tue, 2008-11-04 at 12:46 -0500, David P. Quigley wrote:
> > Trond & Bruce: I am going to be at IETF 73 in a couple of weeks are
> > either of you going to be there? I'd like to have a meeting with you
> > about what it is that you want to see happen before mainlining. This way
> > we can come up with the criteria we need to meet before we can mainline
> > the code. If neither of you are going to be at that meeting can we
> > organize some sort of telecon to discuss this?
> 
> Hi Dave,
> 
> As far as I know, only beepy and Mike Eisler will be representing NetApp
> at the next IETF, so a conf call might be a better idea.
> 
> However, to start the conversation: My basic worry about mainlining at
> this point is that I don't want to merge something that will need to
> maintained as a legacy protocol for the benefit of Linux users if in 1
> year, everybody goes off and produces a similar but not quite the
> identical protocol within the NFSv4 minor version framework and the
> IETF.
> 
> IOW: my concern is that I want to do SELinux on NFS once only.
> 
> Cheers
>   Trond

So this brings up a concept that I don't think the WG has grasped yet.
Our goal is not to put SELinux into NFS but to provide the necessary
extensions to allow MAC systems in general to work with NFS. With FMAC
and Solaris Trusted Extensions the guys at Sun would like to see this
done in a way that they can leverage it as well. From what I've seen so
far the list of MAC systems that could use these extensions are 

SELinux
Smack
Solaris w/Trusted Extensions
Solaris FMAC
SEDarwin
SEBSD
Traditional MLS systems

Not only in the case of Solaris TX and SELinux are the models completely
different but the access decision points may differ as well (I'm not
100% sure on this I'd have to ask Glenn or Nico). Even within the same
model we see a different set of access checks. While Solaris FMAC and
SELinux are both DTE systems we've found that we were able to remove
some cruft from the SELinux object classes when dealing with FMAC and
that we needed additional classes since Solaris has more file types than
Linux does.

So there are two components to getting this system working. One is
providing the capability for NFS to store and transport per-file
security labels. We have this already and I'm pretty sure our
description of it is solid. By deciding to go with a recommended
attribute it provides us with the ability to atomically assign the label
on object creation and also prevents the server from exposing the file
before it is labeled. I'm not sure anyone really disagrees with this
method of assigning labels to files. Mike Eisler wanted to see some step
by step examples of how this works and I am working on slides for this
to use in the IETF 73 presentation.

This is the functionality that Dan and company are look at for inclusion
so they can use it in F11. This is an area where Dan and company need
weaker MAC guarantees than we do but luckily the guarantees we need are
an extension of the first component.

The second component which we see as necessary for the stronger MAC
guarantees that we need but not for Dan's needs is the ability to
transport the process label for use by the server. In Dan's scenario he
is trusting the client to make MAC policy decisions. In one of our
earlier documents to the working group we presented this as a "Dumb
Server" model. This is where the server would just store the labels and
send them over the client for policy enforcement. In our system we want
both the client and the server to be involved in the access control
decision. 

Initially we devised several methods for process label transport none of
which were optimal. We have been talking with Nico Williams and he
proposed a method of providing the guarantees we need to protect and
transport the process label solely at the RPC layer. This makes it so we
don't need to make invasive changes to the mechanisms used in RPCSECGSS.
This method is still in it's early stages but it is not necessary to
provide the functionality that Dan needs.

I think the main point of contention for the patch set at the moment is
that there isn't a satisfactory method for process label transport. I
think that if we drop process label transport for now until I can see
the document for the RPCSECGSS v3 extensions that Nico is proposing and
then implement those extensions we can get what Dan and company are
looking for while still maintaining process label transport out of tree
for those who need it until we have developed an upstreamable solution. 

Dave




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
