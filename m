Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4E7B9233.6080609@redhat.com>
References: <4E7B9233.6080609@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Sep 2011 16:31:05 -0400
Message-ID: <1316723465.2354.6.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-22 at 15:53 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Currently if I create a directory labeled
> 
> etc_t:s0:c1
> 
> And with a process running as unconfined_t:s0-s0:c0.c1023 create a
> file within the directory, the file gets created with the label
> etc_t:s0.   I would like to change the behavior to creating the file
> as etc_t:s0:c1.
> 
> That way an administrator could modify files within a sandbox and have
> the files be labeled correctly.
> 
> I believe this behavior differs from MLS but believe this would be
> what the admin expects.
> 
> Is changing this a kernel or policy issue?

That would be a kernel change, and it would have to be configurable so
that it can differ for MLS vs MCS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
