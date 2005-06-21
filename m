To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: XML Based Policy Configuration for SELinux
Message-ID: <1119383982.42b871aef1898@cc.utulsa.edu>
Date: Tue, 21 Jun 2005 14:59:42 -0500 (CDT)
From: alexander-barclay@utulsa.edu
Cc: Brandon Pollet <brandon@utulsa.edu>, SELinux@tycho.nsa.gov,
   John Hale <john-hale@utulsa.edu>
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net>
In-Reply-To: <20050621184940.GA8354@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  this is not useful.
> 
>  tools to translate the *.fc, *.te, users file, etc.?
> 
>  that's useful.
> 
>  just my independent, uninformed, enthusiastic, inadviseable,
>  egoistical and impartial opinion.
> 
>  l.



Hey Luke, thanks for your honest opinion, it is appreciated. This project was conceived over a year ago, and we as a research group have learned a lot in this timeframe.

The reasoning at the time was to work on the policy.conf since it is a        worst case scenario of the policy configuration, and to be honest we were not sure that the fc/te/* files would stay the same format. In addition we were planning a suite of tools to work on the XML policy that would help with common configuration tasks etc. 

After some conversations with others in the SELinux community, we decided to deemphasize all of our projects being XML policy based. This thesis/project was intended to be the first part of a larger group of projects, and alone is not amazing, but utilizing some of the  xml tools avaliable it opens up some options that did not exist previously. 

I agree that now looking at some of the smaller configuration files is useful, any feature requests you or the mailing list have would be appreciated. Do you like the choice of using TXL? Include meta-data? etc.



On a side note, this thesis work was done by Tyronne Nash who passed away days before completion. We honor his spirit and seek to further his work.

Alex Barclay
University of Tulsa
Enterprise Security Research Group



Quoting Luke Kenneth Casson Leighton <lkcl@lkcl.net>:

> On Tue, Jun 21, 2005 at 12:37:16PM -0500, Brandon Pollet
> wrote:
> > Recently there was a discussion about using XML in SELinux
> policy and  
> > so I wanted send out this Master's Report by Tyronne Nash.
> This paper  
> > covers some of the work we have done at the University of
> Tulsa to  
> > convert and extend the SELinux policy language with an XML 
> 
> > specification. The abstract and a link to the full document
> are  
> > contained below. Let me know what you think.
> > 
> > thanks,
> > Brandon Pollet
> > 
> > Abstract
> > 
> > Security-Enhanced Linux provides an implementation of
> mandatory  
> > access control but
> > is limited by the available tools for policy configuration
> and  
> > analysis. This work ex-
> > amines policy management and demonstrates a method to
> translate the  
> > information in
> > the policy.conf file to XML. 
> 
>  this is not useful.
> 
>  tools to translate the *.fc, *.te, users file, etc.?
> 
>  that's useful.
> 
>  just my independent, uninformed, enthusiastic, inadviseable,
>  egoistical and impartial opinion.
> 
>  l.
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the
> message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
