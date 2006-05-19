Subject: Re: Real simple cache that removes most of the lookups in mcstrans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <446DCD4C.6000303@gentoo.org>
References: <446AFED3.9010800@redhat.com> <446B3B51.1060703@redhat.com>
	 <446B3E11.6040302@gentoo.org> <200605192333.01639.russell@coker.com.au>
	 <446DCD4C.6000303@gentoo.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 10:07:22 -0400
Message-Id: <1148047642.25168.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 09:51 -0400, Joshua Brindle wrote:
> Russell Coker wrote:
> > If an application such as "ls" gets a copy of the translation data then there 
> > is no point in writing the library code such that the data can not be 
> > (easily) displayed a second time.  The information once available is presumed 
> > to have already been displayed to the user or stored in a way such that it 
> > can be obtained in another manner.
> >   
> If that were true we wouldn't revoke access to file descriptors (or 
> files) after a policy reload.

Not the same thing.  Revoking data != revoking object capabilities.  The
data has already leaked.  Revoking the object capability prevents
reading of _new_ data from the object, and writing of data to the
object.  But the already read data has already migrated into the state
of the client.

>  And you are still ignoring the case where 
> the translation actually changes. My worry isn't ls (which is one-shot, 
> and executes quickly most of the time), _anything_ that uses this 
> library code now caches the answer and if its a long running process 
> then it has no way of knowing when translations have changed or access 
> has been revoked.

Notifications of changes to the translations make sense for correctness.
Not so much of an access control issue.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
