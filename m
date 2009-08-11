Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7B46wQu013996
	for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2009 00:06:58 -0400
Received: from mail-yw0-f204.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7B46SWO025103
	for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2009 04:06:28 GMT
Received: by ywh42 with SMTP id 42so5536987ywh.30
        for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 21:06:57 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 10 Aug 2009 21:06:57 -0700
Message-ID: <dd18b0c30908102106uf722cf7qfb7ba0afee9fc1d@mail.gmail.com>
Subject: refpolicy doesnt see ext4 but fix_files does
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

seems Ive hit yet another interesting thing
(the perils of creating my own system)

in refpolicy sudo make relabel
(shows this)

Relabeling filesystem types: ext2 ext3 xfs jfs
No filesystems with extended attributes found!
make: *** [relabel] Error 1

kernel .config does have ext4 built-in
ext3,ext2 are not built-in(only modules).

fixfiles relabel shows:


    Files in the /tmp directory may be labeled incorrectly, this command
    can remove all files in /tmp.  If you choose to remove files from /tmp,
    a reboot will be required after completion.

    Do you wish to clean out the /tmp directory [N]? y
Cleaning out /tmp
/bin/rm: cannot remove `/tmp/.X11-unix': Is a directory
filespec_add:  conflicting specifications for /usr/bin/getconf and
/usr/lib64/glibc/getconf/POSIX_V7_LP64_OFF64, using
system_u:object_r:lib_t.
filespec_add:  conflicting specifications for /usr/bin/git and
/usr/lib64/git-core/git-annotate, using system_u:object_r:lib_t.
find: unknown predicate `-context'
find: unknown predicate `-context'

(seems to have relabeled as should)

the partition scheme is simple:
all ext4 for testing(and a swap on the side!!).



-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
