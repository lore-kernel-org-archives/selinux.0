Message-ID: <1340194736.30096.31.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] ion fix
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 20 Jun 2012 08:18:56 -0400
In-Reply-To: <CAFftDdr+nvC3e1bJ62cdB-TWcDeA36QfmrGi3OqTb+oPJ-tqjg@mail.gmail.com>
References: 
	<CAFftDdr+nvC3e1bJ62cdB-TWcDeA36QfmrGi3OqTb+oPJ-tqjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-06-19 at 19:43 -0700, William Roberts wrote:
> 
> 
> Attached is a patch file that fixes Media Server denial when
> accessing /dev/ion
> 
> 
> Since it is for all ICS devices, I put it in external/sepolicy.
> 
> 
> http://lwn.net/Articles/480055/

Thanks, applied.  Are you sure only mediaserver requires access to it
though?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
