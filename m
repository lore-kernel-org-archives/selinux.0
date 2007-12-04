From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: Interface for DOI mapping
Date: Tue, 4 Dec 2007 13:49:39 -0500
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>,
        Labeled NFS <labeled-nfs@linux-nfs.org>,
        SE Linux <selinux@tycho.nsa.gov>
References: <254486.24688.qm@web36605.mail.mud.yahoo.com>
In-Reply-To: <254486.24688.qm@web36605.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712041349.39711.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 December 2007 12:10:15 pm Casey Schaufler wrote:
> which brings up the question of who does the translation.
> I suggest that the receiver always do the mapping and that the
> sender always speaks it's native DOI.

You've got more experience in this area than I do, but I would think that 
offering translations about on the sender and receiver would be necessary to 
handle both new hosts (systems that support multiple DOIs through 
translation) as well as legacy hosts (systems that only support a single 
DOI).  In the case of a receiver that supports DOI translation, I agree, it 
probably is best for the sender to send data using it's default/native DOI 
and let the receiver translate as necessary.  However, if the receiver does 
not understand multiple DOIs it will be necessary for the sender to ensure 
that data sent to the receiver it sent with the receiver's DOI; requiring the 
use of sender side DOI translation in certain cases.

In either case, I think a properly designed and configured system would only 
want to perform the translation once.  Although there shouldn't be anything 
preventing someone for configuring the translation to happen on both ends if 
that is what they really want.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
