Date: Wed, 28 Aug 2002 16:08:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel daemons runs in init_t
In-Reply-To: <200208281614.QAA28639@jazzband.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0208281607050.25057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, Carsten Grohmann wrote:

> with the new release, all kernel daemons runs in the init_t domain.
> Is this a new feature or my mistake?
> But I don't found any anormaly.

As I explained previously, it depends on the parent of the kernel thread.
If the kernel thread's PPID is 1 (init), it should also be labeled with
init_t.  If the kernel thread's PPID is 0 (kernel), then it should also be
labeled with kernel_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
