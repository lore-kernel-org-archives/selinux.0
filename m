Subject: Re: Any idea why /proc/mtrr is marked as mtrr_device_t?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1154440486.3582.98.camel@moss-spartans.epoch.ncsc.mil>
References: <44CF54EE.7040202@redhat.com>
	 <1154438882.3582.79.camel@moss-spartans.epoch.ncsc.mil>
	 <44CF5A49.2020703@redhat.com>
	 <1154440486.3582.98.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 10:01:46 -0400
Message-Id: <1154440906.31522.100.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 09:54 -0400, Stephen Smalley wrote:
> On Tue, 2006-08-01 at 09:42 -0400, Daniel J Walsh wrote:
> > Stephen Smalley wrote:
> > > See Documentation/mtrr.txt in the kernel tree.
> > >
> > >   
> > So labeling a file as a device_t is ok?
> > 
> > In strict policy xserver wants to write to it
> 
> Yes, X needs access to it, and that rule existed in the old example
> policy.  Does refpolicy lack it?

Looks like a bug in the interface.  Xserver has dev_rw_mtrr(), but the
interface had mtrr_device_t:chr_file perms but was missing access for
the file class.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
