Subject: Re: [ SEPOL ] Extract user records from binary policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <4338A1BD.9050204@cornell.edu>
References: <4334E273.9070703@cornell.edu>  <4334E4C8.8050206@cornell.edu>
	 <1127762342.19016.186.camel@moss-spartans.epoch.ncsc.mil>
	 <4338A1BD.9050204@cornell.edu>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 14:58:26 -0400
Message-Id: <1127847506.21671.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-26 at 21:34 -0400, Ivan Gyurdiev wrote:
> >I understand that you are trying to just re-use the existing mls_
> >functions here, but I think it would be better to alter them or add new
> >ones that provide a saner interface for this kind of manipulation.  In
> >particular, the manipulation of str above makes me nervous, even if it
> >is technically correct.
> >  
> >
> Yes, I agree the mls interface should be improved... so I don't have to 
> write things like:
> 
>                 if (mls_context_to_sid(policydb, '$', &mls_level, 
> &context)) {
>                         DEBUG(__FUNCTION__, "invalid level %s for user 
> %s\n",
>                                 mls_level, name);
>                         goto err;
>                 }

Yes.  The interface did make sense for its original usage, but not for
the way in which it is being used here. 

> Is this patch vetoed for now?

Yes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
