Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7IFU7fU015965
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2010 11:30:07 -0400
Received: from g1t0026.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7IFTxjC019612
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2010 15:29:59 GMT
Subject: RE: Problem about audit-test-2090 + refpolicy-2.20091117
From: Paul Moore <paul.moore@hp.com>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
In-Reply-To: <SNT139-w499FFC8245BD574722F9F6AB9D0@phx.gbl>
References: <SNT139-w318948F5C7E5124B30AB6AAB9D0@phx.gbl>
	 ,<1282132367.4122.8.camel@flek>
	 <SNT139-w499FFC8245BD574722F9F6AB9D0@phx.gbl>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 18 Aug 2010 11:29:53 -0400
Message-ID: <1282145393.4122.45.camel@flek>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-08-18 at 13:24 +0000, TaurusHarry wrote:
> Many many thanks for your response!
>  
> Well, after I installed SELinux header properly then I did could enter
> audit-test/utils/selinux-policy/ successfully built lspp_test.pp
> there, however, I run into below error messages when trying to insert
> it:
>  
> [root/secadm_r/s0@qemu-host selinux-policy]# semodule -i lspp_test.pp
> libsepol.expand_terule_helper: conflicting TE rule for
> ( lspp_test_generic_t, sepgsql_db_t:db_table): old was
> user_sepgsql_table_t, new is sepgsql_table_t
> libsepol.expand_module: Error during expand
> libsemanage.semanage_expand_sandbox: Expand module failed
> semodule: Failed!
> [root/secadm_r/s0@qemu-host selinux-policy]#
>  
> Very honestly speaking I am clueless about such error message, so I
> tried to compile lspp_test.pp along with refpolicy source code just to
> see if such problem could simply disappear. Do you have some comments
> or suggestions about it? 

Hmm, it looks like perhaps there is a conflict with the sepostgres
policy?  I'm not sure, I haven't built this policy on recent versions of
the refpolicy.  I've heard rumors that some of the RH guys are running
audit-test on recent versions of Fedora/RHEL6 but I don't know if that
includes all of the LSPP bits, e.g. the lspp_test policy module.
 
If you want to play with SELinux policy, we're always accepting
patches :)

> Moreover, the audit-test-2090 seems to be a little "old" than the
> refpolicy-2.20091117, for example, the lspp_test.te calls
> mls_file_read_up() rather than the expected
> mls_file_read_all_levels(), do you know if I could find some latest
> version of audit-test package or some latest version of the
> lspp_test.* files?

You can always find the latest bits in the audit-test SVN repo on
sf.net, however, I must admit that currently we've only tested it
against RHEL5.x and some older Fedora releases.

-- 
paul moore
linux @ hp




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
