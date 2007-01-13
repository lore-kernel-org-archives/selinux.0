From: Jim Meyering <jim@meyering.net>
To: James Antill <james.antill@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
In-Reply-To: <1168636513.13080.227.camel@code.and.org> (James Antill's message
	of "Fri, 12 Jan 2007 16:15:13 -0500")
References: <45A7D773.8040800@redhat.com>
	<1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	<1168632626.13080.212.camel@code.and.org>
	<1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
	<1168636513.13080.227.camel@code.and.org>
Date: Sat, 13 Jan 2007 11:05:21 +0100
Message-ID: <873b6ffdi6.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill <james.antill@redhat.com> wrote:
> On Fri, 2007-01-12 at 15:24 -0500, Stephen Smalley wrote:
>> On Fri, 2007-01-12 at 15:10 -0500, James Antill wrote:
>
>> Hmm...I'm not sure about the precise history of the coreutils selinux
>> patch, but I had thought it was using setfscreatecon() as much as
>> possible to ensure that the file was labeled correctly at creation time.
>> Otherwise, the file can exist in the wrong label temporarily, which can
>> produce "false" denials (e.g. another process tries to access the file
>> before it is in the expected label and gets a denial) as well as "false"
>> grantings (e.g. another process tries to open the file before it is in
>> the right label and gets a descriptor - which is mitigated in part by
>> the revalidation of access on read/write/... calls and fd
>> inheritance/transfer but revocation support is incomplete). Note also
>> that the permission checks are different for creating vs. relabeling, so
>> the behavior affects policy.
>> Also, I'm not sure what you mean by the above, as I would expect that it
>> would do one of two things for preserving context:
>
>  Ok, I can see why we'd use setfscreatecon() but atm. cp does:
>
> newcon = getfilecon("old")
> setfscreatecon(newcon);
> [...]
> fd = open("new");
> con = getfscreatecon();
> fsetfilecon(fd, con);
>
> ...the later of which, I think, does nothing useful atm.

Isn't that fsetfilecon call useful, since your example must
also handle an existing destination file?
It's easier to see with a little more context, and knowing that
*new_dst is set when the destination file is guaranteed not to exist.
Here's a snippet from coreutils-6.7 + Red Hat's coreutils-selinux.patch,
+ my // comment:

  if ( ! *new_dst)
    {
      // DST_NAME *may* already exist
      dest_desc = open (dst_name, O_WRONLY | O_TRUNC | O_BINARY, dst_mode);

#ifdef WITH_SELINUX
      if (dest_desc >= 0 && selinux_enabled &&
	  (x->preserve_security_context || x->set_security_context))
	{
	  security_context_t con;
	  if(getfscreatecon(&con) == -1)
	    {
	      return_val = false;
	      goto close_src_desc;
	    }

	  if (con)
	    {
	      if(fsetfilecon(dest_desc, con) == -1)
		{
		  return_val = false;
		  freecon(con);
		  goto close_src_desc;
		}
	      freecon(con);
	    }
	}
#endif

This is a good opportunity to ask about an old note I made:
  - is it worthwhile to check for getfscreatecon failure?
    The documentation says it can fail, but not how.
    Even it's truly a "can't happen" condition now, that might change.

I presume the lack of a diagnostic for failed fsetfilecon
is just an oversight.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
