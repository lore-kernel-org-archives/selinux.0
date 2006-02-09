Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <1139501636.10222.11.camel@localhost>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139501636.10222.11.camel@localhost>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 13:13:25 -0500
Message-Id: <1139508805.2872.234.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 10:13 -0600, Timothy R. Chavez wrote:
> On Thu, 2006-02-09 at 09:58 -0500, James Morris wrote:
> > Please look at the way I intend to export SELinux APIs in:
> > http://people.redhat.com/jmorris/selinux/skfilter/kernel/12-skfilter-selinux-exports.patch
> 
> This looks good.  Do you have a schedule for releasing this?  I could
> probably wait until it becomes available in -mm before changing out the
> API plumbing.

Note btw that the advantage of the security_sid_to_context() interface
(wrapped by James' selinux_id_to_ctx interface) is that it internally
allocates a buffer of the right length for you.  You don't have to query
for a length and allocate one yourself, unlike the selinux_getsecurity
interface.  You do still need to free it when done.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
