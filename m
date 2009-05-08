Subject: Re: SELinux and access(2), we want to know.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, viro@ZenIV.linux.org.uk
In-Reply-To: <4A03AC41.1040505@schaufler-ca.com>
References: <1241723924.2791.107.camel@localhost.localdomain>
	 <20090507195729.GA21104@us.ibm.com>  <4A03AC41.1040505@schaufler-ca.com>
Content-Type: text/plain
Date: Fri, 08 May 2009 08:27:07 -0400
Message-Id: <1241785627.6452.193.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-05-07 at 20:51 -0700, Casey Schaufler wrote:
> Serge E. Hallyn wrote:
> > Quoting Eric Paris (eparis@redhat.com):
> >   
> >> 3) I've also heard it hinted that we could do this with audit by just
> >> having audit drop the denials that include the access(2) syscall and the
> >> scontext and tcontext for the slew of things the SELinux policy writers
> >> know we are not interested in.  And while it seems good, now we have
> >>     
> >
> > What is the difference whether an attacker does access(2) to check for
> > /etc/shadow rights, or does a failed open()?
> >   
> 
> I have been studiously ignoring the discussions on the SELinux list because
> in the end it really doesn't matter, as Serge (appears to) point out here.
> The access() system call was a major thorn in the side of the POSIX security
> working group because its behavior is not really very rational. By design
> it does not take into account read-only file systems, ACLs, MAC labels,
> TOMOYO policy, or anything other than the mode bits. A successful return
> from access() gives you no assurance whatever that if you actually try the
> operation it will succeed. My recollection is that every version of
> "trusted unix" written treats the system call the same way it would a
> call to lstat(), because that's really all it is doing.

Casey, please go read the access(2) / faccessat(2) code in Linux and
then come back to the discussion.  It does in fact take into account all
of those things presently (and notes in a comment that SuS v2 requires
that it report a read-only fs).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
