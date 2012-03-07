Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q27GP0mJ005983
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2012 11:25:00 -0500
Received: by vcge1 with SMTP id e1so4760294vcg.12
        for <selinux@tycho.nsa.gov>; Wed, 07 Mar 2012 08:24:59 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 7 Mar 2012 11:24:59 -0500
Message-ID: <CAD8iFzxwJSwJ+LGzByLN9sskyy5UiW-6zGWNOmJ0Fu6X1_EsbQ@mail.gmail.com>
Subject: SEAndroid make_ext4fs fails with new changes
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I synced SE Android code this morning, facing some issues with
make_ext4fs, here is the log

make_ext4fs -s -S out/target/product/maguro/root/file_contexts -l
14539537408 -a data out/target/product/maguro/userdata.img
out/target/product/maguro/data
Creating filesystem with parameters:
    Size: 14539534336
    Block size: 4096
    Blocks per group: 32768
    Inodes per group: 8144
    Inode size: 256
    Journal blocks: 32768
    Label:
    Blocks: 3549691
    Block groups: 109
    Reserved block group size: 871
error: make_ext4fs_internal: cannot lookup security context for /data

Is anyone else facing the same issue?

Regards,
Subbu

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
