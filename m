Message-Id: <200410181538.i9IFc4Sf003259@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <jsingh@ensim.com>
Cc: "'nsa'" <SELinux@tycho.nsa.gov>, "'Selinux-Dev'" <selinux-dev@tresys.com>
Subject: RE: writing rules to disallow a domain to read particular files
Date: Mon, 18 Oct 2004 11:38:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1098105480.9768.21.camel@x-infinity.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Colin Walters
> Sent: Monday, October 18, 2004 9:18 AM
> To: jsingh@ensim.com
> Cc: nsa
> Subject: Re: writing rules to disallow a domain to read particular files
> 
> On Mon, 2004-10-18 at 13:28 +0530, Jaspreet Singh wrote:
> 
> > That was an eye opener .. i didn't know so much was possible with
> > SELinux. Could you pass me on some document which can elaborate on
> > policy rules and configuration (and discusses whats all possible with
> > these policies).
> 
> http://www.nsa.gov/selinux/papers/policy2-abs.cfm
> 

We also provide the slides from our SELinux course on our website:
http://www.tresys.com/selinux/index.html. These cover both policy syntax and
SELinux concepts.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> > Just to test the above approach i tried the following on on my FC2 box
> > with FC3 selinux-files , but i had some bad time compiling my changes
> > ...
> 
> You'll need the strict policy for this, basically.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
