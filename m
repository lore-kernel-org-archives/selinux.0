Subject: Re: [redhat-lspp] How to build test policy now?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Michael C Thompson <mcthomps@us.ibm.com>
In-Reply-To: <1141919502.6157.286.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <OFA90E9CB1.2C1B7BDC-ON87257125.006DE3FA-86257125.006DC18C@us.ibm.com>
	 <44104A9D.6080308@redhat.com>
	 <1141919502.6157.286.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 10:53:08 -0500
Message-Id: <1141919588.6157.288.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-09 at 10:51 -0500, Stephen Smalley wrote:
> For which object class?  For files, relabelfrom means "Can domain D
> relabel a file from (i.e. currently in) type T1?" and relabelto means
> "Can domain D relabel a file to type T2?", so both checks are applied
> upon a file relabeling, where T1 is the original type of the type

Sorry, the above should be "original type of the file", obviously.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
