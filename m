Message-ID: <47685BBB.7060308@tycho.nsa.gov>
Date: Tue, 18 Dec 2007 18:46:03 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: avc:  granted null messages
References: <1198014552.11568.49.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1198014552.11568.49.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> If a (buggy) caller passes a requested permission value of zero to
> avc_has_perm, it correctly returns a permission denial (if enforcing),
>   

Now I'm questioning why we don't just return success.  Doesn't everyone 
have permission to do nothing?  It seems odd to think that a process 
could receive "granted" for a set of permissions A, but "denied" for a 
subset of A.


> but avc_audit will report it as a granted message with a "null" access
> vector (also if enforcing) due to the way in which avc_audit checks for
> the denied case.  This was reported for nscd in
> https://bugzilla.redhat.com/show_bug.cgi?id=352601,
> but applies to both the libselinux AVC and the kernel AVC.
>
> In permissive mode, avc_has_perm permits the operation, and avc_audit
> reports nothing at all.
>
> So the question is how do we want to handle this case?
>
> It is a bug in the caller, but making it a BUG_ON() in the kernel and an
> assert() in libselinux doesn't seem very graceful, especially if in
> permissive mode.
>
> We could easily adjust avc_audit() to report it as a denied message with
> a 'null' access vector, although running audit2allow on that output will
> yield a broken policy module.
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
