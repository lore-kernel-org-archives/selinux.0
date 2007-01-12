From: Jim Meyering <jim@meyering.net>
To: James Antill <james.antill@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
In-Reply-To: <1168632626.13080.212.camel@code.and.org> (James Antill's message
	of "Fri, 12 Jan 2007 15:10:26 -0500")
References: <45A7D773.8040800@redhat.com>
	<1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	<1168632626.13080.212.camel@code.and.org>
Date: Fri, 12 Jan 2007 22:19:58 +0100
Message-ID: <87ps9keydd.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill <james.antill@redhat.com> wrote:
> On Fri, 2007-01-12 at 13:55 -0500, Stephen Smalley wrote:
>> On Fri, 2007-01-12 at 13:46 -0500, Daniel J Walsh wrote:

Thanks for the Cc.

...
>> First, I seem to recall debates about whether -p (and thus -a) should
>> automatically enable preservation of SELinux context or whether that
>> should remain a separate option only.  Pros and cons to both sides.
>
>  I never saw the original discussion, but I'm 99% sure I complained to
> Jim and/or Dan that cp -a/-p should do "the right thing" and preserve
> everything, when I was adding the xattr support.

If only "the right thing" worked in all cases.
FWIW, my cut at this[*] has cp -a still equivalent to cp -dpPR,
just like rawhide, below.

Do you know what motivated the "mode = acls[1] no" change below?
That introduces a new incompatibility with upstream.
Otherwise, upstream matches rawhide.

[*] I resumed work on my coreutils selinux merge recently, so you should
hear more about it soon -- on the bug-coreutils and bug-gnulib lists.

>  Note that the changes in question are not really consistent:
>
>                FC-5           FC-6            rawhide
>
> mode = acls[1] yes            yes             no
> -p             trad.          trad.           trad.+acls+xattrs
> -a             -dpPR          -dpPRc          -dpPR
> --preserve=all trad.+context  trad.+context   trad.+context+acls+xattrs
...
> [1] This means that preserving the "unix permission mode bits" implies
> preserving any ACLs.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
