Subject: Re: Manual pages for utilities in libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <87r7iksfb2.fsf@glaurung.internal.golden-gryphon.com>
References: <87r7iksfb2.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 09:19:33 -0500
Message-Id: <1110896373.25947.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-03-12 at 15:52 -0600, Manoj Srivastava wrote:
> Hi,
> 
>         While packaging the new version of sepol-utils for Debian, I
>  noticed that the utilities chkcon and genpolusers had no manual
>  pages. I have added the following (trivial) man pages for them (patch
>  appended).

Thanks, merged.  I also added a man page for sepol_genusers(3) since
Ivan pointed out that was missing as well.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
