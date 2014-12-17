Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBH9UCJE002771
 for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2014 04:30:12 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so14700687ieb.3
 for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2014 01:30:10 -0800 (PST)
Received: from ?IPv6:2001:470:8:c14:224:d7ff:fe24:7a9c?
 ([2001:470:8:c14:224:d7ff:fe24:7a9c])
 by mx.google.com with ESMTPSA id qc7sm7609541igb.5.2014.12.17.01.30.10
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Dec 2014 01:30:10 -0800 (PST)
Message-ID: <54914D21.9030800@gmail.com>
Date: Wed, 17 Dec 2014 04:30:09 -0500
From: Andrew Gunnerson <andrewgunnerson@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: "SELinux: ebitmap: truncated map" after editing with libsepol
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello all,

I have a very simple test program to help with debugging my Android
dual booting project. It reads the current policy from 
/sys/fs/selinux/policy,
changes a single type to be permissive, and then loads the new policy
by writing it to /sys/fs/selinux/load. The problem is, after editing the
policy with sepol, it fails to load and the kernel prints the following
message in dmesg: "SELinux: ebitmap: truncated map".

The program reads and writes the policy file using the standard fopen
and policydb_read/policydb_write calls. I then set a few types to be
permissive using the following loop:

     ...
     char *name;
     int is_permissive;
     char **types = (null terminated char* array)
     char **type;
     ...
     for (unsigned int i = 0; i < pdb->p_types.nprim - 1; i++) {
         name = pdb->p_type_val_to_name[i];
         is_permissive = ebitmap_get_bit(&pdb->permissive_map, i + 1);

         if (!is_permissive) {
             for (type = types; *type; type++) {
                 if (strcmp(*type, name) == 0) {
                     ebitmap_set_bit(&pdb->permissive_map, i + 1, 1);
                     break;
                 }
             }
         }
     }
     ...

I've been trying to debug this for many hours, but I can't seem to figure
out why this is happening. Is there a simple mistake I'm overlooking or
am I approaching this in a completely wrong way?

Thanks in advance! Any help is greatly appreciated!

Andrew Gunnerson


PS: This is running on Android 5.0 with libsepol 2.4-rc4 and kernel
3.4.0-g88fbc66.
