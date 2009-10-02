Subject: Re: How to trace why MCS permissions granted?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@udmvt.ru
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20091002154012.GT4221@ruber.office.udmvt.ru>
References: <20091002154012.GT4221@ruber.office.udmvt.ru>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 12:07:23 -0400
Message-Id: <1254499643.30591.346.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-10-02 at 20:40 +0500, selinux@udmvt.ru wrote:
> Hello, everyone.
> I'm just playing with MCS and trying to understand the system's behavior.
> 
> As far as I have read the theory, categories can be used to limit unwanted user's
> access to your data. So, I am trying to create a file, mark it with a category,
> first time - the same as the process has. Then I write there some data and read it back.
> That works OK and is as expected.
> But when I change file's category to some other, that my testing process don't have,
> to prevent the process from accessing that file, I discover that the process may read,
> but cannot write (append) to that file:
> 
> 	root@selinux1:/tmp# id
> 	uid=0(root) gid=0(root) groups=0(root) context=root:sysadm_r:sysadm_t:s0:c0
> 	root@selinux1:/tmp# ls -laZ test
> 	-rw-r--r-- 1 root root system_u:object_r:sysadm_tmp_t:s0:c1   9 Oct  3 00:44 test
> 	root@selinux1:/tmp# cat test
> 	asfasdaf
> 	root@selinux1:/tmp# cat >> test
> 	bash: test: Permission denied
> 	root@selinux1:/tmp# setenforce 0
> 	root@selinux1:/tmp# cat >> test
> 	blabla
> 	root@selinux1:/tmp# cat test
> 	asfasdaf
> 	blabla
> 
> When the process is at s0:c0, the file is at s0:c1, and in enforcing mode I expect
> to have no access at all.
> 
> I can only guess, that sysadm_t is in some way marked as a special type for
> bypassing MCS constraints, but how can I proof/check that?
> And if that is true, I still expect to have all access or no access at all,
> but not the read only access.
> Please, if there is nothing wrong with what I am seeing, tell where can I read
> about that more?

sysadm.te calls userdom_security_admin_template().
userdom_security_admin_template() calls mls_file_read_all_levels().
mls_file_read_all_levels() declares the type as having the mlsfileread
type attribute.

policy/mcs says:
mlsconstrain file { read }
        (( h1 dom h2 ) or ( t2 == domain ) or ( t1 == mlsfileread ));

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
