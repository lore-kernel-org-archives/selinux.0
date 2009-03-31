From: Paul Moore <paul.moore@hp.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to
 =?iso-8859-1?q?IETF=09website?=
Date: Tue, 31 Mar 2009 10:47:20 -0400
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49D10FC1.3000103@sun.com> <49D188D6.6020107@schaufler-ca.com>
In-Reply-To: <49D188D6.6020107@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903311047.21216.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 30 March 2009 11:07:02 pm Casey Schaufler wrote:
> Jarrett Lu wrote:
> > Maybe we can do something better 15 years later. The first step is to
> > figure out how much information is needed and then look into how to
> > get this info across securely. GSS_SEC may be able to help us. To make
> > NFSv4 work, only TCP is needed. So peer information is needed per
> > session vs. per packet, I believe. Evidently, there is more work to do
> > in figuring this all out.
>
> Not to throw a puppy in the gears, but sophisticated handshaking and
> negotiation protocols are not the answer. We had TSIG session management
> for doing that and it is just not enough. How would you negotiate the
> differences between two SELinux policies?

I'm with Casey, I don't think it is worth spending a whole lot of time right 
now finding out how to pass information across the network in a secure manner.  
There are plenty of ways of to do that which are well established, 
interoperable and generally regarded as "secure".

>From my point of view the real issue is how do we translate/resolve security 
labels defined by DOI X to an internal, security model/policy specific label?  
Some have mentioned a mechanism which would serve up label encoding data 
whenever a new system joined the network; unfortunately, I believe this only 
works when you know the security policy of the system before hand (or can 
restrict the security policy, after all a TSOL label encodings file will do 
nothing for SELinux and/or Smack).  While I think it is reasonable to assume a 
limited number of on-the-wire label encodings and DOIs I think it would be a 
mistake to assume a limited number of security models and or policies.

Ultimately I believe that the required label translation information (wire/DOI 
label to internal and the other way around) is going to need to be bundled 
with the system's security policy and distributed as a single "package".  
Granted this does require prior knowledge of the DOIs in use but I believe 
this is a much easier requirement than the opposite.  From a practical point 
of view this isn't too far removed from the notion of sending sending label 
encoding data upon joining the network, the big difference is that we are 
sending both security policy and label encoding/DOI-translation data at the 
same time (in the TSOL case I suspect this would just be the label encoding 
data, which may mean the original poster had this in mind).

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
