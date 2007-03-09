Subject: Re: mmap_file_perms needs ioctl also
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <760182.67627.qm@web36602.mail.mud.yahoo.com>
References: <760182.67627.qm@web36602.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 12:14:43 -0500
Message-Id: <1173460483.3241.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-09 at 09:06 -0800, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>  
> > ioctl permission is effectively useless as it
> > doesn't distinguish
> > read-flow vs. write-flow vs. control-op, so it ends
> > up being allowed
> > pervasively whenever you allow read or write.  We
> > really need to just
> > replace it (ala the attempts by Lorenzo in the
> > past), but doing so
> > compatibly won't be easy.
> 
> That is a significant understatement. Ioctl is
> used, misused, and abused so many different ways
> in so many places that doing a granular enforcement
> may be beyond the current state of the art and is
> certainly a maintenance burden that exceeds the
> scope of the existing SELinux implementation.
> An investigation into the networking drivers alone
> ought to send the rational programmer running in
> blind terror. Then there are the graphics
> implementations.
> 
> I suggest that an approach that would add more
> value to the kernel overall and make someone a
> minor kernel diety would be to replace the ioctl
> mechanism completely. I also think that it would
> be less work than trying to do a proper job of
> granualizing the existing smoldering pile of
> technology.

The trend seems to be to replace such things with pseudo filesystem
interfaces, but in doing so, they usually aren't thinking through the
security aspects (e.g. see the CKRM discussion and my comments on the
kernel cpuset filesystem), so the file-level controls are often
inadequate and we are back to adding hooks into the underlying
implementation...

> We did look into the granular ioctl security
> policy issue in Unix in the 20th centuty. If
> you restrict your system to a very limited set
> of devices it still stretches an evaluation
> budget beyond the breaking point. It's very
> hard to justify the value of the granularity
> in terms of the cost.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
