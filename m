Subject: Re: Tar storage of SELinux context, translated or not
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1168448023.13080.33.camel@code.and.org>
References: <1168448023.13080.33.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 12:43:41 -0500
Message-Id: <1168451021.7993.189.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-10 at 11:53 -0500, James Antill wrote:
>  As some of you know, I have done patches to make GNUtar able to
> save/restore ACLs, SELinux context and generic user xattrs. I've
> recently had to fixup the ACL support for compatibility with star etc.,
> and for a couple of reasons that got me thinking about the SELinux
> support as well.
> 
>  I had originally decided that the SELinux security context should be
> stored in translated form, Ie. getfilecon => tar => setfilecon, my
> thinking was that if you want to store something over a long period this
> is the better format ... but as I think more about it now I'm not 100%
> convinced (for instance, AIUI ipsec etc. uses raw format to distribute
> context between machines).
>  With the current changes, this is a great time to change it (but I
> really, really, don't want to have an option either way) ... if we want
> to. So should I change it to non-translated?

The translated form has more semantic meaning, and thus seems better for
archival.  On the ipsec side, I think Tresys is working on extensions to
racoon to support label translation for a different purpose - supporting
different policy realms that may require mappings between labels.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
