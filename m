Subject: Re: [PATCH 032/155] policycoreutils: fixfiles use new kernel
 seclabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, eparis@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <CACLa4pt+cB441dB=oE3_aF=ddV+dP2BiAOUmJd18qaxGFOnKZQ@mail.gmail.com>
References: <4E39B680.4000106@redhat.com>
	 <1312469885.20973.54.camel@moss-pluto>
	 <CACLa4pt+cB441dB=oE3_aF=ddV+dP2BiAOUmJd18qaxGFOnKZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Aug 2011 14:44:03 -0400
Message-ID: <1313174643.19123.153.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-08-12 at 14:22 -0400, Eric Paris wrote:
> On Thu, Aug 4, 2011 at 10:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2011-08-03 at 16:58 -0400, Daniel J Walsh wrote:
> 
> >> This patch looks good to me. acked.
> >
> > When similar logic was added to setfiles, we included a kernel version
> > check (>= 2.6.30) to ensure that we didn't end up excluding all
> > filesystems on older kernels that do not report seclabel.
> 
> Patch replaced with the attached.

Your version comparison isn't quite right, e.g. consider 2.2.30.
If you want a reliable version compare, you probably want to do
something similar to KERNEL_VERSION() from include/linux/version.h and
convert both versions to simple integers that can be compared.  Or you
could do something based on this gem:
http://rubinium.org/blog/archives/2010/04/05/shell-script-version-compare-vercmp/

Or just rewrite fixfiles in a reasonable language ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
