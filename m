Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3UDU24e024933
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 09:30:02 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
Date: Wed, 30 Apr 2014 09:29:58 -0400
Message-ID: <1734421.ihMzWMu7WD@x2>
In-Reply-To: <5360F3C6.4090501@redhat.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <1398826782.10979.9.camel@localhost> <5360F3C6.4090501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, April 30, 2014 08:59:50 AM Daniel J Walsh wrote:
> How about permitted rather then allowed.

I think permitted is already in an AVC.


> On 04/29/2014 10:59 PM, Eric Paris wrote:
> > On Tue, 2014-04-29 at 16:54 -0700, Stephen Smalley wrote:
> >> Requested for Android in order to distinguish denials that are not in
> >> fact breaking anything yet due to permissive domains versus denials
> >> that are being enforced, but seems generally useful.  result field was
> >> already in the selinux audit data structure and was being passed to
> >> avc_audit() but wasn't being used.  Seems to cause no harm to ausearch
> >> or audit2allow to add it as a field.  Comments?
> > 
> > I think it's a great idea, but I'm worried that Steve is going to get
> > grumpy because an AVC record is going to have a result= field which is
> > similar, but not necessarily related to the res= field of a SYSCALL
> > record. 

I think that I'll have to parse this field no matter what. Its probably that 
important. In the syscall, we use success= to be the final determination.


> > Seems easily confused (although probably 9999 times out of
> > 10000 they will be the same)

Why would this ever not be correct? Are there times when we get an AVC with a 
denial _and_ the syscall completes successfully?

I'd suggest using res= since its in the audit dictionary and means exactly 
what you are wanting to use it for. In it, 1 is success, 0 is failure.


> > So while I wholeheartedly think we should take the idea, I wonder if
> > someone can dream up a name that isn't confusingly similar...
> > 
> > I can't think of anything...

There is thesaurus.com. :-)

consequence, outcome, effect, reaction,  conclusion, verdict, decision, 
judgement, finding, ruling, answer, solution, recommendation, order,  ...

-Steve
