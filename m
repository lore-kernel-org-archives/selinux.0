Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2EGjj1I016654
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2013 12:45:46 -0400
Message-ID: <1363279542.80887.YahooMailClassic@web87901.mail.ir2.yahoo.com>
Date: Thu, 14 Mar 2013 16:45:42 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: SELinux network labeling
To: Linda Knippers <linda.knippers@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <5141F9A8.5030001@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Regarding the: http://selinuxproject.org/page/NB_Networking
page. I generally update this when I publish the SELinux Notebook.

If there are any specific points you would like added or updated let me
know as try to keep up (but I didn't know openswan handled labeling until
today).

So if you (or anyone) sends me a list of pointers I'll have ago as time
permits - but not today or this week or ....

Richard

--- On Thu, 14/3/13, Linda Knippers <linda.knippers@hp.com> wrote:

> From: Linda Knippers <linda.knippers@hp.com>
> Subject: Re: SELinux network labeling
> To: "Langland, Blake" <blangland@integrity-apps.com>
> Cc: "Chad Hanson" <dahchanson@gmail.com>, "Paul Moore" <paul@paul-moore.com>, "Stephen Smalley" <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
> Date: Thursday, 14 March, 2013, 16:24
> On 03/14/13 11:37, Langland, Blake
> wrote:
> > Oh, great! Does any documentation exist on how to set
> up Openswan labeling? I was unable to find any.
> 
> Labeled networking makes me sad.  It would be so nice
> if this
> page was updated:
> http://selinuxproject.org/page/NB_Networking
> 
> The only documentation I know of is a few pages in the
> evaluated
> configuration guide from the RHEL6.2 evaluation.  It's
> in the
> "cc-eal4-config-rhel62" rpm from Red Hat.
> 
> Maybe someone else will have a better pointer for you.
> 
> -- ljk
> 
> > 
> > -----Original Message-----
> > From: Linda Knippers [mailto:linda.knippers@hp.com]
> 
> > Sent: Thursday, March 14, 2013 8:25 AM
> > To: Chad Hanson
> > Cc: Paul Moore; Langland, Blake; Stephen Smalley; selinux@tycho.nsa.gov
> > Subject: Re: SELinux network labeling
> > 
> > Chad Hanson wrote:
> >>
> >> On Wed, Mar 13, 2013 at 1:55 PM, Paul Moore <paul@paul-moore.com
> 
> >> <mailto:paul@paul-moore.com>>
> wrote:
> >>
> >>     On Wednesday, March 13,
> 2013 05:29:47 PM Langland, Blake wrote:twork
> >>     traffic
> >>
> >>     > The reason I ruled
> that out IPSec labeling is that we are using
> >>     Openswan for
> >>     > IPSec and it is my
> understanding after talking with Josh Brindle that
> >>     > labeling is not
> supported in Openswan. Are there any plans to
> >>     bring labeled
> >>     > associations to
> Openswan?
> >>
> >>     I haven't tested it lately
> but my understanding is that the version of
> >>     Openswan shipped with RHEL6
> supports labeled IPsec.  I am unsure
> >>     about other
> >>     distributions.
> >>
> >>
> >> Openswan supports labeling in RHEL 6, although it
> looks like there may 
> >> have been a policy issue which was probably
> resolved by RHEL 6.3 from 
> >> looking at this Red Hat Bugzilla report:
> >>  https://bugzilla.redhat.com/show_bug.cgi?id=748971
> > 
> > Openswan was used for labeled IPsec in the CC
> evaluation of RHEL6.2.  There were a handful of bug
> fixes that landed in RHEL6.3. I don't recall that one
> specifically but it doesn't surprise me.
> > 
> > -- ljk
> > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the
> selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the
> message.
> > 
> 
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the
> message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
