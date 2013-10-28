Message-ID: <1382980305.3265.11.camel@localhost>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive
 mode
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Laurent Bigonville
 <bigon@debian.org>,
        SELinux List <selinux@tycho.nsa.gov>
Date: Mon, 28 Oct 2013 13:11:45 -0400
In-Reply-To: <526E97CF.1050904@tycho.nsa.gov>
References: <20131027144337.5b89c5a8@fornost.bigon.be>
	 	<526E5D5C.8010505@tycho.nsa.gov> <20131028143605.02a85190@soldur.bigon.be>
	  <526E78AC.2080104@redhat.com>
	 <1382975775.2954.44.camel@flatline.rdu.redhat.com>
	 <526E97CF.1050904@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-10-28 at 12:58 -0400, Stephen Smalley wrote:
> On 10/28/2013 11:56 AM, Eric Paris wrote:
> > On Mon, 2013-10-28 at 10:46 -0400, Daniel J Walsh wrote:
> >> Maybe the solution here is to add logging messages to the function.
> >>
> >> My opionion is that if something is wrong with SELinux, IE The labels are
> >> wrong, the policy is wrong or the app is wrong, we should not block in
> >> permissive mode.
> >>
> >> Having the tool write "foobar_t is not a valid source context" would be better
> >> then what we have now, which is a silent denial even in permissive mode.
> > 
> > I understand Stephen's argument.  But agree with dwalsh/bigon that
> > hiding this in the library is a lot better than moving the logic to
> > userspace programs.  So this might not be so super simple to do.  How
> > about the idea of a new interface which always returns 0 in permissive?
> > But it does a couple of extra things.  These are just rough early
> > thoughts....
> > 
> > 0) new interface just like avc_has_perm() but which always returns 0 in
> > permissive.
> > 
> > 1) a new SELINX_USER_ERR audit message.  On EINVAL we check if the
> > scontext/tcontext are valid and print the equivalent of a SELINUX_ERR
> > message into the audit log if not.
> > 
> > 2) a new /sys/fs/selinux/context like mechanism, which will both
> > validate the context and will force it into the sid cache.  So
> > subsequent broken calls to avc_has_perm() will not generate a second
> > SELINX_USER_ERR message, since the second call to 'access' will find a
> > valid type and will give a denial for that unlabeled_t type?
> > 
> > maybe /sys/fs/selinux/access should be changed/new interface added to do
> > all of this in kernel?  generating a real SELINUX_ERR in kernel and
> > forcing the invalid label into the sid cache?
> > 
> > I really do think that userspace object managers should be allowed to
> > call avc_has_perm() and either get an error that should be handled as a
> > hard failure or a 0...   checking permissive in userspace object
> > managers just seems prone to breakage...
> 
> I'm ok with changing avc_has_perm as long as:
> a) Something gets logged/audited so you'll see that something went wrong
> in permissive mode and not just get silent failures in enforcing mode,
> 
> b) We are careful about what error conditions are remapped to 0 in
> permissive mode.  If we just hit a memory allocation failure, we
> shouldn't hide that from the caller.  It should only affect things
> relating to policy.

I'm currently thinking about something like a change
in /sys/fs/selinux/access which forcibly maps invalid contexts to
SECINITSID_NULL (in both the enforcing and permissive case) and which
sends a new audit message SELINUX_USER_ERR() when it does that invalid
mapping...

It should mean that we get ONE audit messages in permissive and
enforcing per invalid label.  Kernel policy will make the decision
against the null sid.  Userspace (avc_has_perm_noaudit) will add in the
right flags if the system is in permissive, so those errors will never
percolate back up the stack...

Is this a bad idea Stephen?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
