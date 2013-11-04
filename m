Message-ID: <52779F1F.5000701@tycho.nsa.gov>
Date: Mon, 04 Nov 2013 08:20:31 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: Dan Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 01/11] Add test suite for audit2allow and sepolgen_ifgen
References: <1383231238-7637-1-git-send-email-dwalsh@redhat.com> <1383231238-7637-2-git-send-email-dwalsh@redhat.com> <CAPzO=NxkH-M329OrNVhS4+-smHfwgG9fZXs8fwEyGkJ5NaNqdQ@mail.gmail.com>
In-Reply-To: <CAPzO=NxkH-M329OrNVhS4+-smHfwgG9fZXs8fwEyGkJ5NaNqdQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/02/2013 12:51 PM, Sven Vermeulen wrote:
> On Thu, Oct 31, 2013 at 3:53 PM, Dan Walsh <dwalsh@redhat.com> wrote:
>> +++ b/policycoreutils/audit2allow/test.log
>> @@ -0,0 +1,36 @@
>> +node=bill.example.com type=AVC_PATH msg=audit(1166045975.667:1128):  path="/usr/lib/libGL.so.1.2"
>> +type=AVC msg=audit(1166045975.667:1129): avc: denied { write } for comm=local dev=dm-0 name=root.lock pid=10581 scontext=system_u:system_r:postfix_local_t:s0 tclass=file tcontext=system_u:object_r:mail_spool_t:s0
>> +node=bob.example.com type=PATH msg=audit(1166111074.191:74): item=0 name="/etc/auto.net" inode=16483485 dev=fd:00 mode=0100755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:automount_lock_t:s0 type=CWD msg=audit(1166111074.191:74):  cwd="/"
>> +node=bob.example.com type=SYSCALL msg=audit(1166111074.191:74): arch=40000003 syscall=33 success=no exit=-13 a0=92c5288 a1=1 a2=154d50 a3=92c5120 items=1 ppid=13935 pid=13944 auid=3267 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) comm="automount" exe="/usr/sbin/automount" subj=system_u:system_r:automount_t:s0 key=(null)
> 
> Aren't those tests only possible when SELinux is enabled and the
> policy modules for the given types (such as automount_lock_t,
> mail_spool_t, ...) are loaded?
> 
> Also, it seems like the test only supports MLS-enabled policies; in
> Gentoo we also support non-MLS policies.
> 
> May I suggest to
> - have a test-mls.log and test-nonmls.log with the AVC information
> specific for those policies
> - use only types that are part of a base policy (and not have types in
> there that might not be available on a system)
> - only run the test if SELinux is enabled and a policy is loaded

audit2allow can take a specified policy file via the -p option, so these
tests should be usable even on a non-SELinux host.  Whether or not they
presently are I haven't checked but it should be possible to make them
so if we include a policy file in the test directory and point
auditallow at it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
