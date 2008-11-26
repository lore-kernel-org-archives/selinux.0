Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAQI4lRW003799
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2008 13:04:47 -0500
Subject: Re: SELinux on NFS.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        "J. Bruce Fields" <bfields@fieldses.org>, dquigley@gmail.com,
        dwalsh@redhat.com
In-Reply-To: <1225830495.30407.48.camel@heimdal.trondhjem.org>
References: <490F780E.4020806@redhat.com>
	 <1225820777.31157.302.camel@moss-terrapins.epoch.ncsc.mil>
	 <1225830495.30407.48.camel@heimdal.trondhjem.org>
Content-Type: text/plain
Date: Wed, 26 Nov 2008 12:43:58 -0500
Message-Id: <1227721438.25837.57.camel@moss-terrapins.epoch.ncsc.mil>
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

Hello,
    It is after IETF 73 so I figured that I would try to organize our
conference call now for some time next week. I spoke with Mike Eisler,
Lars Eggert and Spencer Shepler and they seem happy from a technical
perspective about what we are proposing. After the meeting I asked them
what I need to do to move forward about getting this added to the
working group charter and they said I need to get support from members
within the working group who are willing to do some of the work in
reviewing the documents. 

    So the main thing I would like to discuss is what would you and
Bruce like to see done that you would feel comfortable publicallty
supporting this work. Since you want to see something more concrete from
the working group before we work on merging code into mainline I need to
start drumming up support as soon as possible. Tim Polk expressed his
support at IETF 72 in Dublin so hopefully he will do that again if I ask
him. We have a few people at Sun who support the work and some people at
Netapp have been getting questions about SELinux support from their
customers so I believe they may be willing as well.


P.S I will be out of the office until Monday so I added my personal
email address to the CC so I can have access to this at home.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
