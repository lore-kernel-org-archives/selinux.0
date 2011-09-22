Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4E7B9B43.9000400@redhat.com>
References: <4E7B9233.6080609@redhat.com>
	 <1316723465.2354.6.camel@moss-pluto>  <4E7B9B43.9000400@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Sep 2011 16:37:01 -0400
Message-ID: <1316723821.2354.9.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-22 at 16:32 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 09/22/2011 04:31 PM, Stephen Smalley wrote:
> > On Thu, 2011-09-22 at 15:53 -0400, Daniel J Walsh wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> Currently if I create a directory labeled
> >> 
> >> etc_t:s0:c1
> >> 
> >> And with a process running as unconfined_t:s0-s0:c0.c1023 create
> >> a file within the directory, the file gets created with the
> >> label etc_t:s0.   I would like to change the behavior to creating
> >> the file as etc_t:s0:c1.
> >> 
> >> That way an administrator could modify files within a sandbox and
> >> have the files be labeled correctly.
> >> 
> >> I believe this behavior differs from MLS but believe this would
> >> be what the admin expects.
> >> 
> >> Is changing this a kernel or policy issue?
> > 
> > That would be a kernel change, and it would have to be configurable
> > so that it can differ for MLS vs MCS.
> > 
> It would seem that we should be able to state the behaviour in policy.

Yes, that was my meaning - allow the default labeling behavior be
configurable in policy.  Ideally for each field of the security context.
We already provide significant flexibility through type_transition and
range_transition rules, but not quite what you want here.  In effect,
you want the same default behavior for levels as we already have for
types, i.e. inherit from parent directory.  Meanwhile, I've seen others
who wanted inherit-from-creating-process for types.  So providing a
policy construct to specify the desired default for each context
component would be fine.  I think we've even discussed it before.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
