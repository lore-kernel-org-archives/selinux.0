Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UCRarT026637
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 08:27:36 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6UCR5Tf019683
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 12:27:05 GMT
Subject: Re: pear-shaped behaviour after enough make reloads
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040729221824.GR9950@lkcl.net>
References: <20040728211229.GB18711@lkcl.net>
	 <1091126965.21971.160.camel@moss-spartans.epoch.ncsc.mil>
	 <20040729202419.GI9950@lkcl.net>
	 <1091133123.21971.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20040729221824.GR9950@lkcl.net>
Content-Type: text/plain
Message-Id: <1091190420.21245.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 30 Jul 2004 08:27:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 18:18, Luke Kenneth Casson Leighton wrote:
> for completeness on list, i should mention that i was modifying
> policy files during the make reloads.
> 
> stephen mentioned that apparently if inodes are using a SID
> that is deleted, no amount of subsequent make reloads will
> reattach the SID to that inode.
> 
> what happened because of what i was doing to my computer "fits"
> with this explanation.

Note that the invalidation of security contexts should have been logged
in /var/log/messages upon the policy reload, e.g.
cd /etc/selinux/strict/src/policy
echo "type foo_t, file_type, sysadmfile;" > domains/misc/local.te
touch /tmp/foo
chcon -t foo_t /tmp/foo
rm domains/misc/local.te
make clean load

will yield the following in /var/log/messages or dmesg output for the
final load:
security:  5 users, 7 roles, 1302 types, 2 bools
security:  52 classes, 319241 rules
security:  invalidating context root:object_r:foo_t

At this point, the kernel will treat any incore inodes (or processes, if
this were a domain rather than a file type) that had the type as having
the unlabeled SID, and start denying access.  A ls -Z /tmp/foo will
still show the original context (root:object_r:foo_t), because it is
simply using getxattr to get the extended attribute value from the disk,
and this has not changed, but the kernel no longer has any way of
mapping this value to a meaningful representation in the policy.  But
re-adding the type to the policy won't immediately update the incore
inode's SID; that won't happen until the inode is evicted and
re-instantiated or someone explicitly "relabels" it (but note that chcon
and setfiles likely won't touch it, as they will still see the extended
attribute value as being correct already and refrain from relabeling
it).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
