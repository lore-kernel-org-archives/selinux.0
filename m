Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4JJ3bY017677
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 14:19:03 -0500
Received: from web36601.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB4JJ2wr003903
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 19:19:02 GMT
Date: Tue, 4 Dec 2007 11:12:15 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Interface for DOI mapping
To: Paul Moore <paul.moore@hp.com>, casey@schaufler-ca.com
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>,
        Labeled NFS <labeled-nfs@linux-nfs.org>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200712041349.39711.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <949575.52434.qm@web36601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> On Tuesday 04 December 2007 12:10:15 pm Casey Schaufler wrote:
> > which brings up the question of who does the translation.
> > I suggest that the receiver always do the mapping and that the
> > sender always speaks it's native DOI.
> 
> You've got more experience in this area than I do, but I would think that 
> offering translations about on the sender and receiver would be necessary to 
> handle both new hosts (systems that support multiple DOIs through 
> translation) as well as legacy hosts (systems that only support a single 
> DOI).  In the case of a receiver that supports DOI translation, I agree, it 
> probably is best for the sender to send data using it's default/native DOI 
> and let the receiver translate as necessary.  However, if the receiver does 
> not understand multiple DOIs it will be necessary for the sender to ensure 
> that data sent to the receiver it sent with the receiver's DOI; requiring the
> 
> use of sender side DOI translation in certain cases.
> 
> In either case, I think a properly designed and configured system would only 
> want to perform the translation once.  Although there shouldn't be anything 
> preventing someone for configuring the translation to happen on both ends if 
> that is what they really want.

Yeah, you're probably right with regard to systems that can't do
translation. What I think is important is that the translation be
a simple lookup rather than an attempt to interpret the attribute
data and reinterpret it for the other DOI.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
