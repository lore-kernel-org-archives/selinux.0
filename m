Message-Id: <20061009194223.402695000@hp.com>
Date: Mon, 09 Oct 2006 15:42:23 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: vyekkirala@TrustedCS.com, jmorris@namei.org, sds@tycho.nsa.gov
Subject: [PATCH 00/11] The _entire_ secid reconciliation patchset (tada!)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset represents all of the secid reconciliation work done thus far by
Venkat Yekkirala and myself; you will notice from the 'From:' lines that all of
the patches with the exception of one are his so please make sure you include
him in any replies.

While this patchset is new the patches it contains have been under discussion
for several weeks now, and for those of you following the discussions here and
on the SELinux mailing lists you should not see any surprises here.  The
patchset includes the original nine patches from Venkat (I rolled his small
NETMSG update patch into these original nine as it made the most sense), the
fixup patch Venkat posted this morning, and my patch to add the missing
NetLabel support.  Those who look closely may notice that I have made slight
changes to Venkat's patches; these changes were made so the patch applied
cleanly to the latest net-2.6 git tree and compiled without warnings.  Venkat
and I have discussed these changes and he approves of them.

Please consider this for inclusion into 2.6.20.  If it's too soon to be
thinking of 2.6.20 let me know and I'll rebase/resend this patchset once I see
notice of David's net-2.6.20 git tree.

Thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
