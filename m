Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9LNp8p024732
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 16:23:51 -0500
Received: from palrel12.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA9LNnuu012218
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 21:23:50 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 00/13] Labeled networking patches
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Fri, 09 Nov 2007 16:23:44 -0500
Message-ID: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an update to the patcheset sent earlier this week and the first time
these patches have been sent to the LSM list.  The most notable change
between this patchset and the "v5" patches is the addition of the
fallback/static label patches that were discussed on the SELinux list a few
months ago.  In addition to just porting the old fallback/static patches I've
added the concept of a "default" interface as well as some intelligence in
the SELinux layer to allow the NetLabel provided fallback label to play
nicely with XFRM labels when both are present on a connection.  This should
help address issues found in the earlier versions of the fallback/static
label patches.  This patchset does not include Venkat's flow control patches,
but Venkat has promised that they will be ready very soon; when they are I
will merge them into this patchset.  On a similar note, the new "peer"
SELinux object class in this patchset isn't usable with currently released
SELinux policies so you'll still be using the separate, labeling protocol
specific, access checks.

I have to caution against using these patches for anything critical as they
are still a "work in progress" and have only received minimal testing.
However, I know there are a few of you who are very interested in this
functionality and have offered to help with the testing so I'm posting the
patches in this early state so we can get a jump shaking the bugs out.  For
those of you who are playing with these patches, there are a few things worth
noting:

 * You can do a pull down a complete git tree with these changes here:
   -> git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

 * You should probably also apply this patch to fix an unrelated panic:
   -> http://git.kernel.org/?p=linux/kernel/git/jmorris/selinux-2.6.git;a=commitdiff;h=6d2b685564ba417f4c6d80c3661f0dfee13fff85

 * You'll need the latest SVN (rev 49 or higher) of the static_label branch
   of netlabel_tools to make use of the new fallback/static label features:
   -> http://netlabel.svn.sourceforge.net/viewvc/netlabel/netlabel_tools

To configure the new fallback/static labels you use the following netlabelctl
commands:

 * Add a label
    "netlabelctl unlbl add default|interface:<DEV> address:<ADDR>[/<MASK>] \
                                                  label:<LABEL>"
      DEV = interface
      ADDR = IP address
      MASK = size of address mask
      LABEL = full SELinux context

      Examples:
      # netlabelctl unlbl add default address:10.0.0.0/8 \
                                      label:system_u:object_r:unlabeled_t:s0
      # netlabelctl unlbl add interface:eth0 address:192.168.0.1 \
                                      label:system_u:object_r:unlabeled_t:s0
      # netlabelctl unlbl add interface:lo address:::1 \
                                      label:system_u:object_r:unlabeled_t:s0

 * Remove a label
    "netlabelctl unlbl del default|interface:<DEV> address:<ADDR>[/<MASK>]"
      DEV = interface
      ADDR = IP address
      MASK = size of address mask

      Examples:
      # netlabelctl unlbl del default address:10.0.0.0/8
      # netlabelctl unlbl del interface:eth0 address:192.168.0.1
      # netlabelctl unlbl del interface:lo address:::1

 * Show labels
    "netlabelctl -p unlbl list"

      Examples:
      # netlabelctl unlbl list
      # netlabelctl -p unlbl list

If you have any questions/problems/comments feel free to either drop me mail
privately or post something to the list.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
