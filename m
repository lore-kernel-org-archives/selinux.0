Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1CJlvNh029623
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 14:47:57 -0500
Subject: Re: [Labeled-nfs] New MAC label support Internet Draft posted to
 IETF website
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Peter Staubach <staubach@redhat.com>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
In-Reply-To: <alpine.LRH.1.10.0902121205410.17299@tundra.namei.org>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
	 <4990AD20.3030902@redhat.com>
	 <1234396064.2929.121.camel@moss-terrapins.epoch.ncsc.mil>
	 <alpine.LRH.1.10.0902121205410.17299@tundra.namei.org>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 14:45:21 -0500
Message-Id: <1234467921.2929.143.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-12 at 12:07 +1100, James Morris wrote:
> On Wed, 11 Feb 2009, David P. Quigley wrote:
> 
> > sort of open file handle revocation support. In the past people have
> > suggested building the client's idea of the label into either the
> > stateid or some other form of cookie that can be verified by the server.
> > We explored doing this in the form of an NFSv4 op and while that worked
> > we are trying to shy away from adding new operations if we can help it.
> 
> What's wrong with adding new operations?
> 
> 
> - James


For the sake of discussion I'll talk about the previous work we did on
this topic. In the presentation I gave at IETF 71 we had a new NFSv4
operation called OP_PUTCLIENTLABEL. The idea of this was it was to work
like a PUTFH call in that you would push some state to the server which
would be used to evaluate all portions of the compound operation after
it. The idea was that the client would say that it believes the file is
TOP SECRET by issuing a PUTCLIENTLABEL at the beginning of the compound
op with the label TOP SECRET as the value. When the server evaluated the
parts of the compound operation that used a file handle it would check
if the label for that FH matched the one asserted by the client in the
PUTCLIENTLABEL operation. If they didn't match, the server returned an
ESTALE error and hopefully the client would refetch the file handle. At
the time Linux didn't have good support for recovering from an ESTALE
but since then I believe that support was fixed.

Someone in the audience brought up that we possibly had the
PUTCLIENTLABEL op in the wrong place because it wasn't being protected
by one of the replay attack mechanisms. This would have been easy to fix
but some people seemed skeptical to doing this as a new operation (we
had a total of two or three that were being proposed). So we went back
and looked for another way to do it. James had suggested building it
into the stateid and Nico has suggested to use volatile FHs for it. 

When I gave a followup presentation at IETF 72 I mentioned that we had
removed the operations. After the presentation I believe Mike Eisler
mentioned that it was good that we avoided adding new operations. He
said that they were trying to make future revisions to NFSv4 (4.2 and
higher) move more quickly through the process since they would be
smaller revisions. We hoped making the required protocol changes smaller
would help move things along more quickly.

I'd like to hear more from Nico on how we can use volatile FHs to solve
this problem. The document still needs more work to take care of things
like this but I was hoping this revision could get the discussion
rolling so other people would provide input into the design. It seems
that it is getting attention now.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
