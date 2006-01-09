Subject: Re: MLS/MCS Constraints causing problems for unconfined_t.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43C28BB0.1070601@redhat.com>
References: <43C28BB0.1070601@redhat.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 11:40:20 -0500
Message-Id: <1136824820.19934.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-01-09 at 11:13 -0500, Daniel J Walsh wrote:
> Currently unconfined_t can not read the pid of certain domains in 
> targeted policy that are running at s0-s0:c0.c255
> For instance audit2allow will give the following after a reboot. since 
> the shutdown process tries to killall processes and reads these.
> 
> allow unconfined_t auditd_t:file read;
> allow unconfined_t crond_t:file read;
> allow unconfined_t cupsd_t:file read;
> allow unconfined_t hald_t:file read;
> allow unconfined_t udev_t:file read;
> allow unconfined_t self:file read;
> allow unconfined_t xdm_t:file read;
> 
> Also if a sysadm run top it will generate this kind of AVC messages.  
> These are somewhat expected, should we dontaudit these?  Will dontaudit 
> work on an MLS Constraint failure?

For MCS, the obvious question is why are these domains running ranged?
For MLS, is unconfined_t used?

dontaudit will suppress audit messages caused by a constraint if the
types and class match.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
