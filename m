Message-Id: <20060803200928.721027000@flek.zko.hp.com>
Date: Thu, 03 Aug 2006 16:09:28 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: linda.knippers@hp.com, sds@tycho.nsa.gov, jmorris@namei.org,
        davem@davemloft.net
Subject: [PATCH-v01 0/7] Latest NetLabel patchset against net-2.6.19
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the NetLabel patchset backed against DaveM's net-2.6.19 tree.  The
major changes from the last version have been the conversion to the new LSM
hooks that were introduced with the MLSXFRM patchset and the shift to using
Netlink attributes.  I've also done some work to reduce the amount of overhead
when categories are used.

Please consider this for inclusion into 2.6.19.

For those of you who are testing this patch, due to the shift to Netlink
attributes you will need to get the latest netlabel_tools package, version
0.16.  The netlabel_tools can be downloaded here:

 * http://free.linux.hp.com/~pmoore/projects/linux_cipso

Thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
