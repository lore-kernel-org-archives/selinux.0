Subject: Re: New patch for libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44981564.9020106@redhat.com>
References: <4497FCCF.1030805@redhat.com>
	 <1150812243.17557.79.camel@moss-spartans.epoch.ncsc.mil>
	 <44981564.9020106@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 12:49:40 -0400
Message-Id: <1150822180.17557.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-20 at 11:33 -0400, Daniel J Walsh wrote:
> Patch to libselinux to fix handling of MATCHPATHCON_NOTRANS.
> 
> Also added two new functions to handle looking at files on disk and 
> comparing to the default file_contexts,  These functions are
> intended to be used by rpm -V.

I don't think we want to directly export
selinux_compare_context_without_user(), or if we do, we want it
abstracted in some manner that covers the general case.

Also, I think selinux_verify_file_context needs to be generalized,
because if/when rpm begins to use contexts from the rpm headers again,
then rpm will need to pass in the context against which to compare
rather than having selinux_verify_file_context always use matchpathcon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
