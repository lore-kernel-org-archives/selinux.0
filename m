Date: Fri, 29 Oct 2004 16:28:40 -0700
From: Nifty Hat Mitch <mitch48@sbcglobal.net>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Proposed patch for libselinux  -- xdr ???
Message-ID: <20041029232840.GA23710@xtl1.xtl.tenegg.com>
References: <41782BBA.9090101@redhat.com> <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 22, 2004 at 08:48:39AM -0400, Stephen Smalley wrote:
> > diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c...
....
> Directly storing an integer in the xattr?  Endianness issues; you need
> to convert to a particular ordering before setting and convert back when
> getting.

I am a little late to this party...
Should xdr be specified for data in cases like this?

If all the data had an external data representation specification (man
xdr) then the right thing could happen.

In the world of storage area networks this could be an interesting
topic when the raw bits of the disk are exposed to hardware with
different data representations.



-- 
	T o m  M i t c h e l l 
	May your cup runneth over with goodness and mercy
	and may your buffers never overflow.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
