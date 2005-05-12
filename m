Subject: Strange trace - tty problems
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 12 May 2005 01:10:26 -0400
Message-Id: <1115874626.18756.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


What's this? Prior to this I was updating 400+ packages,
cleaning bad repositories (so no more false httpd execmem bugs),
updating the policy, and doing a restorecon -R /. 

Then I couldn't open any terminals. Logging out of X 
and back in let me open terminals just fine.

Is this selinux related?

audit(1115874036.581:0): avc:  granted  { setenforce } for
scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:security_t
tclass=security
idr_remove called for id=0 which is not allocated.
 [<c020e872>] sub_remove+0x86/0xe6
 [<c02598b7>] release_dev+0x5d8/0xa0c
 [<c020e8ea>] idr_remove+0x18/0x75
 [<c02598ec>] release_dev+0x60d/0xa0c
 [<c017bf88>] do_sync_write+0x9e/0xec
 [<c01f33f8>] avc_has_perm+0x4e/0x66
 [<c013fff2>] autoremove_wake_function+0x0/0x37
 [<c025a2db>] tty_release+0x7/0xa
 [<c017ce33>] __fput+0x4b/0xfa
 [<c017b620>] filp_close+0x4f/0x6d
 [<c0103a61>] syscall_call+0x7/0xb

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
