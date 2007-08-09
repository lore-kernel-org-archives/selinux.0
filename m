Message-ID: <46BB2DC6.3030808@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov, joe@nall.com,
        James Morris <jmorris@namei.org>, Eric Paris
	 <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 11:07:50 -0400 
MIME-Version: 1.0
in-reply-to: <200708091057.17756.paul.moore@hp.com>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Thursday 09 August 2007 10:41:09 am Darrel Goeddel wrote:
>> ... I also think that there must be consistency forced between the
different
>> peer labeling mechanisms.  If I get packets that are specified as
top_secret
>> via CIPSO over an ipsec association labeled as
user_u:user_r:user_t:secret,
>> that packet should die. 
> 
> Yes.  This is one of the places in the labeled networking code that has
always 
> bothered me.  The current mashup of labels was rather a poor attempt at 
> compromise by everyone involved and I think everyone will agree that we
need 
> to come up with a better solution.

That is what I was afraid of...  So we currently have a problem where
getpeercon
can distort the MLS portion of the peer's context in the case of CIPSO and
labeled ipsec being employed.  The netlabel fallback mechanism will
exacerbate
this problem by making making it much easier to exploit the problem because
labeled ipsec with fallback is very desirable.  I want to treat hosts on a
certain net as secret in general, but I also want to allow some
administrative
connections at systemhigh using labled ipsec.  In this case, the fallback
would
be trumping my attempts to provide my real local context to the server I am
trying to connect to.  It is real scary in the opposite case - a top_secret
fallback MLS level trumping a lowly user's unclassified ipsec label and
giving
him access to a whole bunch of goodies...  I really think using secmark as
a fallback, below the peer provided labeling information, is going to be the
best
solution to this problem.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
