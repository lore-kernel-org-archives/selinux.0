Subject: Re: Proposed patch for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>
In-Reply-To: <20041026142126.GC8053@lkcl.net>
References: <41782BBA.9090101@redhat.com>
	 <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041022155639.GA4986@lkcl.net> <41796C01.4060909@redhat.com>
	 <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
	 <20041026142126.GC8053@lkcl.net>
Content-Type: text/plain
Message-Id: <1098799981.27060.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 26 Oct 2004 10:13:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-26 at 10:21, Luke Kenneth Casson Leighton wrote:
>  it would appear, therefore, that no provision has been made for
>  filesystem recovery.

star and (recently patched) rsync supports backing up security
attributes from live filesystems.

>  i find frequently that ext3 filesystem damage results in fsck.ext3
>  going "the extended attributes aren't valid: truncating".

I've never seen this.  Easily reproducible?

>  this leaves you with a (null) for an selinux access, as if you had
>  run your system with a non-selinux kernel and written some files.
> 
>  under such circumstances, i find that the only [simple] means
>  at present to recover such a damaged system is to run setfiles.

It seems that in that case, you would just want to relabel files that
have no label at all, not any files that already have labels.  It might
be reasonable to have an option to setfiles to cause it to only relabel
files that lack a SELinux attribute and leave all others intact.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
