From: "Kevin L. Smith" <kls@intelesis.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: "labeled-nfs@linux-nfs.org" <labeled-nfs@linux-nfs.org>,
        "nfs-discuss@opensolaris.org" <nfs-discuss@opensolaris.org>,
        "nfsv4@ietf.org"
	<nfsv4@ietf.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 23 Jan 2009 11:07:20 -0800
Subject: RE: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft
	posted to IETF website
Message-ID: <F044EA27A3826B49B186299981164FCE49B47A99A2@posiedon2.intelesistechnologiescorp.local>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>,<54E18340-3542-4AB4-843E-E92A67B709A7@storspeed.com>
In-Reply-To: <54E18340-3542-4AB4-843E-E92A67B709A7@storspeed.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I can't speak as a representative of the project that I work on called Joint Cross Domain Exchange (JCDX), but we are porting our system from HP-UX 10.26 TOS to SELinx and need the capabilities of labeled NFS for our system.  David has been intrumental in helping me resolve issues and get us to the point where we can use this new capability.  

We only wish that labeled NFS could be mainstreamed sooner to get us out of the kernel building process.

Kevin Smith
Software Engineer
________________________________________
From: labeled-nfs-bounces@linux-nfs.org [labeled-nfs-bounces@linux-nfs.org] On Behalf Of Spencer Shepler [shepler@storspeed.com]
Sent: Friday, January 23, 2009 9:37 AM
To: David P. Quigley
Cc: labeled-nfs@linux-nfs.org; nfs-discuss@opensolaris.org; nfsv4@ietf.org; selinux@tycho.nsa.gov
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted to IETF website

As David suggests, the NFSv4 working group is positive about this
work but until now, the show of specific interest within the NFSv4
working group
has been very minimal.  If this work is to be added to the working
group's
charter, there must be a show of interest.  This can be as simple as an
email to the nfsv4@ietf.org alias stating interest and brief description
of need/use.  This will demonstrate to the area director that work is
occurring and it is worthwhile to have the NFSv4 WG undertake the
work.

So, please speak up, join the nfsv4 WG alias and participate as
interest and need declares.

Spencer

On Jan 22, 2009, at 1:16 PM, David P. Quigley wrote:

> Hello,
>   I have just posted a new document for the MAC labeling support work
> to the IETF website. It contains a lot of clarifying text that has
> been
> asked for by several people in the IETF community. I would like to ask
> that people give it a look over and provide comments if possible. I
> would prefer that discussion takes place on the NFSv4 WG mailing list
> since it shows interest in the technology which is what the WG is
> currently looking for. If you have any questions regarding the text or
> the system outlined in it email me and I'll be more than happy to help
> with any confusion. I am hoping to drum up enough interest in the work
> to request that it be added to the NFSv4 WG charter at the next IETF
> meeting. If you are interested in the work and would like to
> participate
> or just think that it is a worthwhile technology and would like to see
> it added to the NFSv4 standard feel free to speak up.
>
> The information for the document which I received in the conformation
> email and a link to it can be found below.
>
> Dave Quigley
>
>
> A new version of I-D, draft-quigley-nfsv4-sec-label-00.txt has been
> successfuly submitted by David Quigley and posted to the IETF
> repository.
>
> Filename:        draft-quigley-nfsv4-sec-label
> Revision:        00
> Title:           MAC Security Label Support for NFSv4
> Creation_date:   2009-01-22
> WG ID:           Independent Submission
> Number_of_pages: 12
>
> Abstract:
> This Internet-Draft describes additions to NFSv4 minor version one to
> support Mandatory Access Control systems.  The current draft
> describes the mechanism for transporting a MAC security label using
> the NFSv4.1 protocol and the semantics required for that label.  In
> addition to this it describes an example system of using this label
> in a fully MAC aware environment.
>
>
>
> The IETF Secretariat.
>
> http://www.ietf.org/internet-drafts/draft-quigley-nfsv4-sec-label-00.txt
>
>
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4

_______________________________________________
Labeled-nfs mailing list
Labeled-nfs@linux-nfs.org
http://linux-nfs.org/cgi-bin/mailman/listinfo/labeled-nfs


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
