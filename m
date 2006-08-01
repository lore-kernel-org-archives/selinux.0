Subject: Re: gnuTAR support for SELinux context (beta)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1154453240.2103.27.camel@code.and.org>
References: <1154453240.2103.27.camel@code.and.org>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 14:28:29 -0400
Message-Id: <1154456909.3582.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 13:27 -0400, James Antill wrote:
>  This is just a quick note to let you know that we've got beta
> packages[1] for creating/extracting tar archives with SELinux context in
> them (note that these packages are also based on rawhide, so will have
> other changes).
>  This should be able to extract any archives you've previously made with
> star.
> 
>  You can create archives with just selinux context information by using
> --selinux, or with full xattr support using --xattrs. In a similar vein
> you can ignore any selinux context information by using --no-selinux
> when you extract, or --no-xattrs to ignore all xattr information.
> 
> [1] http://people.redhat.com/jantill/

What about just saving the selinux contexts by default if they are
present on the files being archived (and likewise extracting them by
default if present in the archive)?  Otherwise, users have to take
explicit action to save and restore the file contexts and will continue
to "lose" them by default.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
