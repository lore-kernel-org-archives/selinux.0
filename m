Subject: Re: I would like to suggest a new file attribute like usersafe.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <406200DA.4010102@redhat.com>
References: <406200DA.4010102@redhat.com>
Content-Type: text/plain
Message-Id: <1080165408.31893.241.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Mar 2004 16:56:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-24 at 16:42, Daniel J Walsh wrote:
> One of the things I have thinking about at is the ability to globally 
> say a context can read these files.
> For instance allowing the slocate policy to read files.  Rather then 
> trying to figure out all of the file types
> that are safe to read and listing them in policy, if we had a attribute, 
> similar to sysadminfile,  that indicated
> it was safe for users access we could have a simpler rules.
> 
> usersafefile?
> 
> 
> 
> So as policy developers decide to add a new context for XYZ app, they 
> can add attribute that will allow
> users access.
> 
> r_dir_file($1_locate_s, usersafefile)

How about userreadable?  Or something similar to indicate that it is
strictly for allowing read access?  This is similar to the existing
readable_t type, but would let you preserve different types (and thus
different write rules).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
