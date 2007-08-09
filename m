Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Darrel Goeddel <DGoeddel@TrustedCS.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, Eric Paris <eparis@parisplace.org>
In-Reply-To: <0686AF70-E657-439B-9E65-CC49ABC2E226@nall.com>
References: <46BB6F5F.3010202@trustedcs.com>
	 <0686AF70-E657-439B-9E65-CC49ABC2E226@nall.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 17:15:05 -0400
Message-Id: <1186694106.6916.756.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 15:12 -0500, Joe Nall wrote:
> On Aug 9, 2007, at 2:47 PM, Darrel Goeddel wrote:
> >> getpeercon() returned 'user_u:object_r:user_t:C O N F I D E N T I  
> >> A L'
> >>
> >> for a connection from 10.211.55.8.
> >>
> >> This is a big improvement in linux labeled networking functionality.
> >
> > As described in an earlier email, from my not-yet-full grasp on the  
> > patch,
> > this is a vulnerability waiting to happen in the event of using  
> > netlabel
> > fallback contexts alongside labeled ipsec.
> 
> Which would be a configuration error. There are lots of dangerous but  
> useful tools (rm, dd). I have ipsec and netlabel configured. I'll try  
> crossing the streams and see if we get total protonic reversal.
> 
> >  That is not an improvement.
> 
> We will have to disagree. It is a big improvement in functionality.  
> It may not be the final approach, but it is the only one I can  
> evaluate today.

I think we all agree that it is important functionality to have, it is
just a matter of doing it in a way that works cleanly for all labeled
networking mechanisms (netlabel and labeled IPSEC) and ideally leverages
infrastructure that we already have (secmark).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
