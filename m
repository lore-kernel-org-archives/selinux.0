Subject: Re: can not boot with strict policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken YANG <spng.yang@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <462CA1F0.2000400@gmail.com>
References: <462CA1F0.2000400@gmail.com>
Content-Type: text/plain
Date: Mon, 23 Apr 2007 11:01:34 -0400
Message-Id: <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-23 at 20:09 +0800, Ken YANG wrote:
> hi all:
> 
> i run in FC7 Rawhide with strict policy, which is built from svn
> refpolicy:
> 
> TYPE = strict-mcs
> DIRECT_INITRC=y
> MONOLITHIC=n
> MLS_SENS=16
> MLS_CATS=1024
> MCS_CATS=1024
> 
> after i loaded the policy:
> 
> make && make install && make load && \
> "modify /etc/selinux/config to use new policy" && \
> touch /.autorelabel
> 
> 
> and reboot, but "kernel panic" occur:
> 
> "......
> avc: denied {execute} for pid=1 comm="init" name="libsepol.so.1"
> scontext=system_u:system_r:init_t:s0 tcontext=user_u:object_r:lib_t:s0
> tclass=file

/lib/libsepol.so.1 should be labeled with shlib_t, not lib_t.  Under
targeted policy, they are aliases for one another.  Under strict, they
are separate types.

Boot with "enforcing=0 single" to come up permissive into single-user
mode, then run /sbin/fixfiles relabel -F to forcible relabel everything,
then reboot.

Of course, I assume you have set the other build.conf settings
appropriately for Fedora.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
