Subject: RE: Recurring SELinux events for similar violations...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D042DC13A@de01exm68.ds.mot.com>
References: <C3357D99.2F091%csellers@tresys.com>
	 <1192356878.3376.3.camel@vogon> <47135FCE.5000403@redhat.com>
	 <1192467177.28762.7.camel@blentz>
	 <1192467538.29203.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4713B257.9020409@redhat.com>
	 <1192473631.29203.56.camel@moss-spartans.epoch.ncsc.mil>
	 <1192475354.2910.14.camel@localhost.localdomain>
	 <1192650454.20908.30.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D040E2506@de01exm68.ds.mot.com>
	 <7e0fb38c0710171518r645c1ce1l3e0653109f2d27b2@mail.gmail.com>
	 <D06FE0A2807BC145B0D38744789D4F5D040E251B@de01exm68.ds.mot.com>
	 <1192713224.32671.11.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D042DC0D5@de01exm68.ds.mot.com>
	 <1196367400.24040.59.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D042DC13A@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 16:32:22 -0500
Message-Id: <1196371942.24040.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-29 at 16:26 -0500, Hasan Rezaul-CHR010 wrote:
> Hi Stephen,
> 
> Thanks as always for your response  :-)
> 
> I have already created a set of allow rules necessary. So we're using
> SELinux is to capture info about EVERY attempt an unauthorized/rogue
> user makes to access something they're NOT supposed to! So the reason I
> want to see the DENY events in audit.log, is *NOT* for creating
> corresponding allow rules. 
> 
> The "frequent periodic violation" I was referring to is as follows:
> 
> type=AVC msg=audit(1196369398.427:126): avc:  denied  { read } for
> pid=1040 com
> m="klogd" name="kmsg" dev=proc ino=-268435446
> scontext=system_u:system_r:kernel_
> t:s0 tcontext=system_u:object_r:proc_kmsg_t:s0 tclass=file

So you never transitioned out of kernel_t (initial kernel task and
kernel threads) into appropriate domains for userland (starting with a
transition to init_t upon /sbin/init, init_exec_t).  Normally klogd
would run in klogd_t, and the above would be allowed by policy.

> With [ /avc/cache_threshold = 0 ], the above event keeps popping up in
> audit.log every second !  I would like to create an allow rule, to get
> rid of this event. When I used audit2allow to generate the allow rule, I
> got:
> 
> allow kernel_t proc_kmsg_t:file read
> 
> 
> However, the base policy I am using as my starting policy is the
> *STRICT* Fedora Core 6 policy. And with that in place, when I try to
> insert this allow rule using (semodule -i myPolicy.pp), I get an
> assertion failure for that allow rule!!! So seems like the base policy
> wont let me insert this allow rule  :-(

Which is good, because it indicates a more fundamental problem - you've
got a mislabeled klogd process.

But suppose that wasn't the case and you truly wanted to allow that.
Here is how you would do it:
1) Look for a refpolicy interface that grants access to kmsg.  In a
modern policy, that appears to be kernel_read_messages().  Then write
your policy module using that interface, ala:
$ vi myklogd.te
policy_module(myklogd, 1.0)
require {
	type kernel_t;
}
kernel_read_messages(kernel_t)
:wq
$ make -f /usr/share/selinux/devel/Makefile
$ su
# /usr/sbin/semodule -i myklogd.pp

The refpolicy interface contains the 'magic' needed to override this
assertion, namely adding an attribute to the kernel_t type.  This
ensures that you made a conscious decision to give access to this
security-relevant resource and didn't accidentally do it via
audit2allow.

-or-
2) Disable assertion checking by libsemanage (not recommended, mostly
for developers, but if you need it, it exists):
$ su 
# vi /etc/selinux/semanage.conf
:$
i
expand-check=0
:wq

> So that is my dilemma.
> With cache_threshold = 0,  I get all the denies I want to see. But I
> also get these extra denies that I cant get rid off  :-(

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
