Subject: Re: Question - dac_override/dac_read_search
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109931547.5232.1.camel@cobra.ivg2.net>
References: <1109931547.5232.1.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 16:03:10 -0500
Message-Id: <1110229390.3964.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-03-04 at 05:19 -0500, Ivan Gyurdiev wrote:
> I've seen these before, and here they are again.
> What causes those denials, and how can I fix them in general?
> 
> This specific case is running depmod -a as root.
> 
> audit(1109930761.807:0): avc:  denied  { dac_override } for  pid=4678
> exe=/sbin/depmod capability=1 scontext=root:sysadm_r:depmod_t
> tcontext=root:sysadm_r:depmod_t tclass=capability
> 
> audit(1109930761.807:0): avc:  denied  { dac_read_search } for  pid=4678
> exe=/sbin/depmod capability=2 scontext=root:sysadm_r:depmod_t
> tcontext=root:sysadm_r:depmod_t tclass=capability

Happens when the program attempts to access a file in a way that
violates the DAC permissions, i.e. file mode bits.  Commonly occurs when
a root process is running in a user directory or operating on a user
file, as it may need to override DAC to access the directory or file.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
