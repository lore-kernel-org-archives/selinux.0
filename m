Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9DNUIM3018184
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 19:30:18 -0400
Received: from mail-px0-f198.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9DNVwH3007639
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 23:31:59 GMT
Received: by pxi36 with SMTP id 36so598357pxi.18
        for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 16:30:16 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 13 Oct 2009 16:30:15 -0700
Message-ID: <ddbc00640910131630l35dd9552g385a8df02771a464@mail.gmail.com>
Subject: sesearch question
From: Joe Nall <joe@nall.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I use sesearch I appear to be seeing allow rules that are in
tunables that are off. The rules below come from
auth_manage_all_files_except_shadow which is in a disabled tunable.

joe

--
sesearch -A -t jcdx_icm_var_t /etc/selinux/mls/modules/active/base.pp
/etc/selinux/mls/modules/active/modules/*pp
...
   allow nfsd_t { file_type -shadow_t } : dir { ioctl read getattr
lock search } ;
   allow nfsd_t { file_type -shadow_t } : file { ioctl read getattr lock } ;
   allow nfsd_t { file_type -shadow_t } : dir { getattr search } ;
...

--

getsebool -a | grep nfs_export_all_rw
nfs_export_all_rw --> off

--

tunable_policy(`nfs_export_all_rw',`
        fs_read_noxattr_fs_files(nfsd_t)
        dev_getattr_all_blk_files(nfsd_t)
        dev_getattr_all_chr_files(nfsd_t)
        auth_manage_all_files_except_shadow(nfsd_t)
        #unprivuser_home_dir_filetrans_home_content(nfsd_t, { file dir })
')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
